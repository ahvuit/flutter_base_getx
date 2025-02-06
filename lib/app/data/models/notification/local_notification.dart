import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotification {
  final Notification? notification;
  final Data? data;

  LocalNotification({
    this.notification,
    this.data,
  });

  String get notificationTitle => data?.title ?? notification?.title ?? '';

  String get notificationContent => data?.message ?? notification?.body ?? '';

  String get popupTitle =>
      data?.notificationData?.title ?? data?.title ?? notification?.title ?? '';

  String get popupContent =>
      data?.notificationData?.description ??
      data?.message ??
      notification?.body ??
      '';

  factory LocalNotification.fromJson(Map<String, dynamic> json) =>
      LocalNotification(
        notification: json['notification'] == null
            ? null
            : Notification.fromJson(
                json['notification'] as Map<String, dynamic>),
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'notification': notification,
        'data': data,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalNotification &&
          runtimeType == other.runtimeType &&
          notification == other.notification &&
          data == other.data;

  @override
  int get hashCode => notification.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'LocalNotification{notification: $notification, data: $data}';
  }
}

class Notification {
  final String? title;
  final String? body;

  Notification({this.title, this.body});

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json['title'] as String?,
        body: json['body'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'body': body,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Notification &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body;

  @override
  int get hashCode => title.hashCode ^ body.hashCode;

  @override
  String toString() {
    return 'Notification{title: $title, body: $body}';
  }
}

class Data {
  final String? title;
  final String? message;
  final String? type;
  final String? lenderLogoName;
  final String? notificationFrom;
  final String? applicationId;
  final NotificationData? notificationData;

  Data({
    this.title,
    this.message,
    this.type,
    this.lenderLogoName,
    this.notificationFrom,
    this.applicationId,
    this.notificationData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json['title'] as String?,
        message: json['message'] as String?,
        type: json['type'] as String?,
        lenderLogoName: json['lenderLogoName'] as String?,
        notificationFrom: json['notificationFrom'] as String?,
        applicationId: json['applicationId'] as String?,
        notificationData: json['notificationData'] == null
            ? null
            : NotificationData.fromJson(
                json['notificationData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'message': message,
        'type': type,
        'lenderLogoName': lenderLogoName,
        'notificationFrom': notificationFrom,
        'applicationId': applicationId,
        'notificationData': notificationData,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          message == other.message &&
          type == other.type &&
          lenderLogoName == other.lenderLogoName &&
          notificationFrom == other.notificationFrom &&
          applicationId == other.applicationId &&
          notificationData == other.notificationData;

  @override
  int get hashCode =>
      title.hashCode ^
      message.hashCode ^
      type.hashCode ^
      lenderLogoName.hashCode ^
      notificationFrom.hashCode ^
      applicationId.hashCode ^
      notificationData.hashCode;

  @override
  String toString() {
    return 'Data{title: $title, message: $message, type: $type, lenderLogoName: $lenderLogoName, notificationFrom: $notificationFrom, applicationId: $applicationId, notificationData: $notificationData}';
  }
}

class NotificationData {
  final String? title;
  final String? description;

  NotificationData({
    this.title,
    this.description,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        title: json['title'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationData &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'NotificationData{title: $title, description: $description}';
  }
}

extension RemoteToLocal on RemoteMessage {
  LocalNotification toLocalModel() {
    NotificationData? notificationData;
    if (data['notificationData'] != null) {
      final jsonData = jsonDecode(data['notificationData']);
      notificationData = NotificationData(
        title: jsonData['title'],
        description: jsonData['description'],
      );
    }

    return LocalNotification(
        notification: Notification(
          title: notification?.title,
          body: notification?.body,
        ),
        data: Data(
          title: data['title'],
          message: data['message'],
          type: data['type'],
          lenderLogoName: data['lenderLogoName'],
          notificationFrom: data['notificationFrom'],
          applicationId: data['applicationId'],
          notificationData: notificationData,
        ));
  }
}
