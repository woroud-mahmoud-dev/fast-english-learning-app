import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

List<int> toDays(List myDays ){

  return myDays.map<int>((e){
    switch (e){
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

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';


Future<void> showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithActions() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    actions: <AndroidNotificationAction>[
      AndroidNotificationAction(
        urlLaunchActionId,
        'Action 1',
        icon: DrawableResourceAndroidBitmap('food'),
        contextual: true,
      ),
      AndroidNotificationAction(
        'id_2',
        'Action 2',
        titleColor: Color.fromARGB(255, 255, 0, 0),
        icon: DrawableResourceAndroidBitmap('secondary_icon'),
      ),
      AndroidNotificationAction(
        navigationActionId,
        'Action 3',
        icon: DrawableResourceAndroidBitmap('secondary_icon'),
        showsUserInterface: true,
        // By default, Android plugin will dismiss the notification when the
        // user tapped on a action (this mimics the behavior on iOS).
        cancelNotification: false,
      ),
    ],
  );

  const DarwinNotificationDetails iosNotificationDetails =
  DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  const DarwinNotificationDetails macOSNotificationDetails =
  DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );

  const LinuxNotificationDetails linuxNotificationDetails =
  LinuxNotificationDetails(
    actions: <LinuxNotificationAction>[
      LinuxNotificationAction(
        key: urlLaunchActionId,
        label: 'Action 1',
      ),
      LinuxNotificationAction(
        key: navigationActionId,
        label: 'Action 2',
      ),
    ],
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosNotificationDetails,
    macOS: macOSNotificationDetails,
    linux: linuxNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item z');
}

Future<void> showNotificationWithTextAction() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    actions: <AndroidNotificationAction>[
      AndroidNotificationAction(
        'text_id_1',
        'Enter Text',
        icon: DrawableResourceAndroidBitmap('food'),
        inputs: <AndroidNotificationActionInput>[
          AndroidNotificationActionInput(
            label: 'Enter a message',
          ),
        ],
      ),
    ],
  );

  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryText,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
    macOS: darwinNotificationDetails,
  );

  await flutterLocalNotificationsPlugin.show(id++, 'Text Input Notification',
      'Expand to see input action', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithIconAction() async {
  const LinuxNotificationDetails linuxNotificationDetails =
  LinuxNotificationDetails(
    actions: <LinuxNotificationAction>[
      LinuxNotificationAction(
        key: 'media-eject',
        label: 'Eject',
      ),
    ],
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    linux: linuxNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item z');
}

Future<void> showNotificationWithTextChoice() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    actions: <AndroidNotificationAction>[
      AndroidNotificationAction(
        'text_id_2',
        'Action 2',
        icon: DrawableResourceAndroidBitmap('food'),
        inputs: <AndroidNotificationActionInput>[
          AndroidNotificationActionInput(
            choices: <String>['ABC', 'DEF'],
            allowFreeFormInput: false,
          ),
        ],
        contextual: true,
      ),
    ],
  );

  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryText,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
    macOS: darwinNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> showFullScreenNotification(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Turn off your screen'),
      content: const Text(
          'to see the full-screen intent in 5 seconds, press OK and TURN '
              'OFF your screen'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await flutterLocalNotificationsPlugin.zonedSchedule(
                0,
                'scheduled title',
                'scheduled body',
                tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                const NotificationDetails(
                    android: AndroidNotificationDetails(
                        'full screen channel id', 'full screen channel name',
                        channelDescription: 'full screen channel description',
                        priority: Priority.high,
                        importance: Importance.high,
                        fullScreenIntent: true)),
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime);

            //Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    ),
  );
}

Future<void> showNotificationWithNoBody() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', null, notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithNoTitle() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await flutterLocalNotificationsPlugin
      .show(id++, null, 'plain body', notificationDetails, payload: 'item x');
}

Future<void> cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancel(--id);
}

Future<void> cancelNotificationWithTag() async {
  await flutterLocalNotificationsPlugin.cancel(--id, tag: 'tag');
}

Future<void> showNotificationCustomSound() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your other channel id',
    'your other channel name',
    channelDescription: 'your other channel description',
    sound: RawResourceAndroidNotificationSound('slow_spring_board'),
  );
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(sound: 'slow_spring_board.aiff');
  final LinuxNotificationDetails linuxPlatformChannelSpecifics =
  LinuxNotificationDetails(
    sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
  );
  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
    macOS: darwinNotificationDetails,
    linux: linuxPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    id++,
    'custom sound notification title',
    'custom sound notification body',
    notificationDetails,
  );
}

Future<void> showNotificationCustomVibrationIconLed() async {
  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;

  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'other custom channel id', 'other custom channel name',
      channelDescription: 'other custom channel description',
      icon: 'secondary_icon',
      largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500);

  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'title of notification with custom vibration pattern, LED and icon',
      'body of notification with custom vibration pattern, LED and icon',
      notificationDetails);
}

Future<void> zonedScheduleNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'الإشعارات',
              channelDescription: 'your channel description')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime);
}

Future<void> showNotificationWithNoSound() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('silent channel id', 'silent channel name',
      channelDescription: 'silent channel description',
      playSound: false,
      styleInformation: DefaultStyleInformation(true, true));
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(presentSound: false);
  const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
}



Future<void> showTimeoutNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('silent channel id', 'silent channel name',
      channelDescription: 'silent channel description',
      timeoutAfter: 3000,
      styleInformation: DefaultStyleInformation(true, true));
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(id++, 'timeout notification',
      'Times out after 3 seconds', notificationDetails);
}

Future<void> showInsistentNotification() async {
  // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
  const int insistentFlag = 4;
  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      additionalFlags: Int32List.fromList(<int>[insistentFlag]));
  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'insistent title', 'insistent body', notificationDetails,
      payload: 'item x');
}


Future<void> showBigTextNotification() async {
  const BigTextStyleInformation bigTextStyleInformation =
  BigTextStyleInformation(
    'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    htmlFormatBigText: true,
    contentTitle: 'overridden <b>big</b> content title',
    htmlFormatContentTitle: true,
    summaryText: 'summary <i>text</i>',
    htmlFormatSummaryText: true,
  );
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'big text channel id', 'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigTextStyleInformation);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'big text title', 'silent body', notificationDetails);
}

Future<void> showInboxNotification() async {
  final List<String> lines = <String>['line <b>1</b>', 'line <i>2</i>'];
  final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      lines,
      htmlFormatLines: true,
      contentTitle: 'overridden <b>inbox</b> context title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true);
  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('inbox channel id', 'inboxchannel name',
      channelDescription: 'inbox channel description',
      styleInformation: inboxStyleInformation);
  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'inbox title', 'inbox body', notificationDetails);
}


Future<void> showGroupedNotifications() async {
  const String groupKey = 'com.android.example.WORK_EMAIL';
  const String groupChannelId = 'grouped channel id';
  const String groupChannelName = 'grouped channel name';
  const String groupChannelDescription = 'grouped channel description';
  // example based on https://developer.android.com/training/notify-user/group.html
  const AndroidNotificationDetails firstNotificationAndroidSpecifics =
  AndroidNotificationDetails(groupChannelId, groupChannelName,
      channelDescription: groupChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey);
  const NotificationDetails firstNotificationPlatformSpecifics =
  NotificationDetails(android: firstNotificationAndroidSpecifics);
  await flutterLocalNotificationsPlugin.show(id++, 'Alex Faarborg',
      'You will not believe...', firstNotificationPlatformSpecifics);
  const AndroidNotificationDetails secondNotificationAndroidSpecifics =
  AndroidNotificationDetails(groupChannelId, groupChannelName,
      channelDescription: groupChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      groupKey: groupKey);
  const NotificationDetails secondNotificationPlatformSpecifics =
  NotificationDetails(android: secondNotificationAndroidSpecifics);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'Jeff Chang',
      'Please join us to celebrate the...',
      secondNotificationPlatformSpecifics);

  // Create the summary notification to support older devices that pre-date
  /// Android 7.0 (API level 24).
  ///
  /// Recommended to create this regardless as the behaviour may vary as
  /// mentioned in https://developer.android.com/training/notify-user/group
  const List<String> lines = <String>[
    'Alex Faarborg  Check this out',
    'Jeff Chang    Launch Party'
  ];
  const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      lines,
      contentTitle: '2 messages',
      summaryText: 'janedoe@example.com');
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(groupChannelId, groupChannelName,
      channelDescription: groupChannelDescription,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'Attention', 'Two messages', notificationDetails);
}

Future<void> showNotificationWithTag() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      tag: 'tag');
  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
      id++, 'first notification', null, notificationDetails);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> showOngoingNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'ongoing notification title',
      'ongoing notification body',
      notificationDetails);
}

Future<void> repeatNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'repeating channel id', 'repeating channel name',
      channelDescription: 'repeating description');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.periodicallyShow(
      id++,
      'repeating title',
      'repeating body',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidAllowWhileIdle: true);
}

Future<void> scheduleDailyTenAMNotification() async {
  List<String> title = [
    'هيا بنا نبدأ, انت قريب جدا من تحقيق هدفك',
    'هذا الوقت هو الأنسب للبدأ بالتعلم',
    'لقد اقتربت من هدفك هيا نواصل التعلم',
    'هيا نبدأ بتعلم لغة جديدة'
  ];

  final random = Random();

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'حان وقت التعلم',
      title[random.nextInt(title.length)],
      nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('الإشعارات اليومية',
            'الإشعارات اليومية',
            channelDescription: 'سيتم ظهور إشعارات خلال الاوقات التي تم تحديدها سابقاً'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

/// To test we don't validate past dates when using `matchDateTimeComponents`
Future<void> scheduleDailyTenAMLastYearNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'حان وقت النعلم',
      'هيا بنا نبدأ التعلم في برنامج فاست',
      nextInstanceOfTenAMLastYear(),
      const NotificationDetails(
        android: AndroidNotificationDetails('daily notification channel id',
            'daily notification channel name',
            channelDescription: 'daily notification description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
}

Future<void> scheduleWeeklyTenAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'weekly scheduled notification title',
      'weekly scheduled notification body',
      nextInstanceOfTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('weekly notification channel id',
            'weekly notification channel name',
            channelDescription: 'weekly notificationdescription'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
}

Future<void> scheduleWeeklyMondayTenAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'weekly scheduled notification title',
      'weekly scheduled notification body',
      nextInstanceOfMondayTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('weekly notification channel id',
            'weekly notification channel name',
            channelDescription: 'weekly notificationdescription'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
}

Future<void> scheduleMonthlyMondayTenAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'monthly scheduled notification title',
      'monthly scheduled notification body',
      nextInstanceOfMondayTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('monthly notification channel id',
            'monthly notification channel name',
            channelDescription: 'monthly notificationdescription'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
}

Future<void> scheduleYearlyMondayTenAMNotification() async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'yearly scheduled notification title',
      'yearly scheduled notification body',
      nextInstanceOfMondayTenAM(),
      const NotificationDetails(
        android: AndroidNotificationDetails('yearly notification channel id',
            'yearly notification channel name',
            channelDescription: 'yearly notification description'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime);
}

tz.TZDateTime nextInstanceOfTenAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  DateTime timeOfNotification = DateTime.parse( CacheHelper.getData(key: 'timeOfNotification')??now.toIso8601String());
  List<int> daysOfNotification = toDays( CacheHelper.getData(key: 'daysOfNotification')??[1,2,3,4,5,6,7]);
  tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, timeOfNotification.hour ,timeOfNotification.minute);

  tz.TZDateTime dateTime = tz.TZDateTime.now(tz.local).add(const Duration(days: 1));

  int countError = 0;
  while(!daysOfNotification.contains(dateTime.weekday)){
    dateTime = dateTime.add(const Duration(days: 1));
    countError++;
    if(countError == 9){
      if (kDebugMode) {
        print('error : not found any days');
      }
      break;
    }
  }

  if (kDebugMode) {
    print('will notification after ${dateTime.difference(now).inDays} days');
  }

 daysOfNotification.map((e){
  if (kDebugMode) {
    print(e);
  }
  });

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(Duration(days: dateTime.difference(now).inDays ));
  }

  return scheduledDate;
}

tz.TZDateTime nextInstanceOfTenAMLastYear() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 13, 0 , 0 );
}

tz.TZDateTime nextInstanceOfMondayTenAM() {
  tz.TZDateTime scheduledDate = nextInstanceOfTenAM();
  while (scheduledDate.weekday != DateTime.monday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

Future<void> showNotificationWithNoBadge() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('no badge channel', 'no badge name',
      channelDescription: 'no badge description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'no badge title', 'no badge body', notificationDetails,
      payload: 'item x');
}

Future<void> showProgressNotification() async {
  id++;
  final int progressId = id;
  const int maxProgress = 5;
  for (int i = 0; i <= maxProgress; i++) {
    await Future<void>.delayed(const Duration(seconds: 1), () async {
      final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('progress channel', 'progress channel',
          channelDescription: 'progress channel description',
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i);
      final NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          progressId,
          'progress notification title',
          'progress notification body',
          notificationDetails,
          payload: 'item x');
    });
  }
}

Future<void> showIndeterminateProgressNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'indeterminate progress channel', 'indeterminate progress channel',
      channelDescription: 'indeterminate progress channel description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      indeterminate: true);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'indeterminate progress notification title',
      'indeterminate progress notification body',
      notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationUpdateChannelDescription() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your updated channel description',
      importance: Importance.max,
      priority: Priority.high,
      channelAction: AndroidNotificationChannelAction.update);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'updated notification channel',
      'check settings to see updated channel description',
      notificationDetails,
      payload: 'item x');
}

Future<void> showPublicNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      visibility: NotificationVisibility.public);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'public notification title',
      'public notification body',
      notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithSubtitle() async {
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(subtitle: 'the subtitle');
  const NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'title of notification with a subtitle',
      'body of notification with a subtitle',
      notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithIconBadge() async {
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(badgeNumber: 1);
  const NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'icon badge title', 'icon badge body', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationsWithThreadIdentifier() async {
  NotificationDetails buildNotificationDetailsForThread(
      String threadIdentifier,
      ) {
    final DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(threadIdentifier: threadIdentifier);
    return NotificationDetails(
        iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  }

  final NotificationDetails thread1PlatformChannelSpecifics =
  buildNotificationDetailsForThread('thread1');
  final NotificationDetails thread2PlatformChannelSpecifics =
  buildNotificationDetailsForThread('thread2');

  await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
      'first notification', thread1PlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
      'second notification', thread1PlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
      'third notification', thread1PlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
      'first notification', thread2PlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
      'second notification', thread2PlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
      'third notification', thread2PlatformChannelSpecifics);
}

Future<void> showNotificationWithTimeSensitiveInterruptionLevel() async {
  const DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.timeSensitive);
  const NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++,
      'title of time sensitive notification',
      'body of time sensitive notification',
      notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithoutTimestamp() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false);
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithCustomTimestamp() async {
  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
  );
  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithCustomSubText() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    subText: 'custom subtext',
  );
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> showNotificationWithChronometer() async {
  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
    usesChronometer: true,
    chronometerCountDown: true,
  );
  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: 'item x');
}

Future<void> createNotificationChannelGroup(BuildContext context) async {
  const String channelGroupId = 'your channel group id';
  // create the group first
  const AndroidNotificationChannelGroup androidNotificationChannelGroup =
  AndroidNotificationChannelGroup(
      channelGroupId, 'your channel group name',
      description: 'your channel group description');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannelGroup(androidNotificationChannelGroup);

  // create channels associated with the group
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(const AndroidNotificationChannel(
      'grouped channel id 1', 'grouped channel name 1',
      description: 'grouped channel description 1',
      groupId: channelGroupId));

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(const AndroidNotificationChannel(
      'grouped channel id 2', 'grouped channel name 2',
      description: 'grouped channel description 2',
      groupId: channelGroupId));

  await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Channel group with name '
            '${androidNotificationChannelGroup.name} created'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ));
}

Future<void> deleteNotificationChannelGroup(BuildContext context) async {
  const String channelGroupId = 'your channel group id';
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.deleteNotificationChannelGroup(channelGroupId);

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: const Text('Channel group with id $channelGroupId deleted'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> startForegroundService() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.startForegroundService(1, 'plain title', 'plain body',
      notificationDetails: androidNotificationDetails, payload: 'item x');
}

Future<void> startForegroundServiceWithBlueBackgroundNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your channel id',
    'الإشعارات',
    channelDescription: 'color background channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    color: Colors.blue,
    colorized: true,
  );

  /// only using foreground service can color the background
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.startForegroundService(
      1, 'colored background text title', 'colored background text body',
      notificationDetails: androidPlatformChannelSpecifics,
      payload: 'item x');
}

Future<void> stopForegroundService() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.stopForegroundService();
}

Future<void> createNotificationChannel(BuildContext context) async {
  const AndroidNotificationChannel androidNotificationChannel =
  AndroidNotificationChannel(
    'your channel id 2',
    'الإشعارات 2',
    description: 'your channel description 2',
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content:
        Text('Channel with name ${androidNotificationChannel.name} '
            'created'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ));
}

Future<void> areNotifcationsEnabledOnAndroid(BuildContext context) async {
  final bool? areEnabled = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.areNotificationsEnabled();
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(areEnabled == null
            ? 'ERROR: received null'
            : (areEnabled
            ? 'Notifications are enabled'
            : 'Notifications are NOT enabled')),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ));
}

Future<void> deleteNotificationChannel(BuildContext context) async {
  const String channelId = 'your channel id 2';
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.deleteNotificationChannel(channelId);

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: const Text('Channel with id $channelId deleted'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<void> getActiveNotifications(BuildContext context) async {
  final Widget activeNotificationsDialogContent =
  await getActiveNotificationsDialogContent(context);
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: activeNotificationsDialogContent,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<Widget> getActiveNotificationsDialogContent(BuildContext context) async {
  if (Platform.isAndroid) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt < 23) {
      return const Text(
        '"getActiveNotifications" is available only for Android 6.0 or newer',
      );
    }
  } else if (Platform.isIOS) {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final List<String> fullVersion = iosInfo.systemVersion!.split('.');
    if (fullVersion.isNotEmpty) {
      final int? version = int.tryParse(fullVersion[0]);
      if (version != null && version < 10) {
        return const Text(
          '"getActiveNotifications" is available only for iOS 10.0 or newer',
        );
      }
    }
  }

  try {
    final List<ActiveNotification> activeNotifications =
    await flutterLocalNotificationsPlugin.getActiveNotifications();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Active Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(color: Colors.black),
        if (activeNotifications.isEmpty)
          const Text('No active notifications'),
        if (activeNotifications.isNotEmpty)
          for (ActiveNotification activeNotification in activeNotifications)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'id: ${activeNotification.id}\n'
                      'channelId: ${activeNotification.channelId}\n'
                      'groupKey: ${activeNotification.groupKey}\n'
                      'tag: ${activeNotification.tag}\n'
                      'title: ${activeNotification.title}\n'
                      'body: ${activeNotification.body}',
                ),
                TextButton(
                  child: const Text('Get messaging style'),
                  onPressed: () {
                    getActiveNotificationMessagingStyle(
                        activeNotification.id!, activeNotification.tag , context);
                  },
                ),
                const Divider(color: Colors.black),
              ],
            ),
      ],
    );
  } on PlatformException catch (error) {
    return Text(
      'Error calling "getActiveNotifications"\n'
          'code: ${error.code}\n'
          'message: ${error.message}',
    );
  }
}

Future<void> getActiveNotificationMessagingStyle(int id, String? tag ,BuildContext context) async {
  Widget dialogContent;
  try {
    final MessagingStyleInformation? messagingStyle =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .getActiveNotificationMessagingStyle(id, tag: tag);
    if (messagingStyle == null) {
      dialogContent = const Text('No messaging style');
    } else {
      dialogContent = SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('person: ${formatPerson(messagingStyle.person)}\n'
                  'conversationTitle: ${messagingStyle.conversationTitle}\n'
                  'groupConversation: ${messagingStyle.groupConversation}'),
              const Divider(color: Colors.black),
              if (messagingStyle.messages == null) const Text('No messages'),
              if (messagingStyle.messages != null)
                for (final Message msg in messagingStyle.messages!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('text: ${msg.text}\n'
                          'timestamp: ${msg.timestamp}\n'
                          'person: ${formatPerson(msg.person)}'),
                      const Divider(color: Colors.black),
                    ],
                  ),
            ],
          ));
    }
  } on PlatformException catch (error) {
    dialogContent = Text(
      'Error calling "getActiveNotificationMessagingStyle"\n'
          'code: ${error.code}\n'
          'message: ${error.message}',
    );
  }

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Messaging style'),
      content: dialogContent,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

String formatPerson(Person? person) {
  if (person == null) {
    return 'null';
  }

  final List<String> attrs = <String>[];
  if (person.name != null) {
    attrs.add('name: "${person.name}"');
  }
  if (person.uri != null) {
    attrs.add('uri: "${person.uri}"');
  }
  if (person.key != null) {
    attrs.add('key: "${person.key}"');
  }
  if (person.important) {
    attrs.add('important: true');
  }
  if (person.bot) {
    attrs.add('bot: true');
  }
  if (person.icon != null) {
    attrs.add('icon: ${formatAndroidIcon(person.icon)}');
  }
  return 'Person(${attrs.join(', ')})';
}

String formatAndroidIcon(Object? icon) {
  if (icon == null) {
    return 'null';
  }
  if (icon is DrawableResourceAndroidIcon) {
    return 'DrawableResourceAndroidIcon("${icon.data}")';
  } else if (icon is ContentUriAndroidIcon) {
    return 'ContentUriAndroidIcon("${icon.data}")';
  } else {
    return 'AndroidIcon()';
  }
}

Future<void> getNotificationChannels(BuildContext context) async {
  final Widget notificationChannelsDialogContent =
  await getNotificationChannelsDialogContent();
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: notificationChannelsDialogContent,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<Widget> getNotificationChannelsDialogContent() async {
  try {
    final List<AndroidNotificationChannel>? channels =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .getNotificationChannels();

    return SizedBox(
      width: double.maxFinite,
      child: ListView(
        children: <Widget>[
          const Text(
            'Notifications Channels',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.black),
          if (channels?.isEmpty ?? true)
            const Text('No notification channels')
          else
            for (AndroidNotificationChannel channel in channels!)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('id: ${channel.id}\n'
                      'name: ${channel.name}\n'
                      'description: ${channel.description}\n'
                      'groupId: ${channel.groupId}\n'
                      'importance: ${channel.importance.value}\n'
                      'playSound: ${channel.playSound}\n'
                      'sound: ${channel.sound?.sound}\n'
                      'enableVibration: ${channel.enableVibration}\n'
                      'vibrationPattern: ${channel.vibrationPattern}\n'
                      'showBadge: ${channel.showBadge}\n'
                      'enableLights: ${channel.enableLights}\n'
                      'ledColor: ${channel.ledColor}\n'),
                  const Divider(color: Colors.black),
                ],
              ),
        ],
      ),
    );
  } on PlatformException catch (error) {
    return Text(
      'Error calling "getNotificationChannels"\n'
          'code: ${error.code}\n'
          'message: ${error.message}',
    );
  }
}

Future<void> showNotificationWithNumber() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'الإشعارات',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      number: 1);
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showNotificationWithAudioAttributeAlarm() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your alarm channel id',
    'your alarm channel name',
    channelDescription: 'your alarm channel description',
    importance: Importance.max,
    priority: Priority.high,
    audioAttributesUsage: AudioAttributesUsage.alarm,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'notification sound controlled by alarm volume',
    'alarm notification sound body',
    platformChannelSpecifics,
  );
}


