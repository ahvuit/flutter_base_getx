import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/auth/auth_interceptor.dart';
import 'package:flutter_base_getx/app/core/auth/auth_manager.dart';
import 'package:flutter_base_getx/app/core/network/dio/certificate_pinning_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_curl_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_error_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_response_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/dio/rate_limiter_interceptor.dart';
import 'package:flutter_base_getx/app/core/network/proxy/dio_proxy_interceptor.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioConfig {
  late Dio dio;
  final AuthManager authManager;

  DioConfig(this.authManager) {
    _initializeDio();
  }

  void _initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.instance.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    log("BASE URL: ${dio.options.baseUrl}");

    final cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);

    dio.interceptors.addAll([
      AuthInterceptor(authManager, dio),
      DioErrorInterceptor(),
      DioResponseInterceptor(),
      DioCacheInterceptor(
        options: CacheOptions(store: cacheStore, policy: CachePolicy.noCache),
      ),
      RateLimiterInterceptor(
        maxRequestsPerSecond: 5,
        excludedEndpoints: EnvConfig.instance.excludedRateLimitEndpoints,
      ),
    ]);

    if (EnvConfig.instance.isCheckCertificatePinning) {
      dio.interceptors.add(
        CertificatePinningInterceptor(
          allowedSHAFingerprints: EnvConfig.instance.sslFingerprints,
        ),
      );
    }

    if (EnvConfig.instance.isEnableProxy) {
      dio.interceptors.add(
        DioProxyInterceptor(
          dio: dio,
          isProxyEnabled: EnvConfig.instance.flavor == Flavor.dev,
          proxyHost: 'localhost',
          proxyPort: 8888,
          bypassSslVerification: EnvConfig.instance.flavor == Flavor.dev,
        ),
      );
    }

    if (kDebugMode) {
      dio.interceptors.add(DioCurlInterceptor());
    }
  }

  void updateBaseUrl(String newBaseUrl) {
    dio.options.baseUrl = newBaseUrl;
  }

  void setUpHeader(Map<String, dynamic> data) {
    data.forEach((key, value) {
      dio.options.headers[key] = value;
    });
  }

  Dio getDio({String? overrideBaseUrl}) {
    if (overrideBaseUrl != null) {
      dio.options.baseUrl = overrideBaseUrl;
    }
    return dio;
  }
}
