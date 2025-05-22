import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      getIt<CoreLogger>().i('Storage permission granted');
      return true;
    } else {
      getIt<CoreLogger>().w('Storage permission denied');
      return false;
    }
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      getIt<CoreLogger>().i('Camera permission granted');
      return true;
    } else {
      getIt<CoreLogger>().w('Camera permission denied');
      return false;
    }
  }

  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions) async {
    final statuses = await permissions.request();
    statuses.forEach((permission, status) {
      if (status.isGranted) {
        getIt<CoreLogger>().i('${permission.toString()} permission granted');
      } else {
        getIt<CoreLogger>().w('${permission.toString()} permission denied');
      }
    });
    return statuses;
  }
}
