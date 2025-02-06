import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Manages token storage using GetStorageService.
/// Provides methods to save, retrieve, and remove access and refresh tokens.
@singleton
class TokenCacheManager {
  // Keys for storing tokens
  static const _accessToken = '_accessToken';
  static const _refreshToken = '_refreshToken';

  // Storage service for key-value operations
  late final GetStorageService _storageBox;

  // Logger for debugging and error tracking
  late final CoreLogger _logger;

  /// Saves the access token to storage.
  /// [token] The access token to save. If null, an empty string is saved.
  Future<void> saveToken(String? token) async {
    final value = token ?? '';
    _logger.i('Saving access token: $value');
    _storageBox.write(_accessToken, value);
  }

  /// Retrieves the access token from storage.
  /// Returns the token as a String, or an empty string if not found.
  Future<String> getToken() async {
    try {
      final token = _storageBox.read(_accessToken) ?? '';
      _logger.i('Retrieved access token: $token');
      return token;
    } catch (e) {
      _logger.e('Failed to retrieve access token: $e');
      return ''; // Fallback to empty string on error
    }
  }

  /// Removes the access token from storage.
  void removeToken() {
    _logger.i('Removing access token');
    _storageBox.write(_accessToken, '');
  }

  /// Saves the refresh token to storage.
  /// [token] The refresh token to save. If null, an empty string is saved.
  void saveRefreshToken(String? token) {
    final value = token ?? '';
    _logger.i('Saving refresh token: $value');
    _storageBox.write(_refreshToken, value);
  }

  /// Retrieves the refresh token from storage.
  /// Returns the token as a String, or an empty string if not found.
  String getRefreshToken() {
    try {
      final token = _storageBox.read(_refreshToken) ?? '';
      _logger.i('Retrieved refresh token: $token');
      return token;
    } catch (e) {
      _logger.e('Failed to retrieve refresh token: $e');
      return ''; // Fallback to empty string on error
    }
  }

  /// Removes the refresh token from storage.
  void removeRefreshToken() {
    _logger.i('Removing refresh token');
    _storageBox.write(_refreshToken, '');
  }

  /// Clears all tokens (access and refresh) from storage.
  void clearTokens() {
    _logger.i('Clearing all tokens');
    removeToken();
    removeRefreshToken();
  }
}
