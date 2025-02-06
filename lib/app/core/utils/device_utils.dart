import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:safe_device/safe_device.dart';
import 'package:universal_platform/universal_platform.dart';

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

  static Future<bool> isSafeDevice() async {
    return await isRealDevice() && !await isRootedDevice();
  }

  static Future<bool> isRealDevice() async {
    bool realDevice = true;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (UniversalPlatform.isAndroid) {
      var androidDeviceInfo = (await deviceInfoPlugin.androidInfo);
      realDevice = androidDeviceInfo.isPhysicalDevice;
    } else if (UniversalPlatform.isIOS) {
      var iOsDeviceInfo = await deviceInfoPlugin.iosInfo;
      realDevice = iOsDeviceInfo.isPhysicalDevice;
    }
    return realDevice;
  }

  static Future<bool> isRootedDevice() async {
    return await SafeDevice.isJailBroken;
  }
}