import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/core/utils/notification_utils.dart';

class LoginController extends BaseController {

  @override
  void onInit() async {
    super.onInit();
    print("[LoginController] onInit() called ✅");
    await NotificationUtils().initNotification(EnvConfig.instance);
  }
}
