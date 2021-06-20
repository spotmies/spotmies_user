import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PostsController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'Development',
    'Tutor',
    'Beauty',
    'Photography',
    'Drivers',
    'Events'
  ];
  List state = ['Waiting for confirmation', 'Ongoing', 'Completed'];

  orderStateText(String orderState) {
    switch (orderState) {
      case 'req':
        return 'Waiting for conformation';
        break;
      case 'noPartner':
        return 'No technicians found';
        break;
      case 'updated':
        return 'updated';
        break;
      case 'onGoing':
        return 'On Going';
        break;
      case 'completed':
        return 'Completed';
        break;
      case 'cancel':
        return 'Cancelled';
        break;
      default:
        return 'Booking done';
    }
  }

  orderStateIcon(String orderState) {
    switch (orderState) {
      case 'req':
        return Icons.pending_actions;
        break;
      case 'noPartner':
        return Icons.stop_circle;
        break;
      case 'updated':
        return Icons.update;
        break;
      case 'onGoing':
        return Icons.run_circle_rounded;
        break;
      case 'completed':
        return Icons.done_all;
        break;
      case 'cancel':
        return Icons.cancel;
        break;
      default:
        return Icons.search;
    }
  }

  getAddressofLocation(addresses) async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final coordinates = Coordinates(position.latitude, position.longitude);

    return Text(addresses.first.locality.toString());
  }

  var postStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('adpost')
      .snapshots();
}
