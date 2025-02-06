import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base_getx/app/config/env_config.dart';
import 'package:flutter_base_getx/app/core/utils/firebase_utils.dart';
import 'package:flutter_base_getx/app/core/utils/local_notification_utils.dart';
import 'package:flutter_base_getx/app/data/models/notification/local_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  /// Send [fcmToken] to BE
  Future<void> registerDeviceWithToken(String? fcmToken) async {
    // todo
    // You must implement it
  }

  /// Handle click open notification and navigate to page notification
  Future<void> _handleNavigateNotification(
    LocalNotification notification,
  ) async {
    // todo to navigate to page with notification clicked
  }

  /// Initializes notifications with the given [env] configuration.
  Future<void> initNotification(EnvConfig env) async {
    try {
      await FirebaseUtils.initFirebase(options: env.firebaseOptions);
      await FirebaseUtils.requestNotificationPermissions();
      LocalNotificationUtils.initialize(
        onSelectNotification: _handleSelectNotification,
      );

      FirebaseUtils.setUpFCMMessage(
        onReceiverFCMToken: _handleTokenChange,
        onReceiveMessage: handleReceiveMessage,
        onMessageOpenedApp: _handleMessageOpenedApp,
        onReceiveBackgroundMessage: onBackgroundMessage,
      );
    } catch (e) {
      debugPrint('Failed to initialize notifications: $e');
    }
  }

  /// Handles token changes and registers the device with the new token.
  Future<void> _handleTokenChange(String? token) async {
    debugPrint('_handleTokenChange');
    try {
      await registerDeviceWithToken(token);
    } catch (e) {
      debugPrint('Failed to handle token change: $e');
    }
  }

  /// Handles receiving a message and shows a local notification.
  void handleReceiveMessage(RemoteMessage message) {
    final localNotification = message.toLocalModel();
    final title = localNotification.notificationTitle;
    final content = localNotification.notificationContent;
    final payload = jsonEncode(localNotification);
    LocalNotificationUtils.showNotification(
      title: title,
      content: content,
      payload: payload,
    );
  }

  /// Handles selecting a notification and navigates to the appropriate page.
  void _handleSelectNotification(NotificationResponse response) {
    debugPrint('select notification, payload= ${response.payload}');
    if (response.payload != null) {
      final message = LocalNotification.fromJson(jsonDecode(response.payload!));
      debugPrint(
        'select notification, message= $message data= ${message.data}',
      );
      _handleNavigateNotification(message);
    }
  }

  /// Handles opening the app from a notification.
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('message opened app, message= $message');
    _handleNavigateNotification(message.toLocalModel());
  }
}

/// Handle android firebase background message
Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint('onBackgroundMessage - $message');
  if (message.notification == null) {
    NotificationUtils().handleReceiveMessage(message);
  }
}
