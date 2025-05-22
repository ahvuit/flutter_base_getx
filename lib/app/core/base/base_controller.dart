import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter_base_getx/app/core/widget/dialog/dialog_manager.dart';
import 'package:flutter_base_getx/app/core/widget/custom_modal_configuration.dart';
import 'package:flutter_base_getx/app/core/widget/dialog/loading_dialog.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final isLoading = true.obs;
  bool isErrorShowing = false;

  @override
  void onInit() {
    super.onInit();
    ever(isLoading, (_) {
      if (isLoading.isTrue) {
        getIt<LoadingDialog>().show();
      } else {
        getIt<LoadingDialog>().hide();
      }
    });
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void showErrorMessage({required String errorMessage, VoidCallback? onTap}) {
    if (isErrorShowing) return;
    isErrorShowing = true;
    showModal(
      context: Get.context!,
      configuration: const BlurFadeScaleTransitionConfiguration(
        barrierDismissible: true,
        blurSigma: 6.0,
      ),
      builder: (context) {
        return getIt<DialogManager>().errorDialog(
          errorMessage: errorMessage,
          onTap: onTap,
        );
      },
    ).then((value) {
      isErrorShowing = false;
    });
  }
}
