import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/data/models/notification/local_notification.dart';
import 'package:flutter_base_getx/app/core/utils/firebase_utils.dart';
import 'package:flutter_base_getx/app/core/utils/local_notification_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  /// Send [fcmToken] to BE
  Future<void> registerDeviceWithToken(String? fcmToken) async {
    // todo
    // You must implement it
  }

  /// Handle click open notification and navigate to page notification
  Future<void> _handleNavigateNotification(
      LocalNotification notification) async {
    // todo to navigate to page with notification clicked
  }

  Future<void> initNotification(EnvConfig env) async {
    await FirebaseUtils.initFirebase(
      options: Platform.isAndroid
          ? env.firebaseConfig.android
          : env.firebaseConfig.ios,
    );
    await FirebaseUtils.requestNotificationPermissions();
    LocalNotificationUtils.initialize(
        onSelectNotification: _handleSelectNotification);

    FirebaseUtils.setUpFCMMessage(
      _handleTokenChange,
      onReceiveMessage: (message) {
        LocalNotificationUtils.showNotificationOnForeground(message);
      },
      onMessageOpenedApp: _handleMessageOpenedApp,
      onReceiveBackgroundMessage: onBackgroundMessage,
    );
  }

  Future<void> _handleTokenChange(String? token) async {
    debugPrint('_handleTokenChange');
    await registerDeviceWithToken(token);
  }

  handleReceiveMessage(RemoteMessage message) {
    final localNotification = message.toLocalModel();
    final title = localNotification.notificationTitle;
    final content = localNotification.notificationContent;
    final payload = jsonEncode(localNotification);
    LocalNotificationUtils.showNotification(
        title: title, content: content, payload: payload);
  }

  _handleSelectNotification(NotificationResponse response) {
    debugPrint('select notification, payload= ${response.payload}');
    if (response.payload != null) {
      final message = LocalNotification.fromJson(jsonDecode(response.payload!));
      debugPrint(
          'select notification, message= $message data= ${message.data}');
      _handleNavigateNotification(message);
    }
  }

  _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('message opened app, message= $message');
    _handleNavigateNotification(message.toLocalModel());
  }
}

/// Handle android firebase background  message
Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint('onBackgroundMessage - $message');
  if (message.notification == null) {
    NotificationUtils().handleReceiveMessage(message);
  }
}
