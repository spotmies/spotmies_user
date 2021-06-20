import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
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
  String imageLink = "";
  // DateTime now = DateTime.now();

  StepperPersonalModel stepperPersonalModel;

  StepperPersonal() {
    this.stepperPersonalModel = StepperPersonalModel();
  }
  step1() {
    if (accept == true) {
      currentStep += 1;
    } else {
      Timer(
          Duration(milliseconds: 100),
          () => scrollController
              .jumpTo(scrollController.position.maxScrollExtent));
      final snackBar = SnackBar(
        content: Text('Need to accept all the terms & conditions'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  step2() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      currentStep += 1;
      print(FirebaseAuth.instance.currentUser.uid);
    } else {
      final snackBar = SnackBar(
        content: Text('Fill all the fields'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  step3() async {
    await uploadimage();
    var body = {
      "name": this.name.toString(),
      "phNum": this.number.toString(),
      "join": DateTime.now().millisecondsSinceEpoch.toString(),
      "uId": FirebaseAuth.instance.currentUser.uid.toString(),
      "userState": "active",
      "altNum": this.altnumber.toString(),
      "eMail": this.email.toString(),
      "t&a": accept.toString(),
      "pic":imageLink.toString(),
      // "name": this.name.toString(),
      // "phNum": this.number.toString(),
      // "join": DateTime.now().toString(),
      // "uId": FirebaseAuth.instance.currentUser.uid.toString(),
      // "userState": "active",
      // "altNum": this.altnumber.toString(),
      // "eMail": this.email.toString(),
      // // "reference": 0.toString(),
      // "pic": imageLink.toString(),
      // "t&a": accept.toString()
    };
    await Server().postMethod(API.userRegister, body).catchError((e) {
      print(e);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Fill all the fields'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    ));
    currentStep += 1;
  }

  //image pick
  Future<void> profilePic() async {
    var front = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 20,
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
    imageLink = imageUrl.toString();
  }
}
