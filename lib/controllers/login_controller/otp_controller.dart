import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/models/loginmodel.dart';
import 'package:spotmies/views/login/stepperPersonalInfo.dart';

class OTPController extends ControllerMVC {
  //  final String phone;
  // OTPController(this.phone);
  // final String phone;
  // OTPController(this.phone);
  var scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController pinPutController = TextEditingController();
  late String verificationCode;
  final FocusNode pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
    ),
  );
  otp() {}
  late LoginModel loginModel;

  OTPController() {
    this.loginModel = LoginModel();
  }

  _verifyPhone() async {
    print('+91${loginModel.loginnum}');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${loginModel.loginnum}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StepperPersonalInfo(
                          //value: '+91${widget.phone}'
                          )),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    // implement initstate
    super.initState();
    _verifyPhone();
  }
}
