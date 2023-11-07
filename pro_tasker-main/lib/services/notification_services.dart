import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:pro_tasker/models/task.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper{


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //initialize notification
  initializeNotification() async {
    _configureLocalTimezone();
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse :
          (NotificationResponse notificationResponse){
        switch (notificationResponse.notificationResponseType){
          case NotificationResponseType.selectedNotification:
            selectNotification(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if(notificationResponse.actionId == "id_3"){
              selectNotification(notificationResponse.payload);
            }
            break;
        }
      },

    );
  }
  //scheduledNotification
  Future scheduledNotification( int hour , int minutes ,Task task ) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hour,minutes),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        await    const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
              'your channel name',
              channelDescription: 'd',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
            )),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        payload: "{$task.title}"+"{$task.note}"
    );
  }

  //convert Time
  tz.TZDateTime _convertTime(int hour ,int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minutes);

    if(scheduledDate.isBefore(now)){
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  //local time zone
  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }


  void selectNotification(String? payload) {
    if(payload != null){
      print("Notification payload: $payload");
    }
    else{
      print("Notification Done");
    }
    Get.to(()=>Container(color: Colors.white,));
  }


//display notification
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id',
        'your channel name',playSound: true,
        // 'your channel description',
        importance: Importance.max , priority: Priority.high,icon:'appicon'

    );
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',

    );
  }
}
