import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/network/network_info.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

class DioErrorInterceptor extends Interceptor {
  final CoreLogger _logger = getIt<CoreLogger>();
  final NetworkInfo _networkInfo = getIt<NetworkInfo>();

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    _logger.e('Dio error occurred: ${err.type}, message: ${err.message}');

    // Check internet connectivity
    final hasInternet = _networkInfo.isConnected;

    // Map DioException to CustomDioException using CoreErrorHandler
    final customException = CoreErrorHandler.mapDioExceptionToCustomException(
      err,
      hasInternet: hasInternet,
    );

    // Log the transformed error
    _logger.e('Transformed error: ${customException.toString()}');

    // Pass the custom exception to the next handler
    return handler.next(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: customException,
    ));
  }
}

// Base class for custom Dio exceptions
abstract class CustomDioException extends DioException {
  CustomDioException(DioException dioError)
      : super(
    requestOptions: dioError.requestOptions,
    type: dioError.type,
    response: dioError.response,
    error: dioError.error,
  );

  @override
  String toString();
}

// Specific custom exceptions
class BadRequestException extends CustomDioException {
  BadRequestException(super.dioError);
  @override
  String toString() => _extractMessage() ?? 'Invalid request';
}

class ForbiddenException extends CustomDioException {
  ForbiddenException(super.dioError);
  @override
  String toString() => _extractMessage() ?? 'Forbidden: Access denied';
}

class UnauthorizedException extends CustomDioException {
  UnauthorizedException(super.dioError);
  @override
  String toString() => _extractMessage() ?? 'Access denied';
}

class NotFoundException extends CustomDioException {
  NotFoundException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'The requested information could not be found';
}

class ConflictException extends CustomDioException {
  ConflictException(super.dioError);
  @override
  String toString() => _extractMessage() ?? 'Conflict occurred';
}

class InternalServerErrorException extends CustomDioException {
  InternalServerErrorException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'Unknown error occurred, please try again later';
}

class ServerUnderMaintainErrorException extends CustomDioException {
  ServerUnderMaintainErrorException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'Server under maintenance, please try again later';
}

class UnknownServerException extends CustomDioException {
  UnknownServerException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'Unknown server error: ${response?.statusCode}';
}

class RequestCancelledException extends CustomDioException {
  RequestCancelledException(super.dioError);
  @override
  String toString() => 'Request was cancelled';
}

class BadCertificateException extends CustomDioException {
  BadCertificateException(super.dioError);
  @override
  String toString() => 'Invalid SSL certificate';
}

class DeadlineExceededException extends CustomDioException {
  DeadlineExceededException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'The connection has timed out, please try again';
}

class NoInternetConnectionException extends CustomDioException {
  NoInternetConnectionException(super.dioError);
  @override
  String toString() => 'No internet connection, please try again';
}

class OtherException extends CustomDioException {
  OtherException(super.dioError);
  @override
  String toString() =>
      _extractMessage() ?? 'Something went wrong, please try again';
}

// Extension to extract message from response data
extension DioExceptionMessage on CustomDioException {
  String? _extractMessage() {
    final data = response?.data;
    if (data is Map<String, dynamic> && data.containsKey('message')) {
      return data['message'] as String?;
    }
    return null;
  }
}