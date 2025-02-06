import 'package:flutter_base_getx/app/core/storage/core/token_manager.dart';

class AuthManager extends TokenCacheManager {

  logOut() async {
    removeToken();
    removeRefreshToken();
  }

  Future<bool> isLogin() async {
    String token = await getToken();
    return token.isNotEmpty;
  }
}
