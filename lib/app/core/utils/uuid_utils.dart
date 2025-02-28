import 'package:uuid/uuid.dart';
import '../logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class UuidUtils {
  static String generateUuid() {
    final uuid = const Uuid().v4();
    di.sl<CoreLogger>().i('Generated UUID: $uuid');
    return uuid;
  }
}