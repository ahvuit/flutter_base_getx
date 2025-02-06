class CoreResponseError {

  dynamic errorCode;

  String? errorMessage;

  CoreResponseError({
    this.errorCode,
    this.errorMessage
  });

  CoreResponseError.fromValues({required this.errorCode, required this.errorMessage});
}