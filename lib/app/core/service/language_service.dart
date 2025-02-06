import 'dart:ui';

import 'package:flutter_base_getx/app/core/constants/core_language.dart';
import 'package:flutter_base_getx/app/core/storage/storage_manager.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@singleton
class LanguageService extends GetxService {
  final _storage = getIt<StorageManager>();
  var selectedLanguage = Language.vi.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = _storage.getLocale();
  }

  void changeLanguage(Language language) {
    selectedLanguage.value = language;
    _storage.setLocale(language);
    Get.updateLocale(Locale(language.languageCode));
  }

  void toggleLanguage() {
    selectedLanguage.value =
    selectedLanguage.value == Language.vi ? Language.en : Language.vi;
    _storage.setLocale(selectedLanguage.value);
    Get.updateLocale(Locale(selectedLanguage.value.languageCode));
  }
}