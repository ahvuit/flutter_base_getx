import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import 'storage_service.dart';

@injectable
class GetStorageService implements StorageService {
  static final _storage = GetStorage();

  @override
  Future<void> write(String key, dynamic value) async =>
      await _storage.write(key, value);
  @override
  Future<String?> read(String key) async => _storage.read(key);
  @override
  Future<void> delete(String key) async => await _storage.remove(key);
  @override
  Future<void> clear() async => {};
}
