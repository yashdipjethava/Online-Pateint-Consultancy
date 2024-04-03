import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();
  static Future _notificationDetail() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelId1", "channelName1",
            importance: Importance.max,
            playSound: true,
            priority: Priority.max));
  }

  static Future showPeriodicNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required RepeatInterval? repeatInterval}) async {
    return await _notification.periodicallyShow(
        id, title, body, repeatInterval!, await _notificationDetail(),
        payload: payload);
  }

  static Future showNotification({
    int id = 1,
    String? title,
    String? body,
    String? payload,
    required DateTime dateTime,
  }) async {
    return await _notification.show(
      id,
      title,
      body,
      await _notificationDetail(),
      payload: payload,
    );
  }

  static Future init({bool init = false}) async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android);

    await _notification.initialize(setting);
  }
}
