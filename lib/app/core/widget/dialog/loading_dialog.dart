import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/widget/custom_modal_configuration.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoadingDialog {
  final navigatorKey = getIt<GlobalKey<NavigatorState>>();

  bool _modalVisible = false;

  void show() {
    final context = navigatorKey.currentContext;
    if (context == null || _modalVisible) return;

    _modalVisible = true;
    showModal(
      context: context,
      configuration: const BlurFadeScaleTransitionConfiguration(
        barrierDismissible: false,
        blurSigma: 6.0,
        barrierColor: Colors.white70,
      ),
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async => false,
            child: SizedBox(
              width: 175,
              height: 175,
              child: SpinKitDualRing(size: 100, color: Colors.grey),
            ),
          ),
        );
      },
    ).then((value) {
      _modalVisible = false;
    });
  }

  void hide() {
    final context = navigatorKey.currentContext;
    if (_modalVisible && context != null && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
