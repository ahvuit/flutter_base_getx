class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() {
    return 'ServerException: $message. Please check the server configuration and try again.';
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() {
    return 'NetworkException: $message. Please check your network connection and try again.';
  }
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() {
    return 'CacheException: $message. Please check the cache storage and try again.';
  }
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);

  @override
  String toString() {
    return 'UnauthorizedException: $message. Please check your credentials and try again.';
  }
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);

  @override
  String toString() {
    return 'RateLimitException: $message. Please wait before making more requests.';
  }
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);

  @override
  String toString() {
    return 'UnknownException: $message. An unknown error occurred.';
  }
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException(this.message);

  @override
  String toString() {
    return 'ForbiddenException: $message. Access to the requested resource is denied.';
  }
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() {
    return 'BadRequestException: $message. The request could not be understood or was missing required parameters.';
  }
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() {
    return 'NotFoundException: $message. The requested resource could not be found.';
  }
}