import 'package:permission_handler/permission_handler.dart';
import '../logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/locator.dart' as di;

class PermissionUtils {
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      di.sl<CoreLogger>().i('Storage permission granted');
      return true;
    } else {
      di.sl<CoreLogger>().w('Storage permission denied');
      return false;
    }
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      di.sl<CoreLogger>().i('Camera permission granted');
      return true;
    } else {
      di.sl<CoreLogger>().w('Camera permission denied');
      return false;
    }
  }

  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }
}