import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:uuid/uuid.dart';


class UuidUtils {
  static String generateUuid() {
    final uuid = const Uuid().v4();
    getIt<CoreLogger>().i('Generated UUID: $uuid');
    return uuid;
  }
}