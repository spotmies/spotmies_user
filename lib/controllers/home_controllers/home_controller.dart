// import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../utilities/snackbar.dart';

class HomeController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
// FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // location and place access
  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'Development',
    'Tutor',
    'Beauty',
    'Photography',
    'Drivers',
    'Events',
    'Electrician',
    'Carpentor',
    'Plumber',
  ];
  List icons = [
    Icons.miscellaneous_services,
    Icons.laptop_mac,
    Icons.tv,
    Icons.developer_mode,
    Icons.person_search,
    Icons.face,
    Icons.camera_enhance,
    Icons.car_rental,
    Icons.event,
    Icons.electrical_services,
    Icons.carpenter,
    Icons.plumbing_sharp,
  ];
  var latitude = "";
  var longitude = "";
  String? add1 = "";
  String? add2;
  String? add3 = "";

  //function for location
  // void getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   var lastPosition = await Geolocator.getLastKnownPosition();
  //   print(lastPosition);

  //   String lat = '${position.latitude}';
  //   String long = '${position.longitude}';

  //   print('$lat,$long');

  //   setState(() {
  //     latitude = '${position.latitude}';
  //     longitude = '${position.longitude}';
  //   });
  //}

  @override
  void initState() {
    super.initState();
    //notifications();
    //address
    // getAddressofLocation();
    //for notifications
    var androidInitialize = AndroidInitializationSettings('asdf');
    var initializesettings = InitializationSettings(android: androidInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializesettings);
    // up = Provider.of<UniversalProvider>(context, listen: false);
  }

//get token
  // void getToken() async {
  //   print(await firebaseMessaging.getToken());
  // }

//address
  getAddressofLocation(BuildContext context) async {
    log("get address");
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      await Geolocator.checkPermission();
    } else {
      await Geolocator.requestPermission();
    }

    if (await Geolocator.isLocationServiceEnabled() == false) {
      snackbar(context, "Please turn on location");
      return "";
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks[0].toString());

    setState(() {
      add1 = placemarks.first.street;
      add2 = placemarks.first.subLocality;
      add3 = placemarks.first.subAdministrativeArea;
    });
    return placemarks.first.subLocality.toString();
  }

  FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();
}
