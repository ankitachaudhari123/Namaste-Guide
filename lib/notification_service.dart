import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';


class NotificationService {
  // ✅ Plugin instance (public)
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Public getter in case needed elsewhere
  static FlutterLocalNotificationsPlugin get plugin => _notificationsPlugin;

  static Future<void> init() async {
  const androidSettings = AndroidInitializationSettings('logo');
  final settings = InitializationSettings(android: androidSettings);

  await _notificationsPlugin.initialize(settings);

  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName)); // 🛠️ Add this line
}

  
static Future<void> scheduleDailyNotification({
  required int hour,
  required int minutes,
}) async {
  const androidDetails = AndroidNotificationDetails(
    'daily_yoga_reminder_channel',
    'Daily Yoga Reminder',
    channelDescription: 'Reminds you daily to practice yoga',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const platformDetails = NotificationDetails(android: androidDetails);

  final scheduledTime = _nextInstanceOfTime(hour, minutes);
  print("🔔 Notification scheduled at: $scheduledTime"); // 🧪 This will show actual time

  await _notificationsPlugin.zonedSchedule(
  0,
  '🧘‍♀️ Yoga Time',
  'It’s time for your daily yoga session 🧘',
  scheduledTime,
  const NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_yoga_channel',
      'Daily Yoga Reminder',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    ),
  ),
  androidAllowWhileIdle: true, // ✅ THIS is the key part
  uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
  matchDateTimeComponents: DateTimeComponents.time,
);

}

  /// ✅ Cancel all scheduled notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  /// ✅ Helper to get the next instance of the target time
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minutes) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
