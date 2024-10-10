import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../configs/routes/main_route.dart';
import '../../modules/features/home/controllers/home_controller.dart';

class FirebaseMessageService {
  static FirebaseMessaging instance = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const channel = AndroidNotificationChannel(
      'order_notification_channel',
      'order channel',
      description: 'order data channel',
      importance: Importance.high,
    );

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: darwinInitializationSettings,
    );

    await localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(
      (event) async {
        log('onMessage: $event');
        await FirebaseMessageService.handleNotif(event);
      },
      onError: (e) => log(e),
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    log('payload ${response.payload}');
    if (response.payload != null) {
      final idOrder = int.parse(response.payload!);
      HomeController.to.orderKey!.currentState!.pushNamed(
        MainRoute.orderDetail,
        arguments: idOrder,
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> handleNotif(RemoteMessage message) async {
    log('foreground ${message.data}');

    final notificationData = message.notification;

    final androidNotificationDetail = AndroidNotificationDetails(
      'order_notification_channel',
      'order channel',
      channelDescription: 'order data channel',
      icon: notificationData?.android?.smallIcon,
      priority: Priority.high,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetail,
    );

    if (notificationData != null) {
      localNotifications.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notificationDetails,
        payload: message.data['id_order'],
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> handleBackgroundNotif(RemoteMessage message) async {
    log("Background ${message.data}");

    // get remote message data
    final notificationData = message.notification;

    final androidNotifDetail = AndroidNotificationDetails(
        'order_notification_channel', 'order channel',
        channelDescription: 'order data channel',
        icon: notificationData?.android?.smallIcon,
        priority: Priority.high);

    const darwinNotifDetail = DarwinNotificationDetails();

    final NotificationDetails notifDetail = NotificationDetails(
      android: androidNotifDetail,
      iOS: darwinNotifDetail,
    );

    if (notificationData != null) {
      localNotifications.show(
        notificationData.hashCode,
        notificationData.title,
        notificationData.body,
        notifDetail,
        payload: message.data['id_order'],
      );
    }
  }
}
