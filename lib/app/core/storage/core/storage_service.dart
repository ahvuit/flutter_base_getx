/// Abstract interface for storage operations.
/// Defines methods for reading, writing, deleting, and clearing key-value data.
abstract class StorageService {
  /// Writes a value to storage with the given key.
  void write(String key, dynamic value);

  /// Reads a value from storage by key.
  /// Returns null if the key does not exist.
  String? read(String key);

  /// Deletes a value from storage by key.
  void delete(String key);

  /// Clears all data in storage.
  void clear();

  /// Checks if a key exists in storage.
  bool hasKey(String key);
}
