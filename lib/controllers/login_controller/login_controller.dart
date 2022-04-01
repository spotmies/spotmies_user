import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/models/loginModel.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/home/navBar.dart';
import 'package:spotmies/views/login/otp.dart';
import 'package:spotmies/views/login/stepperPersonalInfo.dart';

class LoginPageController extends ControllerMVC {
  // late TimeProvider timerProvider;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var formkey1 = GlobalKey<FormState>();

  TextEditingController loginnum = TextEditingController();

  late LoginModel loginModel;

  LoginPageController() {
    this.loginModel = LoginModel();
  }
  String _verificationCode = "";
  // @override
  // void initState() {
  //   // timerProvider = Provider.of<TimeProvider>(context, listen: false);

  //   super.initState();
  // }

  dataToOTP(BuildContext context, TimeProvider timerProvider) {
    if (formkey.currentState != null) {
      if (formkey.currentState!.validate()) {
        formkey.currentState?.save();
        timerProvider.setPhNumber(loginnum.text.toString());

        verifyPhone(context, timerProvider);
      }
    }
  }

  verifyPhone(BuildContext context, TimeProvider timerProvider,
      {navigate = true}) async {
    timerProvider.resetTimer();
    timerProvider.setLoader(true, loadingValue: "Sending OTP .....");
    // log("phnum ${timerProvider.phNumber}");
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${timerProvider.phNumber}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                log("62");
                // print("user already login");
                // checkUserRegistered(value.user.uid);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => StepperPersonalInfo(
                //             //value: '+91${widget.phone}'
                //             )),
                //     (route) => false);
                timerProvider.setLoader(true);

                String resp = await checkUserRegistered(value.user?.uid);
                log("respp 73 $resp");
                timerProvider.setLoader(false);
                if (resp == "false") {
                  log("76");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StepperPersonalInfo()),
                      (route) => false);
                } else if (resp == "true") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => GoogleNavBar()),
                      (route) => false);
                } else {
                  snackbar(context, "Something went wrong");
                }
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            // log(e.message.toString());
            snackbar(context, e.message.toString());
            timerProvider.setLoader(false);
          },
          codeSent: (String verficationID, int? resendToken) {
            timerProvider.setLoader(false);
            timerProvider.setPhNumber(loginnum.text.toString());
            snackbar(context, "Otp send successfully ");

            _verificationCode = verficationID;
            timerProvider.setVerificationCode(verficationID);
            // log("verfication code $_verificationCode");

            if (navigate) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      OTPScreen(loginnum.text, verficationID)));
            }
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            _verificationCode = verificationID;
            timerProvider.setVerificationCode(verificationID);
            log("verfication code $_verificationCode");
          },
          timeout: Duration(seconds: 85));
    } catch (e) {
      // log(e.toString());
      snackbar(context, e.toString());
      timerProvider.setLoader(false);
    }
  }

  loginUserWithOtp(otpValue, BuildContext context, timerProvider) async {
    log("verfication code ${timerProvider.verificationCode}");
    log(otpValue.toString());
    timerProvider.setLoader(true);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: timerProvider.verificationCode,
              smsCode: otpValue))
          .then((value) async {
        // log(value.user.toString());
        if (value.user != null) {
          // log("${value.user}");
          // log("$value");
          timerProvider.setPhoneNumber(timerProvider.phNumber.toString());
          print("user already login");
          String resp = await checkUserRegistered(value.user?.uid);
          log("respp 124 $resp");
          timerProvider.setLoader(false);
          if (resp == "false") {
            log("128");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StepperPersonalInfo()),
                (route) => false);
          } else if (resp == "true") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GoogleNavBar()),
                (route) => false);
          } else {
            snackbar(context, "Something went wrong");
          }
        } else {
          timerProvider.setLoader(false);
          snackbar(context, "Something went wrong");
        }
      });
      // log("sekhar $sekhar");
    } catch (e) {
      FocusScope.of(context).unfocus();
      // log(e.toString());
      timerProvider.setLoader(false);
      snackbar(context, "something went wrong");
    }
  }
}

checkUserRegistered(uid) async {
  dynamic deviceToken = await FirebaseMessaging.instance.getToken();
  Map<String, String> obj = {
    "lastLogin": DateTime.now().millisecondsSinceEpoch.toString(),
    "userDeviceToken": deviceToken?.toString() ?? "",
    "uId": uid.toString(),
    "isActive": "true"
  };
  log("checkUserreg");
  dynamic response = await Server().postMethod(API.userDetails, obj);
  log("36 ${response.statusCode}");
  if (response.statusCode == 200 || response.statusCode == 204)
    return 'true';
  else if (response.statusCode == 404) return 'false';
  return 'server_error';
}

logoutUser(String? uId) async {
  Map<String, String?> body = {"uId": uId};
  await Server().postMethod(API.userLogout, body);
  return;
}
