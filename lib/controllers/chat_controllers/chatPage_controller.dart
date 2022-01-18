import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatPageController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  uread(String msgid) {
    return FirebaseFirestore.instance
        .collection('messaging')
        .doc(msgid)
        .update({'uread': 1, 'umsgcount': 0});
  }

  var chatPageStream = FirebaseFirestore.instance
      .collection('messaging')
      .where('userid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .where("chatbuild", isEqualTo: true)
      .snapshots();
}
