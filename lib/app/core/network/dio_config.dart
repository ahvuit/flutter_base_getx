import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/storage/storage_service.dart';
import 'package:flutter_base_getx/app/core/widget/loading_dialog.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'rate_limiter.dart';

class DioConfig {
  /// Creates and configures a Dio instance with optional additional headers.
  static Dio createDio({Map<String, String>? additionalHeaders}) {
    final dio = Dio(BaseOptions(
      baseUrl: EnvConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        ..._defaultHeaders(),
        if (additionalHeaders != null) ...additionalHeaders,
      },
    ));

    dio.interceptors.addAll([
      _authInterceptor(),
      _rateLimitInterceptor(),
      _retryInterceptor(),
      _loadingInterceptor(),
      _loggingInterceptor(),
      // Uncomment the following line if SSL pinning is enabled
      // if (EnvConfig.instance.enableSSLPinning) _sslPinningInterceptor(),
    ]);

    return dio;
  }

  /// Returns the default headers for Dio requests.
  static Map<String, String> _defaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'App-Version': EnvConfig.instance.appVersion ?? '1.0.0',
      'Platform': Platform.isAndroid ? 'Android' : 'iOS',
    };
  }

  /// Interceptor for handling authentication.
  static Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final secureStorage = di.sl<StorageService>(instanceName: 'secure');
        final token = await secureStorage.read('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException e, handler) async {
        final logger = di.sl<CoreLogger>();
        if (e.response?.statusCode == 401) {
          logger.w('Unauthorized request, attempting to handle');
          // TODO: Add refresh token logic if needed
        }
        handler.next(e);
      },
    );
  }

  /// Interceptor for rate limiting requests.
  static Interceptor _rateLimitInterceptor() {
    final rateLimiter = di.sl<RateLimiter>();
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final canRequest = await rateLimiter.canRequest();
        if (canRequest) {
          handler.next(options);
        } else {
          final logger = di.sl<CoreLogger>();
          final nextTime = rateLimiter.nextAvailableTime;
          final message =
              'Rate limit exceeded. Try again at ${nextTime ?? 'later'}';
          logger.e(message);
          final error = DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 429,
              statusMessage: 'Too Many Requests',
              data: {'message': message},
            ),
            type: DioExceptionType.badResponse,
            error: message,
          );
          _reportToSentry(error);
          handler.reject(error);
        }
      },
    );
  }

  /// Interceptor for retrying failed requests.
  static Interceptor _retryInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException e, handler) async {
        final logger = di.sl<CoreLogger>();
        final retryCount = e.requestOptions.extra['retry_count'] ?? 0;
        const maxRetries = 3;

        if (retryCount < maxRetries && _shouldRetry(e)) {
          logger.w(
              'Retrying request (${retryCount + 1}/$maxRetries) due to: ${e.message}');
          e.requestOptions.extra['retry_count'] = retryCount + 1;
          await Future.delayed(const Duration(seconds: 1));
          try {
            final response = await Dio().fetch(e.requestOptions);
            handler.resolve(response);
          } catch (retryError) {
            handler.next(e); // Return original error if retry fails
          }
        } else {
          _reportToSentry(e);
          handler.next(e);
        }
      },
    );
  }

  /// Interceptor for showing and hiding loading dialogs.
  static Interceptor _loadingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final context =
            di.sl<GlobalKey<NavigatorState>>().currentState?.overlay?.context;
        if (context != null) {
          loadingDialog.show(context);
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        loadingDialog.hide();
        handler.next(response);
      },
      onError: (DioException e, handler) {
        loadingDialog.hide();
        handler.next(e);
      },
    );
  }

  /// Interceptor for logging requests and responses.
  static Interceptor _loggingInterceptor() {
    final logger = di.sl<CoreLogger>();
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode || EnvConfig.instance.flavor == Flavor.dev,
      logPrint: (message) => logger.d(message),
    );
  }

  // Uncomment the following method if SSL pinning is enabled
  // static Interceptor _sslPinningInterceptor() {
  //   return HttpCertificatePinningInterceptor(
  //     allowedSHAFingerprints: EnvConfig.instance.sslFingerprints,
  //     onCheckCertificate: (request, isTrusted) {
  //       final logger = di.sl<CoreLogger>();
  //       if (!isTrusted) {
  //         final message = 'SSL Pinning failed for ${request.uri}';
  //         logger.e(message);
  //         _reportToSentry(Exception(message));
  //       } else {
  //         logger.i('SSL Pinning verified for ${request.uri}');
  //       }
  //       return isTrusted;
  //     },
  //   );
  // }

  /// Determines if a request should be retried based on the error type.
  static bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        (e.response?.statusCode != null && e.response!.statusCode! >= 500);
  }

  /// Reports an error to Sentry if not in debug mode.
  static void _reportToSentry(dynamic error) {
    if (!kDebugMode) {
      Sentry.captureException(error, stackTrace: StackTrace.current);
    }
  }
}
