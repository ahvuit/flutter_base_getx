import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/core/widget/custom_app_bar.dart';
import 'package:flutter_base_getx/app/core/widget/custom_snackbar.dart';
import 'package:flutter_base_getx/l10n/gen/l10n.dart';
import 'package:get/get.dart';

abstract class BaseScreen<T extends BaseController> extends StatelessWidget {
  const BaseScreen({super.key});

  T get controller => Get.find<T>();
  AppLocalizations get l10n => AppLocalizations.of(Get.context!);

  String get title;
  bool get showBackButton => true;
  List<Widget> get actions => [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: _buildActions(),
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(child: buildBody(context)),
      ),
    );
  }

  Widget buildBody(BuildContext context);

  List<Widget> _buildActions() {
    final defaultActions = [
      if (showBackButton)
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
    ];
    return [...defaultActions, ...actions];
  }

  void showError(String message) {
    showCustomSnackBar(Get.context!, message: message, backgroundColor: Colors.red);
  }
}