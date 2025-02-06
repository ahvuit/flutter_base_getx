import 'package:dio/dio.dart';
import 'package:flutter_base_getx/app/core/network/network_info.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

class DioErrorInterceptors extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.next(_createException(err, DeadlineExceededException.new));
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400: return handler.next(_createException(err, BadRequestException.new));
          case 401: return handler.next(_createException(err, UnauthorizedException.new));
          case 404: return handler.next(_createException(err, NotFoundException.new));
          case 409: return handler.next(_createException(err, ConflictException.new));
          case 500: return handler.next(_createException(err, InternalServerErrorException.new));
          case 503: return handler.next(_createException(err, ServerUnderMaintainErrorException.new));
        }
        break;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        if (err.message?.contains('SocketException') == true) {
          return handler.next(_createException(err, DeadlineExceededException.new));
        }
        final hasInternet = getIt<NetworkInfo>().isConnected;
        return handler.next(_createException(err, hasInternet ? OtherException.new : NoInternetConnectionException.new));
    }
    return handler.next(err);
  }

  DioException _createException(DioException err, DioException Function(DioException) factory) =>
      factory(err);
}

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

class BadRequestException extends CustomDioException {
  BadRequestException(super.dioError);
  @override
  String toString() => 'Invalid request';
}

class ServerUnderMaintainErrorException extends CustomDioException {
  ServerUnderMaintainErrorException(super.dioError);
  @override
  String toString() => 'Server under maintenance, please try again later';
}

class InternalServerErrorException extends CustomDioException {
  InternalServerErrorException(super.dioError);
  @override
  String toString() => 'Unknown error occurred, please try again later';
}

class ConflictException extends CustomDioException {
  ConflictException(super.dioError);
  @override
  String toString() => 'Conflict occurred';
}

class UnauthorizedException extends CustomDioException {
  UnauthorizedException(super.dioError);
  @override
  String toString() => 'Access denied';
}

class NotFoundException extends CustomDioException {
  NotFoundException(super.dioError);
  @override
  String toString() => 'The requested information could not be found';
}

class OtherException extends CustomDioException {
  OtherException(super.dioError);
  @override
  String toString() => 'Something went wrong, please try again';
}

class DeadlineExceededException extends CustomDioException {
  DeadlineExceededException(super.dioError);
  @override
  String toString() => 'The connection has timed out, please try again';
}

class NoInternetConnectionException extends CustomDioException {
  NoInternetConnectionException(super.dioError);
  @override
  String toString() => 'No internet connection, please try again';
}
