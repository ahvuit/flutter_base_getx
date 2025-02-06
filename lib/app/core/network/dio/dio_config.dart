import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/auth/auth_interceptor.dart';
import 'package:flutter_base_getx/app/core/auth/auth_manager.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_error_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_proxy.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_to_curl_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_to_response_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/rate_limiter.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:universal_platform/universal_platform.dart';

@singleton
class DioConfig {
  final Dio _dio;
  final CoreLogger _logger = getIt<CoreLogger>();
  final EnvConfig _envConfig = EnvConfig.instance;

  Dio get dio => _dio;

  DioConfig(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: _envConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    HttpOverrides.global = MyHttpOverrides();
    _setupInterceptors();
    _setupSSLPinning();
    _logger.i('Dio initialized with baseUrl: ${_dio.options.baseUrl}');
  }

  void _setupInterceptors() {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        compact: false,
        maxWidth: 90,
      ),
      RateLimiterInterceptor(
        maxRequestsPerSecond: 5,
        excludedEndpoints: _envConfig.excludedRateLimitEndpoints,
      ),
    ]);
  }

  void _setupSSLPinning() {
    if (!UniversalPlatform.isWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) =>
            _validateSSLFingerprint(cert.pem);
        return client;
      };
    }
  }

  bool _validateSSLFingerprint(String pem) =>
      sha256.convert(utf8.encode(pem)).toString() == _envConfig.sslFingerprints;

  Dio setupDio(
      AuthManager auth,
      String baseUrl, {
        Future<dynamic> Function()? refreshToken,
        int timeout = 90000,
      }) {
    final dio = _createCoreDio(baseUrl, timeout: timeout);
    dio.interceptors.add(AuthInterceptor(auth, dio, refreshToken));
    return dio;
  }

  Dio _createCoreDio(String baseUrl, {int timeout = 90000}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: timeout),
      receiveTimeout: Duration(milliseconds: timeout),
      sendTimeout: Duration(milliseconds: timeout),
      contentType: 'application/json',
      headers: {
        'lang': 'vi',
        'Accept': 'application/json',
        if (UniversalPlatform.isWeb) ...{
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': '*',
          'Access-Control-Allow-Methods': '*',
          'Access-Control-Allow-Credentials': 'true',
        },
      },
    ));

    if (kDebugMode) {
      dio.interceptors.addAll([
        LogInterceptor(logPrint: (obj) => log(obj.toString())),
        DioLogResponseInterceptor(),
        Dio2CurlInterceptor(),
      ]);
    }
    dio.interceptors.addAll([
      DioCacheInterceptor(options: CacheOptions(store: MemCacheStore())),
      DioResponseInterceptor(),
      DioErrorInterceptors(),
    ]);
    return dio;
  }
}
