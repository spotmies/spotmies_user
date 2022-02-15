import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatScreenController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  String? textInput = "";

  //images
  List<File>? profilepic = [];
  bool uploading = false;
  double val = 0;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final snackbar = SnackBar(
    content: Text('Please type text...'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        print(UniqueKey());
        // Some code to undo the change.
      },
    ),
  );

  // final scroll = Timer(Duration(milliseconds: 300),
  //     () => scrollController.jumpTo(scrollController.position.maxScrollExtent));

  List imageLink = [];

  uread(String doc) {
    return FirebaseFirestore.instance
        .collection('messaging')
        .doc(doc)
        .update({'uread': 0});
  }

  chooseImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        profilepic?.add(File(pickedFile.path));
      }
    });
    if (pickedFile?.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        profilepic?.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  //image upload function
  // Future<void> uploadimage(msgId) async {
  //   int i = 1;

  //   for (var img in profilepic!) {
  //     setState(() {
  //       val = i / profilepic!.length;
  //     });
  //     var postImageRef = FirebaseStorage.instance.ref().child('adImages');
  //     UploadTask uploadTask =
  //         postImageRef.child(DateTime.now().toString() + ".jpg").putFile(img);
  //     await (await uploadTask)
  //         .ref
  //         .getDownloadURL()
  //         .then((value) => imageLink.add(value + 'ui'.toString()));
  //     i++;
  //   }
  // }

  date(msg1, msg2) {
    var temp1 = jsonDecode(msg1);
    var temp2 = jsonDecode(msg2);
    var ct = DateFormat('dd').format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(temp1['timestamp'])));
    var pt = DateFormat('dd').format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(temp2['timestamp'])));
    var daynow = DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(
        int.parse(DateTime.now().millisecondsSinceEpoch.toString())));
    var daypast = DateFormat('EEE').format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(temp1['timestamp'])));
    if (ct != pt) {
      return (daypast == daynow
          ? 'Today'
          : (DateFormat('dd MMM yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(
                  int.parse(temp1['timestamp'])))));
    } else {
      return "";
    }
  }

  confirmOrder(String id, String pid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('adpost')
        .doc(id)
        .update({'orderstate': 2});
    FirebaseFirestore.instance
        .collection('allads')
        .doc(id)
        .update({'orderstate': 2});
    FirebaseFirestore.instance
        .collection('messaging')
        .doc(pid + id)
        .update({'orderstate': 2});

    FirebaseFirestore.instance
        .collection('partner')
        .doc(id)
        .collection('orders')
        .doc(id)
        .update({'orderstate': 2});
  }
}
