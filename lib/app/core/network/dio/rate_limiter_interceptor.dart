import 'package:dio/dio.dart';

class RateLimiterInterceptor extends Interceptor {
  final int maxRequestsPerSecond;
  final List<String> excludedEndpoints;
  final List<DateTime> requestTimestamps = [];

  RateLimiterInterceptor({
    required this.maxRequestsPerSecond,
    this.excludedEndpoints = const [],
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (excludedEndpoints.contains(options.path)) {
      super.onRequest(options, handler);
      return;
    }

    final now = DateTime.now();
    requestTimestamps.removeWhere((t) => now.difference(t).inSeconds > 1);

    if (requestTimestamps.length >= maxRequestsPerSecond) {
      handler.reject(DioException(
        requestOptions: options,
        type: DioExceptionType.cancel,
        error: 'Rate limit exceeded (${requestTimestamps.length}/$maxRequestsPerSecond)',
      ));
      return;
    }

    requestTimestamps.add(now);
    super.onRequest(options, handler);
  }
}