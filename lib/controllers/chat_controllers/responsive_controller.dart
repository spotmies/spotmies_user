import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ResponsiveController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var partnerid;
  var pid;
  String value;

  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'development',
    'tutor',
    'beauty',
    'photography',
    'drivers',
    'events',
    'Electrician',
    'Carpentor',
    'Plumber',
  ];


//rating average function

  avg(List<dynamic> args) {
    var sum = 0;
    var avg = args;

    for (var i = 0; i < avg.length; i++) {
      sum += avg[i];
    }

    return sum;
  }

  @override
  void initState() {
    super.initState();
    //address

    //for notifications
    var androidInitialize = AndroidInitializationSettings('asdf');
    var initializesettings = InitializationSettings(android: androidInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializesettings);
  }

  FlutterLocalNotificationsPlugin localNotifications;

  Future shownotification() async {
    var androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.high);
    var generalNotificationetails =
        NotificationDetails(android: androidDetails);
    await localNotifications.show(0, 'orderState', 'something behind the info',
        generalNotificationetails);
  }
}
