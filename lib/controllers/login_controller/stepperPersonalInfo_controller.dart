import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/models/stepperPersonalModel.dart';


class StepperPersonal extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  TextEditingController nameTf = TextEditingController();
  TextEditingController dobTf = TextEditingController();
  TextEditingController emailTf = TextEditingController();
  TextEditingController numberTf = TextEditingController();
  TextEditingController altnumberTf = TextEditingController();
  TextEditingController peradTf = TextEditingController();
  TextEditingController tempadTf = TextEditingController();
  TextEditingController experienceTf = TextEditingController();
  TextEditingController businessNameTf = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currentStep = 0;
  String name;
  String email;
  String number;
  String altnumber;
  String tca;
  File profilepic;
  bool accept = false;
  String imageLink3 = "";
  // DateTime now = DateTime.now();

  StepperPersonalModel stepperPersonalModel;

  StepperPersonal() {
    this.stepperPersonalModel = StepperPersonalModel();
  }
  step1() {
    if (accept == true) {
      currentStep += 1;

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'joinedat': DateTime.now(),
        'name': null,
        'email': null,
        'profilepic': null,
        // 'phone': '+91$value',
        'altNum': null,
        'terms&Conditions': tca,
        'reference': 0,
        'uid': FirebaseAuth.instance.currentUser.uid
      });
    } else {
      Timer(
          Duration(milliseconds: 100),
          () => scrollController
              .jumpTo(scrollController.position.maxScrollExtent));
      final snackBar = SnackBar(
        content: Text('Need to accept all the terms & conditions'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  step2() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      currentStep += 1;
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'name': this.name,
        'altNum': this.altnumber,
        'Num': this.number,
        'email': this.email,
        'uid': FirebaseAuth.instance.currentUser.uid,
        'reference': 0,
        'profilepic': null
      }).catchError((e) {
        print(e);
      });
    } else {
      final snackBar = SnackBar(
        content: Text('Fill all the fields'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  step3() async {
    await uploadimage();
    currentStep += 1;
  }

  //image pick
  Future<void> profilePic() async {
    var front = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 40,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      profilepic = File(front.path);
    });
  }

//image upload function
  Future<void> uploadimage() async {
    var postImageRef = FirebaseStorage.instance.ref().child('legalDoc');
    UploadTask uploadTask = postImageRef
        .child(DateTime.now().toString() + ".jpg")
        .putFile(profilepic);
    print(uploadTask);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    imageLink3 = imageUrl.toString();
    print(imageUrl);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'profilepic': imageLink3});
  }
}
