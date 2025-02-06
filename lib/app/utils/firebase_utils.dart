import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

class FirebaseUtils {
  static Future<void> initFirebase(
      {String? name, FirebaseOptions? options}) async {
    await Firebase.initializeApp(name: name, options: options);
    // Pass all uncaught errors from the framework to Crashlytics.

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    debugPrint('onBackgroundMessage - $message');
  }

  static void setUpFCMMessage(
    Function(String?) onReceiverFCMToken, {
    Function(RemoteMessage message)? onReceiveMessage,
    Function(RemoteMessage message)? onMessageOpenedApp,
    Future<void> Function(RemoteMessage message)? onReceiveBackgroundMessage,
  }) async {
    FirebaseMessaging.onBackgroundMessage(
        onReceiveBackgroundMessage ?? onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) async {
        debugPrint('onMessage - ${message.notification}');
        onReceiveMessage?.call(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      onMessageOpenedApp?.call(message);
    });

    final token = await FirebaseMessaging.instance.getToken();
    onReceiverFCMToken(token);
    debugPrint('token: ${token ?? ''}');

    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      debugPrint('token refresh: $token');
      onReceiverFCMToken(token);
    });
  }

  static Future requestNotificationPermissions() async {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
