import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmies/views/home/navBar.dart';



//permisiion

notificationPermmision(context) {
  return AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => AwesomeNotifications()
                    .requestPermissionToSendNotifications()
                    .then((_) => Navigator.pop(context)),
                child: Text(
                  'Allow',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    },
  );
}

// class CustomNotifications {
void awesomeInitilize() async {
  await AwesomeNotifications().initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
            channelKey: 'firebasePushNotifictions',
            channelName: 'firebase Push Notifictions',
            channelDescription: 'test message',
            playSound: true,
            enableLights: true,
            enableVibration: true,
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            defaultRingtoneType: DefaultRingtoneType.Ringtone,
            channelShowBadge: true,
            ledColor: Colors.white),
        NotificationChannel(
            channelKey: 'firebasePushNotifiction',
            channelName: 'firebase Push Notifiction',
            playSound: true,
            enableLights: true,
            enableVibration: true,
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            defaultRingtoneType: DefaultRingtoneType.Ringtone,
            ledColor: Colors.white),
      ],
      debug: true);
}

//notifications

displayAwesomeNotification(RemoteMessage message, BuildContext context) async {
  final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  // final String timeZone =
  //     await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'firebasePushNotifiction',
          title: message.notification.title,
          body: message.notification.body,
          notificationLayout: NotificationLayout.BigPicture,
          displayOnBackground: true,
          displayOnForeground: true,
          icon: 'resource://drawable/logo',
          locked: false,
          displayedDate: DateTime.now().toString(),
          bigPicture:
              'https://assets-global.website-files.com/5b6df8bb681f89c158b48f6b/5d7b6a6e00f64f8f69b8bf36_it-services-technician.jpg'),

      // schedule: NotificationInterval(
      //     interval: 2, timeZone: timeZone, repeats: false),
      actionButtons: [
        NotificationActionButton(
          key: 'accept',
          label: 'Accept',
          enabled: true,
          buttonType: ActionButtonType.Default,
        ),
        NotificationActionButton(
          key: 'cancel',
          label: 'Cancel',
          enabled: true,
          buttonType: ActionButtonType.Default,
        ),
      ]);

  AwesomeNotifications().actionStream.listen((receivedNotifiction) {
    log('step one');
    if (receivedNotifiction.buttonKeyPressed == 'cancel') {
      log('cancel');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => GoogleNavBar(),
          ),
          (route) => route.isFirst);
    }
    if (receivedNotifiction.buttonKeyPressed == 'accept') {
      log('Accept');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => GoogleNavBar(),
          ),
          (route) => route.isFirst);
    }
  });
}

//background

displayAwesomeNotificationBackground(
  RemoteMessage message,
) async {
  final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  // final String timeZone =
  //     await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'firebasePushNotifictions',
          title: message.notification.title,
          body: message.notification.body,
          notificationLayout: NotificationLayout.BigPicture,
          displayOnBackground: true,
          displayOnForeground: true,
          icon: 'resource://drawable/logo',
          locked: false,
          displayedDate: DateTime.now().toString(),
          bigPicture:
              'https://assets-global.website-files.com/5b6df8bb681f89c158b48f6b/5d7b6a6e00f64f8f69b8bf36_it-services-technician.jpg'),

      // schedule: NotificationInterval(
      //     interval: 2, timeZone: timeZone, repeats: false),
      actionButtons: [
        NotificationActionButton(
          key: 'accept',
          label: 'Accept',
          enabled: true,
          buttonType: ActionButtonType.Default,
        ),
        NotificationActionButton(
          key: 'cancel',
          label: 'Cancel',
          enabled: true,
          buttonType: ActionButtonType.Default,
        ),
      ]);

  AwesomeNotifications().actionStream.listen((receivedNotifiction) {
    log('step one');
    if (receivedNotifiction.buttonKeyPressed == 'cancel') {
      log('cancel');
    }
    if (receivedNotifiction.buttonKeyPressed == 'accept') {
      log('Accept');
    }
  });
}

