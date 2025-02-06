import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/core/utils/notification_utils.dart';
import 'package:flutter_base_getx/app/data/repositories/example_repository.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final _exampleRepository = Get.find<ExampleRepository>();

  @override
  void onInit() async {
    super.onInit();
    //await NotificationUtils().initNotification(EnvConfig.instance);
  }

  void callApi() async {
    final result = await _exampleRepository.getExample(1);
    setLoading(true);

    result.fold(
      (error) {
        Get.snackbar('Error', error);
      },
      (response) {
        if (response.isSuccessCode()) {
          print('[LoginController] Fetched example: ${response.data}');
        } else {
          Get.snackbar('Error', response.errorMessage);
        }
      },
    );
  }
}
