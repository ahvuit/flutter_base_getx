import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:universal_platform/universal_platform.dart';

class CertificatePinningInterceptor extends Interceptor {
  final List<String> Function() _allowedSHAFingerprints;
  final int _timeout;
  final Set<String> _verifiedURLs = {};

  CertificatePinningInterceptor({
    required List<String> Function() allowedSHAFingerprints,
    int timeout = 0,
  })  : _allowedSHAFingerprints = allowedSHAFingerprints,
        _timeout = timeout;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (UniversalPlatform.isWeb) return handler.next(options);

    final url = options.path.startsWith('https://') ? options.path : options.baseUrl;
    if (_verifiedURLs.contains(url)) return handler.next(options);

    try {
      final result = await HttpCertificatePinning.check(
        serverURL: url,
        headerHttp: options.headers.map((k, v) => MapEntry(k, v.toString())),
        sha: SHA.SHA256,
        allowedSHAFingerprints: _allowedSHAFingerprints(),
        timeout: _timeout,
      );

      if (result.contains('CONNECTION_SECURE')) {
        _verifiedURLs.add(url);
        return handler.next(options);
      }
      return handler.reject(DioException(
        requestOptions: options,
        error: const CertificateNotVerifiedException(),
      ));
    } catch (e) {
      final error = e is PlatformException && e.code == 'CONNECTION_NOT_SECURE'
          ? const CertificateNotVerifiedException()
          : CertificateCouldNotBeVerifiedException();
      return handler.reject(DioException(requestOptions: options, error: error));
    }
  }
}
