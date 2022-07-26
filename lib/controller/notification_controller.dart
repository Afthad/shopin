import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('shopInId', 'shopIN name',
            importance: Importance.high, icon: '@mipmap/ic_launcher'));
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return _notifications.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }
}
