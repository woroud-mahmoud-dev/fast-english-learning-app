import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

import '../network/local/chach_helper.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    channelId,
    "thecodexhub",
    channelDescription:
        "This channel is responsible for all the local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

/*  static final IOSNotificationDetails _iOSNotificationDetails =
  IOSNotificationDetails();*/

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
  );

  static tz.TZDateTime _scheduleDaily(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  static tz.TZDateTime _scheduleWeekly(DateTime time,
      {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    initializeTimeZones();

    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await flutterLocalNotificationsPlugin.initialize(
        initializationSettings, onDidReceiveNotificationResponse: (response) {
      if (kDebugMode) {
        print(response.payload.toString());
      }
    });

    List<int> daysOfNotification =
        toDays(await CacheHelper.getData(key: 'daysOfNotification'));
    DateTime timeOfNotification =
        DateTime.parse(await CacheHelper.getData(key: 'timeOfNotification'));

    daysOfNotification.map((e) {
      if (kDebugMode) {
        print(e);
      }
      showWeeklyScheduledNotification(
          title: "تعلم اللغة الانجليزية",
          body: "حان وقت تعلم اللغة الانجليزية هيا بنا نبدأ",
          scheduledDate: _scheduleWeekly(
              DateTime(timeOfNotification.hour, timeOfNotification.minute,
                  timeOfNotification.second),
              days: [e]));
    });
    if (kDebugMode) {
      print(
          "Notifications: $initialized \n and will notifier in $daysOfNotification $timeOfNotification");
    }
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
      int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future showDailyScheduledNotification({
    int id = 0221,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(DateTime(0, 0, 5)),
        //tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails,
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
  List<int> toDays(List<String> myDays) {
    return myDays.map((e) {
      switch (e) {
        case "الجمعة":
          return DateTime.friday;
        case "الخميس":
          return DateTime.thursday;
        case "الأربعاء":
          return DateTime.wednesday;
        case "الثلاثاء":
          return DateTime.tuesday;
        case "الأثنين":
          return DateTime.monday;
        case "الأحد":
          return DateTime.sunday;
        case "السبت":
          return DateTime.saturday;

        default:
          return DateTime.friday;
      }
    }).toList();
  }

  Future showWeeklyScheduledNotification({
    int id = 0221,
    String? title,
    String? body,
    String? payload,
    DateTime? scheduledDate,
  }) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate!, tz.local),
      notificationDetails,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleNotification(int id, String title, String body,
      DateTime eventDate, TimeOfDay eventTime, String payload,
      [DateTimeComponents? dateTimeComponents]) async {
    final scheduledTime = eventDate.add(Duration(
      hours: eventTime.hour,
      minutes: eventTime.minute,
    ));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> onSelectNotification(String? payload) async {
/*await navigatorKey.currentState
      ?.push(MaterialPageRoute(builder: (_) => DetailsPage(payload: payload)));*/
}
