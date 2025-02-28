import 'package:encrypt/encrypt.dart' as encrypt;
import '../logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class EncryptUtils {
  static final _key = encrypt.Key.fromLength(32);
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypt = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptText(String plainText) {
    final encrypted = _encrypt.encrypt(plainText, iv: _iv);
    di.sl<CoreLogger>().i('Text encrypted');
    return encrypted.base64;
  }

  static String decryptText(String encryptedText) {
    final decrypted = _encrypt.decrypt64(encryptedText, iv: _iv);
    di.sl<CoreLogger>().i('Text decrypted');
    return decrypted;
  }
}