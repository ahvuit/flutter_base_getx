import 'dart:async';
import 'dart:collection';
import '../logger/logger_service.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class RateLimiter {
  final int maxRequests;
  final Duration window;
  final Queue<DateTime> _requestTimestamps = Queue();

  RateLimiter({required this.maxRequests, required this.window});

  Future<bool> canRequest() async {
    final now = DateTime.now();
    final logger = di.sl<LoggerService>();

    while (_requestTimestamps.isNotEmpty && now.difference(_requestTimestamps.first) > window) {
      _requestTimestamps.removeFirst();
    }

    if (_requestTimestamps.length < maxRequests) {
      _requestTimestamps.add(now);
      logger.d('RateLimiter: Request allowed. Current count: ${_requestTimestamps.length}');
      return true;
    } else {
      logger.w('RateLimiter: Request limit reached. Current count: ${_requestTimestamps.length}');
      return false;
    }
  }

  int get remainingRequests => maxRequests - _requestTimestamps.length;
  DateTime? get nextAvailableTime => _requestTimestamps.isNotEmpty
      ? _requestTimestamps.first.add(window)
      : null;
}