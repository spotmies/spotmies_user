import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/models/stepperPersonalModel.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
import 'package:spotmies/views/home/navBar.dart';

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
  String? name;
  String? email;
  String? number;
  String? altnumber;
  String? tca;
  File? profilepic;
  bool? accept = false;
  String? imageLink;
  List termsAndConditions = [];
  List offlineTermsAndConditions = [
    "Offline Spotmies partner not supposed to Save customer details,as well as not supposed to give contact information to customer",
    "Spotmies partners are not supposed to share customer details to others,it will be considered as an illegal activity",
    "We do not Entertain any illegal activities. If perform severe actions will be taken",
    "Partners are responsible for the damages done during the services and they bare whole forfeit",
    "We do not provide  any kind of training,equipment/material and  labor to perform any Service",
    "We do not provide any shipping charges,travelling fares",
    "Partner should take good care of their appearance ,language ,behaviour while they perform service",
    "Partner should follow all the COVID regulations",
  ];
  // DateTime now = DateTime.now();

  late StepperPersonalModel stepperPersonalModel;

  StepperPersonal() {
    this.stepperPersonalModel = StepperPersonalModel();
  }

  // late TimeProvider timerProvider;
  // @override
  // void initState() {
  //   timerProvider = Provider.of<TimeProvider>(context, listen: false);

  //   super.initState();
  // }

  step1(BuildContext context) {
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

  step2(BuildContext context) {
    if (formkey.currentState!.validate()) {
      formkey.currentState?.save();
      currentStep += 1;
      print(FirebaseAuth.instance.currentUser?.uid);
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

  step3(BuildContext context, TimeProvider? timerProvider) async {
    timerProvider?.setLoader(true, loadingValue: "Uploading profile pic...");
    log("${timerProvider?.phoneNumber}");
    dynamic picLink =
        await uploadFilesToCloud(profilepic, cloudLocation: 'userPics');
    dynamic deviceToken = await FirebaseMessaging.instance.getToken();
    timerProvider?.setLoader(true, loadingValue: "Registration Inprogress...");
    // log(timerProvider!.phoneNumber.toString());
    var body = {
      "name": this.name.toString(),
      "phNum": timerProvider?.phNumber.toString(),
      "join": DateTime.now().millisecondsSinceEpoch.toString(),
      "uId": FirebaseAuth.instance.currentUser?.uid.toString(),
      "userState": "active",
      "altNum": this.altnumber?.toString() ?? "",
      if (this.email != null) "eMail": this.email.toString(),
      "t&a": accept.toString(),
      "pic": picLink.toString(),
      "userDeviceToken": deviceToken?.toString() ?? "",
      "referalCode":
          "${name?.substring(0, 4)}${timerProvider?.phNumber.substring(6)}"
    };
    log("body $body");
    var resp =
        await Server().postMethod(API.userRegister, body).catchError((e) {
      print(e);
    });
    timerProvider?.setLoader(false);
    log("respss ${resp.statusCode}");
    log("response ${resp.body}");
    if (resp.statusCode == 200) {
      snackbar(context, "Registration successfull");
      await Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    } else {
      snackbar(context, "something went wrong");
    }

    return resp;
  }

  //image pick
  Future<void> profilePic() async {
    var front = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.rear,
    );
    // setState(() {
    if (front != null) {
      profilepic = File(front.path);
    }
    // });
  }

//image upload function
  // Future<void> uploadimage() async {
  //   if (profilepic == null) return;
  //   var postImageRef = FirebaseStorage.instance.ref().child('usersPics');
  //   UploadTask uploadTask = postImageRef
  //       .child(DateTime.now().toString() + ".jpg")
  //       .putFile(profilepic!);
  //   print(uploadTask);
  //   var imageUrl = await (await uploadTask).ref.getDownloadURL();
  //   imageLink = imageUrl.toString();
  // }
}
