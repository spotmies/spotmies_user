import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List icons = [
    Icons.pending_actions,
    Icons.run_circle_rounded,
    Icons.done_all
  ];

  var postStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('adpost')
      .snapshots();
}
