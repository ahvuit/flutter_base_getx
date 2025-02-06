import 'package:flutter_base_getx/app/core/constants/core_language.dart';
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class StorageManager {
  late final GetStorageService _storageBox;

  static const _isDarkMode = '_isDarkMode';
  static const _languageCode = '_languageCode';

  String getThemeMode() {
    final theme = _storageBox.read(_isDarkMode) ?? 'system';
    return theme;
  }

  void setThemeMode(String? mode) {
    final value = mode ?? 'system';
    _storageBox.write(_isDarkMode, value);
  }

  void setLocale(Language? languageCode) {
    final value = languageCode ?? LanguageName.vn;
    _storageBox.write(_languageCode, value);
  }

  Language getLocale() {
    final storeLanguageCode =
        _storageBox.read(_languageCode) ?? LanguageName.vn;
    return getLanguageFromCode(storeLanguageCode);
  }
}
