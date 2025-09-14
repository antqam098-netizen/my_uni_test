import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void dailyDummyTask() async {
  FlutterLocalNotificationsPlugin plug = FlutterLocalNotificationsPlugin();
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  await plug.initialize(const InitializationSettings(android: android));
  plug.show(
      0,
      'تنبيه تجريبي',
      'هذا إشعار يومي بسيط',
      const NotificationDetails(
          android: AndroidNotificationDetails('daily', 'Daily',
              channelDescription: 'تنبيه يومي',
              importance: Importance.high,
              priority: Priority.high)));
}
