import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/login_controller.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/home/navBar.dart';
import 'package:spotmies/views/login/stepperPersonalInfo.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // Timer _timer;
  // int _start = 60;
  TimeProvider timerProvider;
  Timer _timer;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    //const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
      //const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  startTimer() {
    _timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      timerProvider.updateTime();
      if (timerProvider.countDown < 2) timer?.cancel();
    });
  }

  @override
  void initState() {
    _timer?.cancel();
    timerProvider = Provider.of<TimeProvider>(context, listen: false);

    super.initState();
    _verifyPhone();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void resendOtp() {
    timerProvider.resetTimer();
    _verifyPhone();
  }

  loginUserWithOtp(otpValue) async {
    log(otpValue.toString());
    timerProvider.setLoader(true);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otpValue))
          .then((value) async {
        if (value.user != null) {
          // print("user already login");
          bool resp = await checkUserRegistered(value.user.uid);
          timerProvider.setLoader(false);
          if (resp == false) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StepperPersonalInfo()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GoogleNavBar()),
                (route) => false);
          }
        } else {
          timerProvider.setLoader(false);
          snackbar(context, "Something went wrong");
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      log(e.toString());
      timerProvider.setLoader(false);
      snackbar(context, "Invalid OTP");
      // _scaffoldkey.currentState
      //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    // startTimer();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue[900],
      key: _scaffoldkey,
      body: Consumer<TimeProvider>(builder: (context, data, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              AbsorbPointer(
                absorbing: data.getLoader,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: _hight * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: Center(
                                child: Icon(
                              Icons.message,
                              color: Colors.blue[900],
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
                    Container(
                      height: _hight * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: PinPut(
                          fieldsCount: 6,
                          textStyle: const TextStyle(
                              fontSize: 25.0, color: Colors.blueGrey),
                          eachFieldWidth: _width * 0.1,
                          eachFieldHeight: _hight * 0.08,
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration,
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.fade,
                          onChanged: (pin) {
                            data.setOtp(pin.toString());
                          },
                          onSubmit: (pin) {
                            loginUserWithOtp(pin);
                          },
                        ),
                      ),
                    ),
                    data.countDown > 2
                        ? Container(
                            height: _hight * 0.3,
                            child: CircularPercentIndicator(
                                radius: 60,
                                lineWidth: 5,
                                animation: true,
                                animationDuration: 99999,
                                progressColor: Colors.white,
                                percent: 1.0,
                                backgroundColor: Colors.blue[900],
                                center: Text(
                                  '${data.countDown}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                )),
                          )
                        : Container(
                            width: 150,
                            child: ElevatedButtonWidget(
                              onClick: resendOtp,
                              height: 20,
                              minWidth: 100,
                              buttonName: "Resend",
                              bgColor: Colors.transparent,
                              borderSideColor: Colors.transparent,
                              textSize: 16,
                              textColor: Colors.white,
                              trailingIcon: Icon(
                                Icons.refresh_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.only(
                          top: data.countDown > 2 ? 0 : _hight * 0.25),
                      child: ElevatedButtonWidget(
                        onClick: () {
                          loginUserWithOtp(data.getOtp);
                        },
                        height: 40,
                        textStyle: FontWeight.w600,
                        minWidth: 160,
                        buttonName: "Submit",
                        bgColor: Colors.white,
                        borderSideColor: Colors.transparent,
                        textSize: 22,
                        borderRadius: 10,
                        textColor: Colors.blue[900],
                        trailingIcon: Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.blue[900],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: data.getLoader,
                // visible: true,
                child: Positioned.fill(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                    backgroundColor: Colors.white,
                  )),
                )),
              ),
            ]),
          ],
        );
      }),
    );
  }

  _verifyPhone() async {
    startTimer();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // print("user already login");
              // checkUserRegistered(value.user.uid);
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
          log(e.message.toString());
        },
        codeSent: (String verficationID, int resendToken) {
          snackbar(context, "Otp send successfully ");

          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 99));
  }

  // @override
  // void initState() {
  //   // implement initstate
  //   super.initState();

  // }
}
