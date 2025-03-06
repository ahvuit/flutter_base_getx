import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';

class DeviceUtils {
  static Future<String> getDeviceId() async {
    final logger = getIt<CoreLogger>();
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      logger.i('Android Device ID: ${androidInfo.id}');
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      logger.i('iOS Device ID: ${iosInfo.identifierForVendor}');
      return iosInfo.identifierForVendor ?? 'unknown';
    }
    return 'unknown';
  }

  static Future<String> getDeviceName() async {
    final logger = getIt<CoreLogger>();
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      logger.i('Android Device Name: ${androidInfo.model}');
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      logger.i('iOS Device Name: ${iosInfo.utsname.machine}');
      return iosInfo.utsname.machine;
    }
    return 'unknown';
  }
}