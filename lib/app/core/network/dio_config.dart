import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/config/flavor_config.dart';
import 'package:flutter_base_getx/app/core/logger/logger_service.dart';
import 'package:flutter_base_getx/app/core/storage/storage_service.dart';
import 'package:flutter_base_getx/app/core/widget/loading_dialog.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'rate_limiter.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class DioConfig {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: FlavorConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: _defaultHeaders(),
    ));

    dio.interceptors.addAll([
      _authInterceptor(),
      _rateLimitInterceptor(),
      _loadingInterceptor(),
      _loggingInterceptor(),
     // _sslPinningInterceptor(),
    ]);

    return dio;
  }

  static Map<String, String> _defaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'App-Version': '1.0.0',
    };
  }

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
        final logger = di.sl<LoggerService>();
        if (e.response?.statusCode == 401) {
          logger.w('Unauthorized request, attempting to handle');
        }
        handler.next(e);
      },
    );
  }

  static Interceptor _rateLimitInterceptor() {
    final rateLimiter = di.sl<RateLimiter>();
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final canRequest = await rateLimiter.canRequest();
        if (canRequest) {
          handler.next(options);
        } else {
          final logger = di.sl<LoggerService>();
          final nextTime = rateLimiter.nextAvailableTime;
          final message = 'Rate limit exceeded. Try again at $nextTime';
          logger.e(message);
          handler.reject(DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 429,
              statusMessage: 'Too Many Requests',
              data: {'message': message},
            ),
            type: DioExceptionType.badResponse,
            error: message,
          ));
        }
      },
    );
  }

  static Interceptor _loadingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final context = di.sl<GlobalKey<NavigatorState>>().currentState?.overlay?.context;
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

  static Interceptor _loggingInterceptor() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode || FlavorConfig.instance.flavor == Flavor.dev,
    );
  }

  // static Interceptor _sslPinningInterceptor() {
  //   return HttpCertificatePinningInterceptor(
  //     allowedSHAFingerprints: ['YOUR_SSL_FINGERPRINT_HERE'],
  //     onCheckCertificate: (request, isTrusted) {
  //       final logger = di.sl<LoggerService>();
  //       if (!isTrusted) {
  //         logger.e('SSL Pinning failed for ${request.uri}');
  //       } else {
  //         logger.i('SSL Pinning verified for ${request.uri}');
  //       }
  //       return isTrusted;
  //     },
  //   );
  // }
}