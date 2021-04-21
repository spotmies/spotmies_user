import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var responsonseStrem = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('response')
      .where('orderstate', isEqualTo: 0)
      .snapshots();


  void getDatails() async {
    QuerySnapshot getOrderDetails;

    getOrderDetails = await FirebaseFirestore.instance
        .collection('partner')
        .doc()
        .collection('profileInfo')
        .get();

    partnerid = getOrderDetails.docs[0]['userid'];
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
