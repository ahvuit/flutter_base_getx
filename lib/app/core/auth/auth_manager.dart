import 'package:flutter_base_getx/app/core/storage/core/token_manager.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthManager extends TokenCacheManager {
  Future<void> logOut() async {
    clearTokens();
  }

  Future<bool> isLogin() async {
    final token = await getToken();
    final isLoggedIn = token.isNotEmpty;
    return isLoggedIn;
  }
}