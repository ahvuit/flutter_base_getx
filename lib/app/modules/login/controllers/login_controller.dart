import 'package:flutter_base_getx/app/core/base/base_controller.dart';
import 'package:flutter_base_getx/app/core/utils/device_utils.dart';
import 'package:flutter_base_getx/app/data/models/auth/check_update_request.dart';
import 'package:flutter_base_getx/app/data/repositories/auth/auth_repository.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

class LoginController extends BaseController {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  @override
  void onInit() {
    super.onInit();
    callApi();
  }

  void callApi() async {
    final uuid = await DeviceUtils.getUUID();
    CheckUpdateRequest request = CheckUpdateRequest(deviceId: uuid);
    setLoading(true);
    final result = await _authRepository.checkUpdate(request);

    result.fold(
      (error) {
        setLoading(false);
        showErrorMessage(errorMessage: error.toString());
      },
      (response) {
        setLoading(false);
        if (response.isSuccessCode()) {
        } else {
          showErrorMessage(errorMessage: response.errorMessage);
        }
      },
    );
  }
}
