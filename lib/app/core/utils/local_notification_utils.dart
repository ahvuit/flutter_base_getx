import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/widgets.dart';

class LocalNotificationUtils {
  static FlutterLocalNotificationsPlugin get _localNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  /// Initializes the local notifications plugin with the given [onSelectNotification] callback.
  static void initialize({
    void Function(NotificationResponse)? onSelectNotification,
  }) {
    try {
      final InitializationSettings initializationSettings =
          InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: const DarwinInitializationSettings(),
          );
      _localNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            onSelectNotification ?? (NotificationResponse payload) {},
      );
    } catch (e) {
      debugPrint('Failed to initialize local notifications: $e');
    }
  }

  /// Shows a notification when the app is in the foreground.
  static Future<void> showNotificationOnForeground(
    RemoteMessage message,
  ) async {
    try {
      if (message.notification == null) {
        debugPrint('No notification payload found in the message.');
        return;
      }
      showNotification(
        title: message.notification?.title ?? '',
        content: message.notification?.body ?? '',
        payload: message.data['message'],
      );
    } catch (e) {
      debugPrint('Failed to show notification on foreground: $e');
    }
  }

  /// Shows a local notification with the given [title], [content], [payload], and [imagePath].
  static Future<void> showNotification({
    required String title,
    required String content,
    String? payload,
    String? imagePath,
  }) async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String projectAppID = packageInfo.packageName;

      final androidNotificationStyle =
          imagePath?.isNotEmpty == true
              ? BigPictureStyleInformation(
                FilePathAndroidBitmap(imagePath!),
                contentTitle: title,
                summaryText: content,
                htmlFormatContentTitle: true,
                htmlFormatSummaryText: true,
                htmlFormatTitle: true,
                htmlFormatContent: true,
                hideExpandedLargeIcon: true,
              )
              : const DefaultStyleInformation(true, true);
      final notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
          projectAppID,
          'firebase_push_notification',
          icon: '@mipmap/ic_launcher',
          largeIcon:
              imagePath?.isNotEmpty == true
                  ? FilePathAndroidBitmap(imagePath!)
                  : null,
          styleInformation: androidNotificationStyle,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: false,
          sound: '',
          subtitle: '',
          attachments: [
            if (imagePath?.isNotEmpty == true)
              DarwinNotificationAttachment(imagePath!),
          ],
        ),
      );

      _localNotificationsPlugin.show(
        DateTime.now().microsecond,
        title,
        content,
        notificationDetail,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Failed to show notification: $e');
    }
  }
}
