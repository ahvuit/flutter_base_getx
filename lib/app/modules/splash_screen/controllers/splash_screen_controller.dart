import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends BaseController {
  final fadeIn = false.obs;
  final slideUp = false.obs;
  final loadingText = 'Loading...'.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
  }

  void _startAnimations() async {
    try {
      // Start fade in and slide up animations
      await Future.delayed(const Duration(milliseconds: 500));
      fadeIn.value = true;
      slideUp.value = true;

      // Show loading indicator
      await Future.delayed(const Duration(milliseconds: 1000));
      isLoading.value = true;

      // Simulate loading process
      await Future.delayed(const Duration(milliseconds: 1000));
      loadingText.value = 'Checking credentials...';

      await Future.delayed(const Duration(milliseconds: 1000));
      loadingText.value = 'Almost there...';

      // Navigate to next screen
      await Future.delayed(const Duration(milliseconds: 1000));
      Get.offAllNamed(Routes.LOGIN);
    } catch (error) {
      errorMessage.value = error.toString();
    }
  }
}