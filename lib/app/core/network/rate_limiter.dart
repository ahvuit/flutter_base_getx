import 'dart:async';
import 'dart:collection';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:injectable/injectable.dart';

@injectable
class RateLimiter {
  final int maxRequests;
  final Duration window;
  final Queue<DateTime> _requestTimestamps = Queue();
  final logger = getIt<CoreLogger>();

  RateLimiter({required this.maxRequests, required this.window});

  /// Determines if a request can be made based on the rate limit.
  Future<bool> canRequest() async {
    final now = DateTime.now();

    // Remove timestamps that are outside the rate limit window
    while (_requestTimestamps.isNotEmpty &&
        now.difference(_requestTimestamps.first) > window) {
      _requestTimestamps.removeFirst();
    }

    if (_requestTimestamps.length < maxRequests) {
      _requestTimestamps.add(now);
      logger.d(
          'RateLimiter: Request allowed. Current count: ${_requestTimestamps.length}');
      return true;
    } else {
      logger.w(
          'RateLimiter: Request limit reached. Current count: ${_requestTimestamps.length}');
      return false;
    }
  }

  /// Returns the number of remaining requests within the rate limit.
  int get remainingRequests => maxRequests - _requestTimestamps.length;

  /// Returns the next available time for making a request.
  DateTime? get nextAvailableTime => _requestTimestamps.isNotEmpty
      ? _requestTimestamps.first.add(window)
      : null;

  /// Resets the rate limiter by clearing all request timestamps.
  void reset() {
    _requestTimestamps.clear();
  }
}
