import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import 'storage_service.dart';

/// A service that provides persistent storage using GetStorage.
/// Implements the StorageService interface for key-value storage operations.
@singleton
class GetStorageService implements StorageService {
  static final _storage = GetStorage();

  /// Initializes GetStorage and ensures it's ready for use.
  Future<void> initGetStorage() async {
    try {
      log('Initializing GetStorage...');
      await GetStorage.init();
      log('GetStorage initialized successfully!');
    } catch (e) {
      StorageException('Failed to initialize GetStorage: $e');
      rethrow;
    }
  }

  /// Writes a value to storage with the given key.
  /// [key] The key to identify the value.
  /// [value] The value to store (can be any type supported by GetStorage).
  @override
  void write(String key, dynamic value) {
    try {
      _storage.write(key, value);
    } catch (e) {
      throw StorageException('Failed to write key "$key": $e');
    }
  }

  /// Reads a value from storage by key.
  /// [key] The key to look up.
  /// Returns the value as a String, or null if the key does not exist.
  @override
  String? read(String key) {
    try {
      return _storage.read<String?>(key);
    } catch (e) {
      throw StorageException('Failed to read key "$key": $e');
    }
  }

  /// Deletes a value from storage by key.
  /// [key] The key to remove.
  @override
  void delete(String key) {
    try {
      _storage.remove(key);
    } catch (e) {
      throw StorageException('Failed to delete key "$key": $e');
    }
  }

  /// Clears all data in storage.
  @override
  void clear() {
    try {
      _storage.erase();
    } catch (e) {
      throw StorageException('Failed to clear storage: $e');
    }
  }

  @override
  bool hasKey(String key) {
    try {
      return _storage.hasData(key);
    } catch (e) {
      throw StorageException('Failed to check key "$key": $e');
    }
  }
}

/// Custom exception for storage-related errors.
class StorageException implements Exception {
  final String message;

  StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}
