import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChatScreenController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  String textInput;

  //images
  List<File> profilepic = [];
  bool uploading = false;
  double val = 0;

  List imageLink = [];

  chooseImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      profilepic.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        profilepic.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  //image upload function
  Future<void> uploadimage() async {
    int i = 1;

    for (var img in profilepic) {
      setState(() {
        val = i / profilepic.length;
      });
      var postImageRef = FirebaseStorage.instance.ref().child('adImages');
      UploadTask uploadTask =
          postImageRef.child(DateTime.now().toString() + ".jpg").putFile(img);
      await (await uploadTask)
          .ref
          .getDownloadURL()
          .then((value) => imageLink.add(value + 'ui'.toString()));
      i++;
    }
  }
}
