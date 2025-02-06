import 'package:flutter/material.dart';
import 'package:flutter_base_getx/gen/assets.gen.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        child: Obx(() {
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                AnimatedOpacity(
                  opacity: controller.fadeIn.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1500),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOut,
                    transform: Matrix4.translationValues(
                      0,
                      controller.slideUp.value ? 0 : 50,
                      0,
                    ),
                    child: Assets.icons.icLogo.svg(),
                  ),
                ),
                const SizedBox(height: 30),
                // Loading indicator
                AnimatedOpacity(
                  opacity: controller.isLoading.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(color: Colors.white),
                      const SizedBox(height: 20),
                      Text(
                        controller.loadingText.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
