import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/constants/core_colors.dart';
import 'package:flutter_base_getx/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

abstract class DialogManager {
  Future<T> showLoadingPopup<T>(
    BuildContext context,
    Future<T> future, {
    String? loadingText,
    Widget? dialogState,
  });

  void showAlertDialog({
    required BuildContext context,
    required String alertTitle,
    required String alertMessage,
    String yesButtonText,
    String cancelButtonText,
    required Function() onYesPress,
    bool canDismiss,
  });

  Widget errorDialog({required String errorMessage, VoidCallback? onTap});

  Widget successDialog({required String successMessage, VoidCallback? onTap});
}

@Singleton(as: DialogManager)
class DialogManagerImpl implements DialogManager {
  @override
  Future<T> showLoadingPopup<T>(
    BuildContext context,
    Future<T> future, {
    String? loadingText,
    Widget? dialogState,
  }) async {
    BuildContext? popupContext;
    final dialog = dialogState ?? _buildLoadingDialog(context, loadingText);
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    }
    try {
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      Navigator.of(popupContext ?? context, rootNavigator: true).pop();
    }
  }

  Widget _buildLoadingDialog(BuildContext context, String? loadingText) {
    Widget child = IntrinsicWidth(
      stepWidth: 56.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200.0,
          minWidth: 100.0,
          minHeight: 100.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: const CupertinoActivityIndicator(radius: 32),
            ),
            if (loadingText != null)
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(loadingText),
              ),
          ],
        ),
      ),
    );

    final DialogThemeData dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding:
          MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 105.0, maxHeight: 105),
            child: Material(
              color:
                  dialogTheme.backgroundColor?.withOpacity(1.0) ??
                  Theme.of(context).dialogBackgroundColor.withOpacity(1.0),
              elevation: dialogTheme.elevation ?? 24,
              shape: dialogTheme.shape,
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  showAlertDialog({
    required BuildContext context,
    required String alertTitle,
    required String alertMessage,
    String yesButtonText = "Đồng ý",
    String cancelButtonText = "Huỷ",
    required Function() onYesPress,
    bool canDismiss = true,
  }) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        cancelButtonText,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget yesButton = TextButton(
      onPressed: onYesPress,
      child: Text(
        yesButtonText,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[Text(alertMessage)]),
      ),
      actions: [canDismiss ? cancelButton : Container(), yesButton],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(canDismiss),
          child: alert,
        );
      },
    );
  }

  @override
  Widget errorDialog({required String errorMessage, VoidCallback? onTap}) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      children: [
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              _buildErrorIcon(),
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(top: 12, left: 40, right: 40),
                child: Text(errorMessage, textAlign: TextAlign.center),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 23,
                  bottom: 17,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      onTap?.call();
                      Get.back();
                    },
                    child: Center(child: Text('OK')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget successDialog({required String successMessage, VoidCallback? onTap}) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      children: [
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              _buildSuccessIcon(),
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(top: 12, left: 40, right: 40),
                child: Text(successMessage, textAlign: TextAlign.center),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 23,
                  bottom: 17,
                ),
                decoration: BoxDecoration(
                  color: CoreColors.grey84DColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      onTap?.call();
                      Get.back();
                    },
                    child: Center(child: Text('OK')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      child: Text('Error', textAlign: TextAlign.center),
    );
  }

  Container _buildErrorIcon() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Assets.icons.icErrorOutline.image(width: 50, height: 50),
    );
  }

  Container _buildSuccessIcon() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Assets.icons.icDoneRequest.image(width: 50, height: 50),
    );
  }
}


