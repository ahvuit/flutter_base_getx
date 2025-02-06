import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final CoreLogger _logger = getIt<CoreLogger>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Sets the loading state
  ///
  /// This method updates the loading state and resets the retry count if loading is complete.
  ///
  /// [value] - The new loading state.
  void setLoading(bool value) {
    isLoading.value = value;
  }

  /// Handles errors with retry option and custom callback
  ///
  /// This method processes errors, logs them, and optionally retries the operation.
  ///
  /// [error] - The error to handle.
  /// [onError] - Optional callback to handle the error message.
  /// [enableRetry] - Whether to enable retrying the operation.
  /// [onRetry] - Optional callback to retry the operation.
  void handleError(dynamic error, {Function(String)? onError}) {
    final errorMsg = CoreErrorHandler.handleError(error);
    errorMessage.value = errorMsg;
    _logger.e('Error handled: $errorMsg', error);

    onError?.call(errorMsg);
  }

  /// Clears error messages
  ///
  /// This method resets the error message and retry count.
  void clearError() {
    errorMessage.value = '';
  }
}
