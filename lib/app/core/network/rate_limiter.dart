import 'dart:async';
import 'package:dio/dio.dart';

class RateLimiterInterceptor extends Interceptor {
  final int maxRequestsPerSecond;
  final List<String> excludedEndpoints;
  int _requestCount = 0;
  Timer? _timer;

  RateLimiterInterceptor({
    this.maxRequestsPerSecond = 5,
    required this.excludedEndpoints,
  }) {
    // Ensure the request count resets every second
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _requestCount = 0;
    });
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Bypass rate limit for excluded APIs
    if (excludedEndpoints.any((endpoint) => options.path.contains(endpoint))) {
      handler.next(options);
      return;
    }

    // Enforce rate limit
    if (_requestCount < maxRequestsPerSecond) {
      _requestCount++;
      handler.next(options);
    } else {
      handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 429, // Too Many Requests
            statusMessage: "Rate limit exceeded! Try again later.",
          ),
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  // Dispose the timer when the interceptor is removed
  void dispose() {
    _timer?.cancel();
  }
}
