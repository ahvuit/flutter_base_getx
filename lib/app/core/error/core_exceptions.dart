abstract class CoreException implements Exception {
  final String message;

  CoreException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

class ServerException extends CoreException {
  ServerException(super.message);
}

class NetworkException extends CoreException {
  NetworkException(super.message);
}

class CacheException extends CoreException {
  CacheException(super.message);
}

class UnauthorizedException extends CoreException {
  UnauthorizedException(super.message);
}

class RateLimitException extends CoreException {
  RateLimitException(super.message);
}

class ForbiddenException extends CoreException {
  ForbiddenException(super.message);
}

class BadRequestException extends CoreException {
  BadRequestException(super.message);
}

class NotFoundException extends CoreException {
  NotFoundException(super.message);
}
