import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

class FirebaseUtils {
  static FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;
  /// Initializes Firebase with the given [name] and [options].
  /// Sets up Crashlytics to capture all uncaught errors.
  static Future<void> initFirebase({
    String? name,
    FirebaseOptions? options,
  }) async {
    try {
      await Firebase.initializeApp(name: name, options: options);
      // // Pass all uncaught errors from the framework to Crashlytics.
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } catch (e) {
      debugPrint('Failed to initialize Firebase: $e');
    }
  }

  /// Handles background messages received from FCM.
  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    debugPrint('onBackgroundMessage - $message');
  }

  /// Sets up FCM message handlers.
  /// [onReceiverFCMToken] is called with the FCM token.
  /// [onReceiveMessage] is called when a message is received while the app is in the foreground.
  /// [onMessageOpenedApp] is called when a message is opened from a notification.
  /// [onReceiveBackgroundMessage] is called when a message is received while the app is in the background.
  static void setUpFCMMessage({
    required Function(String?) onReceiverFCMToken,
    Function(RemoteMessage message)? onReceiveMessage,
    Function(RemoteMessage message)? onMessageOpenedApp,
    Function(RemoteMessage message)? onInitialMessage,
    Future<void> Function(RemoteMessage message)? onReceiveBackgroundMessage,
  }) async {
    try {
      FirebaseMessaging.onBackgroundMessage(
        onReceiveBackgroundMessage ?? onBackgroundMessage,
      );
      FirebaseMessaging.onMessage.listen((message) async {
        debugPrint('onMessage - ${message.notification}');
        onReceiveMessage?.call(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        debugPrint('onMessageOpenedApp - ${message.notification}');
        onMessageOpenedApp?.call(message);
      });

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          debugPrint('onInitialMessage - ${message.notification}');
          onInitialMessage?.call(message);
        }
      });

      final token = await firebaseMessaging.getToken();
      onReceiverFCMToken(token);
      debugPrint('token: ${token ?? ''}');

      firebaseMessaging.onTokenRefresh.listen((token) async {
        debugPrint('token refresh: $token');
        onReceiverFCMToken(token);
      });
    } catch (e) {
      debugPrint('Failed to set up FCM: $e');
    }
  }

  /// Requests notification permissions from the user.
  static Future requestNotificationPermissions() async {
    try {
      await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } catch (e) {
      debugPrint('Failed to request notification permissions: $e');
    }
  }
}
