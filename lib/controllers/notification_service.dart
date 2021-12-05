import 'package:family/routes.dart';
import 'package:family/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> selectNotification(BuildContext context, String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: routes[HomeWidget.routeName]!),
    );
  }

  requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotifications(int notifId, String title, String body) async {
    const AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails(
      'channel ID',
      'channel name',
      channelDescription: 'channel description',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin.show(
      notifId,
      title,
      body,
      const NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
