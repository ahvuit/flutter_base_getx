import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/network/dio/dio_error_interceptor.dart';

class CoreErrorHandler {
  /// Handles errors and returns a user-friendly error message as a string.
  /// [error] The error to handle (can be DioException, Exception, or other).
  static String handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unexpected error occurred: $error';
    }
  }

  /// Handles Dio-specific exceptions and returns appropriate error messages.
  /// [error] The DioException to handle.
  static String _handleDioException(DioException error) {
    final customException = mapDioExceptionToCustomException(error);
    return customException.toString();
  }

  /// Maps a DioException to a CustomDioException based on its type and status code.
  /// [error] The DioException to map.
  /// [hasInternet] Whether the device has an internet connection.
  static CustomDioException mapDioExceptionToCustomException(
    DioException error, {
    bool hasInternet = true,
  }) {
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DeadlineExceededException(error);
      case DioExceptionType.badResponse:
        return _mapBadResponseToCustomException(error);
      case DioExceptionType.cancel:
        return RequestCancelledException(error);
      case DioExceptionType.badCertificate:
        return BadCertificateException(error);
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') == true) {
          return DeadlineExceededException(error);
        }
        return hasInternet
            ? OtherException(error)
            : NoInternetConnectionException(error);
    }
  }

  /// Maps a bad response DioException to a specific CustomDioException based on status code.
  /// [error] The DioException with a bad response.
  static CustomDioException _mapBadResponseToCustomException(
    DioException error,
  ) {
    final statusCode = error.response?.statusCode;
    switch (statusCode) {
      case HttpStatus.badRequest:
        return BadRequestException(error);
      case HttpStatus.unauthorized:
        return UnauthorizedException(error);
      case HttpStatus.forbidden:
        return ForbiddenException(error);
      case HttpStatus.notFound:
        return NotFoundException(error);
      case HttpStatus.conflict:
        return ConflictException(error);
      case HttpStatus.internalServerError:
        return InternalServerErrorException(error);
      case HttpStatus.serviceUnavailable:
        return ServerUnderMaintainErrorException(error);
      default:
        return UnknownServerException(error);
    }
  }

  /// Wraps an async action in Either, returning Left with error message or Right with result.
  /// [action] The async action to execute.
  static Future<Either<String, T>> wrapInEither<T>(
    Future<T> Function() action,
  ) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      final errorMessage = handleError(e);
      return Left(errorMessage);
    }
  }
}
