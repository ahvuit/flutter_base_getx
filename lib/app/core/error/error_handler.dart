import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;
import '../logger/logger_service.dart';

class ErrorHandler {
  static String handleException(dynamic error) {
    final logger = di.sl<LoggerService>();
    logger.e('Handling exception: $error', error is Exception ? error : null);

    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is ServerException) {
      return error.message;
    } else if (error is NetworkException) {
      return error.message;
    } else if (error is CacheException) {
      return error.message;
    } else if (error is UnauthorizedException) {
      return error.message;
    } else if (error is RateLimitException) {
      return error.message;
    } else {
      return error.toString();
    }
  }

  static String _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout';
      case DioExceptionType.badCertificate:
        return 'Invalid SSL certificate';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return 'Bad request: ${error.response?.data['message'] ?? 'Unknown error'}';
          case 401:
            return 'Unauthorized: ${error.response?.data['message'] ?? 'Invalid credentials'}';
          case 403:
            return 'Forbidden: ${error.response?.data['message'] ?? 'Access denied'}';
          case 404:
            return 'Not found: ${error.response?.data['message'] ?? 'Resource not found'}';
          case 429:
            return 'Rate limit exceeded: ${error.response?.data['message'] ?? 'Too many requests'}';
          case 500:
            return 'Server error: ${error.response?.data['message'] ?? 'Internal server error'}';
          default:
            return 'Unexpected error: ${error.response?.statusCode} - ${error.response?.data['message'] ?? 'Unknown'}';
        }
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Unknown Dio error: ${error.message}';
    }
  }
}