import 'package:flutter_base_getx/app/core/error/core_error_handler.dart';
import 'package:flutter_base_getx/app/core/logger/logger_service.dart';
import 'package:get/get.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

abstract class BaseController extends GetxController {
  final LoggerService _logger = di.sl<LoggerService>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _logger.i('Controller ${runtimeType.toString()} initialized');
  }

  void setLoading(bool value) => isLoading.value = value;

  void handleError(dynamic error) {
    final errorMsg = CoreErrorHandler.handleException(error);
    errorMessage.value = errorMsg;
    _logger.e('Error handled: $errorMsg');
  }

  void clearError() => errorMessage.value = '';
}