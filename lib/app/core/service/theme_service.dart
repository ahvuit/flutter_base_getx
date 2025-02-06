import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/storage/storage_manager.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@singleton
class ThemeManager extends GetxService {
  final _storage = getIt<StorageManager>();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get theme => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _themeMode.value = getThemeMode();
  }

  ThemeMode getThemeMode() {
    String themeString = _storage.getThemeMode();
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void _saveThemeToStorage(ThemeMode mode) {
    _storage.setThemeMode(mode.toString().split('.').last);
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    _saveThemeToStorage(mode);
    Get.changeThemeMode(mode);
  }
}
