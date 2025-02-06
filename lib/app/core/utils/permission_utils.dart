import 'package:permission_handler/permission_handler.dart';
import '../logger/logger_service.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class PermissionUtils {
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      di.sl<LoggerService>().i('Storage permission granted');
      return true;
    } else {
      di.sl<LoggerService>().w('Storage permission denied');
      return false;
    }
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      di.sl<LoggerService>().i('Camera permission granted');
      return true;
    } else {
      di.sl<LoggerService>().w('Camera permission denied');
      return false;
    }
  }

  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}