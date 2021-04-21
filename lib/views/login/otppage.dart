import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:spotmies/views/login/stepperPersonalInfo.dart';
import 'package:spotmies/controllers/login_controller/otp_controller.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends StateMVC<OTPScreen> {
  OTPController _otpController;
  _OTPScreenState() : super(OTPController()) {
    this._otpController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      key: _otpController.scaffoldkey,
      // appBar: AppBar(
      //   title: Text('OTP Verification'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Center(
                      child: Icon(
                    Icons.message,
                    color: Colors.blue[800],
                    size: 40,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter One Time Password You recieved to Verify',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  '+91 ${widget.phone}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle:
                  const TextStyle(fontSize: 25.0, color: Colors.blueGrey),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _otpController.pinPutFocusNode,
              controller: _otpController.pinPutController,
              submittedFieldDecoration: _otpController.pinPutDecoration,
              selectedFieldDecoration: _otpController.pinPutDecoration,
              followingFieldDecoration: _otpController.pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _otpController.verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      //print(widget.phone);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepperPersonalInfo(
                                  //value: widget.phone,
                                  )),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  // _scaffoldkey.currentState
                  //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  
}
