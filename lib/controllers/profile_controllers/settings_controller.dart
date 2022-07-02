import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SettingsController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  String? updatedEmail;
  String? updatedob;
  String? updatedNum;
  String? updatedtempad;
  File? profilepic;
  String imageLink1 = "";
  var updatePath = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid);

  Future<void> profilePic() async {
    var profile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      if (profile != null) {
        profilepic = File(profile.path);
      }
    });
  }

//image upload function
  // Future<void> uploadprofile() async {
  //   if (profilepic != null) {
  //     var postImageRef = FirebaseStorage.instance.ref().child('legalDoc');
  //     UploadTask uploadTask = postImageRef
  //         .child(DateTime.now().toString() + ".jpg")
  //         .putFile(profilepic!);
  //     print(uploadTask);
  //     var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //     imageLink1 = imageUrl.toString();
  //     print(imageUrl);
  //     FirebaseFirestore.instance
  //         .collection('partner')
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .update({'profilepic': imageLink1});
  //   }
  // }
}
