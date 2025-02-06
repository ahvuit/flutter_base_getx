import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/core/storage/core/get_storage_service.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class TokenCacheManager {
  ///Keys
  static const _accessToken = '_accessToken';
  static const _refreshToken = '_refreshToken';

  ///Storage box
  final storageBox = getIt<GetStorageService>();

  final logger = getIt<CoreLogger>();

  ///Initiate Get Storage
  Future<void> initGetStorage() async {
    logger.i('Initializing Get Storage...');
    await GetStorage.init();
    logger.i('Get Storage initialized!');
  }

  Future<void> saveToken(String? token) async {
    if (token == null) {
      logger.i('Token is null, setting empty value');
    }
    logger.i('Setting token: $token');
    await storageBox.write(_accessToken, token ?? '');
  }

  Future<String> getToken() {
    final token = storageBox.read(_accessToken);
    logger.i('Token: $token');
    return token;
  }

  void removeToken() {
    logger.i('Remove Token');
    storageBox.write(_accessToken, '');
  }

  Future<void> saveRefreshToken(String? token) async {
    if (token == null) {
      logger.i('Refresh Token is null, setting empty value');
    }
    logger.i('Setting Refresh Token: $token');
    await storageBox.write(_refreshToken, token ?? '');
  }

  Future<String> getRefreshToken() {
    final token = storageBox.read(_refreshToken);
    logger.i('Refresh token: $token');
    return token;
  }

  void removeRefreshToken() {
    logger.i('Remove Refresh Token');
    storageBox.write(_refreshToken, '');
  }
}
