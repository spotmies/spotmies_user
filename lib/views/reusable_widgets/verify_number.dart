// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spotmies/controllers/login_controller/login_controller.dart';
// import 'package:spotmies/providers/timer_provider.dart';
// import 'package:spotmies/utilities/snackbar.dart';
// import 'package:spotmies/views/login/otppage.dart';
// import 'package:spotmies/views/login/stepperPersonalInfo.dart';

// verifyPhone(String phone, BuildContext context,
//     LoginPageController loginPageController, TimeProvider timerProvider) async {
//   // startTimer();
//   await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+91${phone}',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance
//             .signInWithCredential(credential)
//             .then((value) async {
//           if (value.user != null) {
//             // print("user already login");
//             // checkUserRegistered(value.user.uid);
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => StepperPersonalInfo(
//                         //value: '+91${widget.phone}'
//                         )),
//                 (route) => false);
//           }
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         log(e.message.toString());
//       },
//       codeSent: (String verficationID, int resendToken) {
//         timerProvider.setLoader(false);
//         snackbar(context, "Otp send successfully ");
//         // _verificationCode = verficationID;
//          Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => OTPScreen(verficationID)));
//         loginPageController.refresh();
//         // setState(() {
//         //   _verificationCode = verficationID;
//         // });
//       },
//       codeAutoRetrievalTimeout: (String verificationID) {
//         // setState(() {
//         //   _verificationCode = verificationID;
//         // });
//          _verificationCode = verificationID;
//          loginPageController.refresh();
//       },
//       timeout: Duration(seconds: 99));
// }
