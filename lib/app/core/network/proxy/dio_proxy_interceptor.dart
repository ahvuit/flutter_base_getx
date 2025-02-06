import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:developer';

// Custom HttpOverrides to manage SSL verification globally if needed
class ProxyHttpOverrides extends HttpOverrides {
  final bool bypassSslVerification;

  ProxyHttpOverrides({this.bypassSslVerification = false});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    if (bypassSslVerification) {
      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        log('Bypassing SSL verification for host: $host');
        return true;
      };
    }
    return client;
  }
}

// Interceptor to configure proxy for Dio requests
class DioProxyInterceptor extends Interceptor {
  // Dio instance to configure proxy
  final Dio dio;
  // Determines if proxy is enabled
  final bool isProxyEnabled;
  // Proxy host (e.g., Charles or Fiddler)
  final String proxyHost;
  // Proxy port
  final int proxyPort;
  // Flag to bypass SSL verification (optional, default false)
  final bool bypassSslVerification;

  DioProxyInterceptor({
    required this.dio,
    this.isProxyEnabled = false,
    this.proxyHost = 'localhost',
    this.proxyPort = 8888,
    this.bypassSslVerification = false,
  }) {
    // Apply proxy configuration to the Dio instance
    if (isProxyEnabled) {
      _configureProxy();
    }
  }

  // Configures proxy settings for the Dio instance using createHttpClient
  void _configureProxy() {
    final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    adapter.createHttpClient = () {
      final client = HttpClient();
      client.findProxy = (uri) {
        log('Proxying request to $proxyHost:$proxyPort for ${uri.toString()}');
        return 'PROXY $proxyHost:$proxyPort';
      };
      if (bypassSslVerification) {
        client.badCertificateCallback = (
          X509Certificate cert,
          String host,
          int port,
        ) {
          log('Bypassing SSL for $host:$port');
          return true;
        };
      }
      return client;
    };
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (isProxyEnabled) {
      log('Request intercepted for proxy: ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (isProxyEnabled) {
      log('Response received via proxy: ${response.statusCode}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (isProxyEnabled) {
      log('Proxy error: ${err.message}');
    }
    super.onError(err, handler);
  }
}
