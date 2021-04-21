import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatPageController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var chatPageStream = FirebaseFirestore.instance
      .collection('messaging')
      .where('userid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      //.orderBy('createdAt', descending: true)
      .snapshots();
}
