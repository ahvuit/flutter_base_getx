import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:universal_platform/universal_platform.dart';
import 'dart:developer';

class CertificatePinningInterceptor extends Interceptor {
  final List<String> _allowedSHAFingerprints;
  final int _timeout;
  final Set<String> _verifiedURLs = {};

  CertificatePinningInterceptor({
    required List<String> allowedSHAFingerprints,
    int timeout = 0,
  })  : _allowedSHAFingerprints = allowedSHAFingerprints,
        _timeout = timeout;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (UniversalPlatform.isWeb) {
      log('Skipping certificate pinning on web platform');
      return handler.next(options);
    }

    final url = options.path.startsWith('https://') ? options.path : options.baseUrl;
    if (_verifiedURLs.contains(url)) {
      log('URL $url already verified, skipping pinning check');
      return handler.next(options);
    }

    try {
      log('Checking certificate for $url');
      final result = await HttpCertificatePinning.check(
        serverURL: url,
        headerHttp: options.headers.map((k, v) => MapEntry(k, v.toString())),
        sha: SHA.SHA256,
        allowedSHAFingerprints: _allowedSHAFingerprints,
        timeout: _timeout,
      );

      if (result.contains('CONNECTION_SECURE')) {
        _verifiedURLs.add(url);
        log('Certificate verified for $url');
        return handler.next(options);
      }
      log('Certificate not secure for $url');
      return handler.reject(DioException(
        requestOptions: options,
        error: const CertificateNotVerifiedException(),
      ));
    } catch (e) {
      final error = e is PlatformException && e.code == 'CONNECTION_NOT_SECURE'
          ? const CertificateNotVerifiedException()
          : CertificateCouldNotBeVerifiedException();
      log('Certificate check failed for $url: $e');
      return handler.reject(DioException(requestOptions: options, error: error));
    }
  }
}