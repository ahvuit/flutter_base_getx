abstract class StorageService {
  Future<void> write(String key, dynamic value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}