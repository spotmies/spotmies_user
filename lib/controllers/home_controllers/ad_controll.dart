import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';
import 'package:spotmies/models/admodel.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/utilities/addressExtractor.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
import 'package:spotmies/views/reusable_widgets/pageSlider.dart';
import 'package:video_player/video_player.dart';

class AdController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  TextEditingController problem = TextEditingController();
  final controller = TestController();
  GetOrdersProvider ordersProvider;
  String uuId = FirebaseAuth.instance.currentUser.uid.toString();
  // int currentStep = 0;
  GlobalKey<PageSliderState> sliderKey = GlobalKey();

  // String service;
  String title;
  String time;
  // String upload;
  // String discription;
  String money;
  // String state;
  // String adtime;
  // File _profilepic;
  List<File> serviceImages = [];
  List<String> serviceImagesStrings = [];
  bool uploading = false;
  double val = 0;

  List imageLink = [];

  //date time picker
  DateTime pickedDate;
  TimeOfDay pickedTime;

  DateTime now = DateTime.now();

  // drop down menu for service type
  int dropDownValue;
  //dummy data for accept/reject requests condition
  String dummy = 'nothing';
  //user id
  var uid = FirebaseAuth.instance.currentUser.uid;
  //location
  String location = 'seethammadhara,visakhapatnam';

  // location and place access

  var latitude = "";
  var longitude = "";
  Map fullAddress = {};
  var docc;
  var wid = 1;
  int isUploading = 0; //0 for nothing 1- pending 2- failure 3-success
  List jobs = [
    'Select',
    "Ac/Refrigirator Service",
    "Computer/Laptop Service",
    "Tv Repair",
    "Development",
    "Tutor",
    "Beauty",
    "Photographer",
    "Driver",
    "Events",
    "Electrician",
    "Carpenter",
    "Plumber",
    "Interior Design",
    "Design",
    "CC Tv Installation",
    "Catering",
  ];

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

  // Future servicePost() async {
  //   try {
  //     var response = await http.post(
  //         Uri.https('spotmiesserver.herokuapp.com', 'api/order/Create-Ord'),
  //         body: {
  //           "problem": this.title,
  //           "job": this.dropDownValue.toString(),
  //           "ordId": DateTime.now().millisecondsSinceEpoch.toString(),
  //           "ordState": 0.toString(),
  //           "join": DateTime.now().millisecondsSinceEpoch.toString(),
  //           "schedule": pickedDate.millisecondsSinceEpoch.toString(),
  //           "uId": FirebaseAuth.instance.currentUser.uid,
  //           "money": this.money,
  //           "loc.0": latitude.toString(),
  //           "loc.1": longitude.toString(),
  //           "media": imageLink.toString(),
  //         });

  //     if (response.statusCode == 200) {
  //       String responseString = response?.body;
  //       print(responseString);
  //       return dataModelFromJson(responseString);
  //     } else
  //       return null;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);

    getAddressofLocation();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  getAddressofLocation({double lat, double long}) async {
    log('message');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = (lat == null && long == null)
        ? Coordinates(position.latitude, position.longitude)
        : Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    log("address ${addresses.first.subLocality}");
    setState(() {
      fullAddress = addressExtractor(addresses.first);
    });
  }

  pickDate(BuildContext context) async {
    DateTime date = await showDatePicker(
        confirmText: 'SET DATE',
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
            DateTime.now().day - 0),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        pickedDate = date;
        print(pickedDate.millisecondsSinceEpoch);
      });
    }
  }

  picktime(BuildContext context) async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );
    if (t != null) {
      setState(() {
        pickedTime = t;
      });
    }
  }

  // image pick

  chooseImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear);
    setState(() {
      serviceImages.add(File(pickedFile?.path));
      serviceImagesStrings.add(pickedFile?.path);
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  File serviceVideo;
  final picker = ImagePicker();
  VideoPlayerController videoPlayerController;

  pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));
    serviceVideo = File(pickedFile.path);

    videoPlayerController = VideoPlayerController.file(serviceVideo)
      ..initialize().then((_) {
        setState(() {
          serviceImages.add(serviceVideo);
          serviceImagesStrings.add(pickedFile.path);
        });
        videoPlayerController.play();
      });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        serviceImages.add(File(response.file.path));
        serviceImagesStrings.add(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

//image upload function
  Future<void> uploadServiceMedia() async {
    extensionType(int indexx) {
      switch (checkFileType(serviceImages[indexx].toString())) {
        case "image":
          return ".jpg";
        case "audio":
          return ".aac";
        case "video":
          return ".mp4";

          break;
        default:
          return ".jpg";
          break;
      }
    }

    for (int i = 0; i < serviceImages.length; i++) {
      String downloadLink = await uploadFilesToCloud(serviceImages[i],
          cloudLocation: "orderMediaFiles", fileType: extensionType(i));
      imageLink.add(downloadLink);
    }

    // int i = 1;

    // for (var img in serviceImages) {
    //   setState(() {
    //     val = i / serviceImages.length;
    //   });
    //   var postImageRef = FirebaseStorage.instance.ref().child('adImages');
    //   UploadTask uploadTask =
    //       postImageRef.child(DateTime.now().toString() + ".jpg").putFile(img);
    //   await (await uploadTask)
    //       .ref
    //       .getDownloadURL()
    //       .then((value) => imageLink.add(value.toString()));
    //   i++;
    // }
  }

  // step2() {
  //   setState(() {
  //     if (longitude != '' || pickedTime != null) {
  //       wid = wid + 1;
  //     }
  //   });
  // }

  step1() {
    if (dropDownValue == null || dropDownValue < 0) {
      snackbar(context, 'Please select service type');
      return;
    }
    setState(() {
      if (formkey.currentState.validate()) {
        formkey.currentState.save();

        sliderKey.currentState.next();
      }
    });
  }

  step3(userDetails) {
    isUploading = 1;
    refresh();
    adbutton(userDetails);
  }

  updateLocations(lat, log, fulladdress) {
    latitude = lat.toString();
    longitude = log.toString();
    fullAddress = fulladdress;
    setState(() {});
  }

  getDateAndTime() {
    DateTime pickedDateTime = new DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickedTime.hour, pickedTime.minute);

    return pickedDateTime.millisecondsSinceEpoch.toString();
  }

  adbutton(userDetails) async {
    await uploadServiceMedia();
    // String images = imageLink.toString();
    CircularProgressIndicator();
    // log(userDetails.toString());
    // var ud = userDetails["_id"].toString();
    Map<String, dynamic> body = {
      "problem": this.title.toString(),
      "job": (this.dropDownValue).toString(),
      "ordId": DateTime.now().millisecondsSinceEpoch.toString(),
      "ordState": "req",
      "join": DateTime.now().millisecondsSinceEpoch.toString(),
      // "schedule": pickedDate.millisecondsSinceEpoch.toString(),
      "schedule": getDateAndTime(),
      "uId": FirebaseAuth.instance.currentUser.uid.toString(),
      if (this.money != null) "money": this.money.toString(),
      "loc.coordinates.0": latitude.toString(),
      "loc.coordinates.1": longitude.toString(),
      "uDetails": userDetails["_id"].toString(),
      "address":
          fullAddress.isNotEmpty ? jsonEncode(fullAddress).toString() : ""
    };
    for (int i = 0; i < imageLink.length; i++) {
      body["media.$i"] = imageLink[i];
    }
    log(body.toString());

    // controller.postData();
    Server().postMethod(API.createOrder + uuId, body).then((response) {
      if (response.statusCode == 200) {
        isUploading = 3;
        refresh();
        snackbar(context, 'Published');
        ordersProvider.addNewOrder(jsonDecode(response.body));
        return;
      }
      log(response?.body.toString());
      if (response.statusCode == 400) {
        isUploading = 2;
        refresh();
        snackbar(context, 'Bad Request');
      }
      if (response.statusCode == 404) {
        isUploading = 2;
        refresh();
        snackbar(context, 'Bad Request');
      }
    });
  }

  buttonFromHome() async {
    docid();
    await uploadServiceMedia();
    var orderid = await docc.id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('adpost')
        .doc(orderid)
        .set({
      'problem': this.dropDownValue,
      'job': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate': DateFormat('dd MMM yyyy').format(
          (DateTime.fromMillisecondsSinceEpoch(
              (pickedDate.millisecondsSinceEpoch)))),
      'scheduletime': '${pickedTime.format(context)}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        // 'add1': add3,
      },
      'orderstate': 0,
    });

    await FirebaseFirestore.instance.collection('allads').doc(orderid).set({
      'job': this.dropDownValue,
      'problem': this.title,
      'money': this.money,
      'posttime': this.now,
      'scheduledate': DateFormat('dd MMM yyyy').format(
          (DateTime.fromMillisecondsSinceEpoch(
              (pickedDate.millisecondsSinceEpoch)))),
      'scheduletime': '${pickedTime.format(context)}',
      'userid': uid,
      'request': dummy,
      'orderid': orderid,
      'media': FieldValue.arrayUnion(imageLink),
      'location': {
        'latitude': latitude,
        'longitude': longitude,
        // 'add1': add3,
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
