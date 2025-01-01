import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService{
  static final NotificationService _instance =NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void>initizlize()async{
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true
    );
     const InitializationSettings initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid,
       iOS: initializationSettingsIos
     );
     
     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
     onDidReceiveNotificationResponse:  _onNotificationTap
     );


  }

 void  _onNotificationTap(NotificationResponse respone){
    print("notification chacked : ${respone.payload}");
  }

 void showInstanceNoti()async{
    print('Noti is stared');
    const AndroidNotificationDetails androidNotificationDetails =
         AndroidNotificationDetails("instance_channel","instance Notification",channelDescription: "channell for instance Notificatio ",
         importance: Importance.max,priority:Priority.high,ticker: 'ticker');

      const NotificationDetails platformSpecificNoti = NotificationDetails(android:androidNotificationDetails );
      
      await flutterLocalNotificationsPlugin.show(0, "instance Noti",  "Decription fo Noti Details", platformSpecificNoti,
      payload: "instance");
    print('Noti is ended');
  }

  Future<void>sculduleNotification(DateTime scDatetime)async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("Instance_Channel", "instance Notification",channelDescription: "channell for instance Notificatio ",
        importance: Importance.max,priority:Priority.high);

    const NotificationDetails platformSpecificNotif = NotificationDetails(android:androidNotificationDetails );

   await flutterLocalNotificationsPlugin.zonedSchedule(1, "Title Notification",  "Decription of Notificaiton Details",tz.TZDateTime.from(scDatetime, tz.local),
        platformSpecificNotif,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        
        payload: "Schedule ", androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }



}