import 'package:flutter/foundation.dart';
import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final CoreLogger _logger = getIt<CoreLogger>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _logger.i('Controller ${runtimeType.toString()} initialized');
  }

  @override
  void onClose() {
    _logger.i('Controller ${runtimeType.toString()} closed');
    super.onClose();
  }

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
    final errorMsg = CoreErrorHandler.handleException(
      error,
      includeStackTrace: kDebugMode,
    );
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

  /// Performs an async action with loading and error handling
  ///
  /// This method executes an asynchronous action with loading state management and error handling.
  ///
  /// [action] - The asynchronous action to perform.
  /// [onError] - Optional callback to handle the error message.
  Future<void> performAction(
    Future<void> Function() action, {
    Function(String)? onError,
    bool enableRetry = false,
  }) async {
    try {
      setLoading(true);
      await action();
    } catch (e) {
      handleError(e, onError: onError);
    } finally {
      setLoading(false);
    }
  }
}
