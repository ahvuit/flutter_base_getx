import 'package:uuid/uuid.dart';
import '../logger/logger_service.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class UuidUtils {
  static String generateUuid() {
    final uuid = const Uuid().v4();
    di.sl<LoggerService>().i('Generated UUID: $uuid');
    return uuid;
  }
}