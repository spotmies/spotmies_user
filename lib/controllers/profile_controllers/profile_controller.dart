import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/views/login/loginpage.dart';

class ProfileController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  var profileSteam = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots();

  signout() async {
    await FirebaseAuth.instance.signOut().then((action) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPageScreen()));
    }).catchError((e) {
      print(e);
    });
  }
}
