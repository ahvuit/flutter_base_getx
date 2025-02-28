import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'core_exceptions.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class CoreErrorHandler {
  static String handleException(
    dynamic error, {
    String defaultMessage = 'An unexpected error occurred',
    bool includeStackTrace = false,
  }) {
    final logger = di.sl<CoreLogger>();
    final stackTrace =
        includeStackTrace && error is Exception ? StackTrace.current : null;
    logger.e('Handling exception: $error', error, stackTrace);

    return switch (error) {
      DioException dioError => _handleDioException(dioError),
      CoreException coreError => coreError.message,
      _ => _formatErrorMessage(error?.toString() ?? defaultMessage, stackTrace),
    };
  }

  static String _handleDioException(DioException error) {
    final response = error.response;
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        'error_network_timeout',
      DioExceptionType.badCertificate => 'error_ssl_certificate',
      DioExceptionType.connectionError => 'error_no_internet',
      DioExceptionType.badResponse => _handleHttpError(response),
      DioExceptionType.cancel => 'error_request_cancelled',
      _ => 'error_dio_unknown_${error.message}',
    };
  }

  static String _handleHttpError(Response? response) {
    final statusCode = response?.statusCode;
    final message = response?.data is Map
        ? response?.data['message']?.toString()
        : response?.statusMessage ?? 'Unknown error';

    return switch (statusCode) {
      400 => 'error_bad_request_$message',
      401 => 'error_unauthorized_$message',
      403 => 'error_forbidden_$message',
      404 => 'error_not_found_$message',
      429 => 'error_rate_limit_$message',
      500 => 'error_server_$message',
      _ => 'error_http_$statusCode $message',
    };
  }

  static String _formatErrorMessage(String message, StackTrace? stackTrace) {
    return stackTrace != null ? '$message\nStackTrace: $stackTrace' : message;
  }
}
