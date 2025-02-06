import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class SharedPreferencesService implements StorageService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  @override
  Future<void> write(String key, String value) async => await _prefs.setString(key, value);
  @override
  Future<String?> read(String key) async => _prefs.getString(key);
  @override
  Future<void> delete(String key) async => await _prefs.remove(key);
  @override
  Future<void> clear() async => await _prefs.clear();
}