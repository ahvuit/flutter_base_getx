class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class RateLimitException implements Exception {
  final String message;
  RateLimitException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}