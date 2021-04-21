import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/models/admodel.dart';

class AdController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  String service;
  String title;
  String time;
  String upload;
  String discription;
  String money;
  String state;
  String adtime;
  // File _profilepic;
  List<File> profilepic = [];
  bool uploading = false;
  double val = 0;

  List imageLink = [];
  //date time picker
  DateTime pickedDate;
  TimeOfDay pickedTime;

  DateTime now = DateTime.now();

  // drop down menu for service type
  int dropDownValue = 0;
  //dummy data for accept/reject requests condition
  String dummy = 'nothing';
  //user id
  var uid = FirebaseAuth.instance.currentUser.uid;
  //location
  String location = 'seethammadhara,visakhapatnam';

  // location and place access

  var latitude = "";
  var longitude = "";
  String add1 = "";
  String add2 = "";
  String add3 = "";
  var docc;

  AdModel adModel;

  AdController() {
    this.adModel = AdModel();
  }

  Future<void> docid() async {
    docc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('adpost')
        .doc();
  }

  //function for location
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);

    String lat = '${position.latitude}';
    String long = '${position.longitude}';

    print('$lat,$long');

    setState(() {
      latitude = '${position.latitude}';
      longitude = '${position.longitude}';
    });
  }

  @override
  void initState() {
    super.initState();
    getAddressofLocation();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  getAddressofLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      add1 = addresses.first.featureName;
      add2 = addresses.first.addressLine;
      add3 = addresses.first.locality;
    });
  }

  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
            DateTime.now().day - 0),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() async {
        TimeOfDay t = await showTimePicker(
          context: context,
          initialTime: pickedTime,
        );
        if (t != null) {
          setState(() {
            pickedTime = t;
          });
        }
        pickedDate = date;
      });
    }
  }

  // image pick

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
          .then((value) => imageLink.add(value.toString()));
      i++;
    }
  }

  adbutton() async {
    docid();
    await uploadimage();
    var orderid = await docc.id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('adpost')
        .doc(orderid)
        .set({
      'job': this.dropDownValue,
      'problem': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate':
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
      'scheduletime': '${pickedTime.hour}:${pickedTime.minute}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'add1': add3,
      },
      'orderstate': 0,
    });

    await FirebaseFirestore.instance.collection('allads').doc(orderid).set({
      'job': this.dropDownValue,
      'problem': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate':
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
      'scheduletime': '${pickedTime.hour}:${pickedTime.minute}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'add1': add3,
      },
      'orderstate': 0,
    });
    Navigator.pop(context);
  }

  buttonFromHome() async {
    docid();
    await uploadimage();
    var orderid = await docc.id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('adpost')
        .doc(orderid)
        .set({
      'job': this.dropDownValue,
      'problem': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate':
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
      'scheduletime': '${pickedTime.hour}:${pickedTime.minute}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'add1': add3,
      },
      'orderstate': 0,
    });

    await FirebaseFirestore.instance.collection('allads').doc(orderid).set({
      'job': this.dropDownValue,
      'problem': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate':
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
      'scheduletime': '${pickedTime.hour}:${pickedTime.minute}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        'add1': add3,
      },
      'orderstate': 0,
    });
    Navigator.pop(context);
  }

  Future<bool> dialogTrrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Acknowledgement'),
            content: Text('Post Succussfully Published'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                   
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}
