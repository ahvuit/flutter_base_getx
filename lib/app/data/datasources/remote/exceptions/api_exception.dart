class ApiException implements Exception {
  final int? statusCode;
  final String? message;
  final dynamic error;

  ApiException({this.statusCode, this.message, this.error});
}
