import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter_base_getx/app/core/service/loading_dialog_service.dart';
import 'package:flutter_base_getx/app/core/utils/custom_modal_configuration.dart';
import 'package:flutter_base_getx/app/core/utils/dialog_utils.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final isLoading = true.obs;
  bool isErrorShowing = false;

  @override
  void onInit() {
    super.onInit();
    ever(isLoading, (_) {
      if (isLoading.isTrue) {
        LoadingDialogUtils().loadingOverlayVisible(visible: true);
      } else {
        LoadingDialogUtils().loadingOverlayVisible(visible: false);
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
        configuration:
        const BlurFadeScaleTransitionConfiguration(barrierDismissible: true, blurSigma: 6.0),
        builder: (context) {
          return DialogUtils().errorDialog(errorMessage: errorMessage, onTap: onTap);
        }).then((value) {
      isErrorShowing = false;
    });
  }
}
