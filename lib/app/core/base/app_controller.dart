import 'dart:ui';

import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/constants/core_language.dart';
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart';
import 'package:flutter_base_getx/app/core/utils/notification_utils.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';


class AppController extends GetxController {
  late EnvConfig env;
  Rx<AuthState> authState = AuthState.unauthorized.obs;
  Rx<Locale?> locale = Rx(null);

  setLanguage(Language language) async {
    Get.updateLocale(Locale(language.languageCode));
    locale.value = Locale(language.languageCode);
  }

  String getAppTitle() {
    return env.appName;
  }

  init(EnvConfig env) async {
    this.env = env;
   // await setupLocator();
    _initNotification(env);
    await _initStorage();
    //initTheme();
    await initLanguage();
    await initAuth();
  }

  _initNotification(EnvConfig env) async {
    await NotificationUtils().initNotification(env);
  }

  initLanguage() async {
    // String language =
    //     (Get.find<CommonRepository>().getLanguage()).languageCode;
    // locale.value = AppLocalizations.supportedLocales
    //     .firstWhere((locale) => locale.languageCode == language, orElse: () {
    //   language = AppLocalizations.supportedLocales.first.languageCode;
    //   return AppLocalizations.supportedLocales.first;
    // });
  }

  _initStorage() async {
    await getIt<GetStorageService>().initGetStorage();
  }

  Future<void> initAuth() async {
    // final userRepository = Get.find<UserRepository>();
    // final user = await userRepository.getUserInfo();
    // final token = await userRepository.getUserAccessToken();
    //
    // if (user != null && token != null) {
    //   await initApi(token: token);
    //   authState.value = AuthState.authorized;
    // } else {
    //   await initApi();
    //   authState.value = AuthState.unauthorized;
    // }
  }

  Future<void> initApi({
    String? token,
  }) async {

  }
}

enum AuthState { unauthorized, authorized, newInstall }