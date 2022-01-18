import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/login_controller.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String verificationId;
  OTPScreen(this.phone, this.verificationId);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends StateMVC<OTPScreen> {
  LoginPageController _loginPageController;
  UniversalProvider up;
  _OTPScreenState() : super(LoginPageController()) {
    this._loginPageController = controller;
  }

  TimeProvider timerProvider;
  Timer _timer;
  int pinlength;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.indigo[50],
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
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
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("otp");

    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void resendOtp() {
    timerProvider.resetTimer();
    // _verifyPhone();

    _loginPageController.verifyPhone(navigate: false);
    startTimer();
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
      backgroundColor: Colors.white,
      key: _loginPageController.scaffoldkey,
      body: Consumer<TimeProvider>(builder: (context, data, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              AbsorbPointer(
                absorbing: data.getLoader,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: _hight * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.greenAccent[400],
                            radius: 50,
                            child: Center(
                                child: Icon(
                              Icons.security,
                              color: Colors.white,
                              size: 40,
                            )),
                          ),
                          SizedBox(
                            height: _hight * 0.06,
                          ),
                          Container(
                            width: _width,
                            child: TextWid(
                              text: 'Verification',
                              weight: FontWeight.bold,
                              align: TextAlign.center,
                              size: _width * 0.075,
                              color: Colors.indigo[900],
                            ),
                          ),
                          SizedBox(
                            height: _hight * 0.02,
                          ),
                          Container(
                            width: _width,
                            child: TextWid(
                              text: 'You will get an OTP via SMS',
                              weight: FontWeight.bold,
                              align: TextAlign.center,
                              size: _width * 0.04,
                              color: Colors.indigo[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _hight * 0.2,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: _width * 0.04),
                            width: _width,
                            child: TextWid(
                              text:
                                  'please enter one time password you recieved to +91-${widget.phone} to verify your account',
                              weight: FontWeight.bold,
                              align: TextAlign.center,
                              flow: TextOverflow.visible,
                              size: _width * 0.04,
                              color: Colors.blueGrey[200],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: PinPut(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              fieldsCount: 6,
                              textStyle: fonts(_width * 0.045, FontWeight.w600,
                                  Colors.indigo[900]),
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
                                _loginPageController.loginUserWithOtp(pin);
                                setState(() {
                                  pinlength = pin.length;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (pinlength == 6 && data.countDown > 2)
                      SizedBox(
                        height: _hight * 0.25,
                      ),
                    if (pinlength != 6)
                      data.countDown > 1
                          ? Container(
                              height: _hight * 0.3,
                              child: CircularPercentIndicator(
                                  radius: 55,
                                  lineWidth: 3,
                                  animation: true,
                                  animationDuration: 99999,
                                  progressColor: Colors.indigo[50],
                                  percent: 1.0,
                                  backgroundColor: Colors.indigo[900],
                                  center: TextWid(
                                    text: '${data.countDown}',
                                    color: Colors.indigo[900],
                                    size: width(context) * 0.055,
                                    weight: FontWeight.w600,
                                  )),
                            )
                          : Container(
                              width: _width * 0.45,
                              child: ElevatedButtonWidget(
                                onClick: resendOtp,
                                height: _hight * 0.07,
                                minWidth: _width * 0.045,
                                buttonName: "Resend OTP?",
                                bgColor: Colors.transparent,
                                borderSideColor: Colors.transparent,
                                textSize: _width * 0.037,
                                textColor: Colors.indigo[900],
                                // trailingIcon: Icon(
                                //   Icons.sync,
                                //   size: 18,
                                //   color: Colors.indigo[900],
                                // ),
                              ),
                            ),
                    if (pinlength == 6)
                      Container(
                        padding: EdgeInsets.only(
                            top: data.countDown > 2 ? 0 : _hight * 0.25),
                        child: ElevatedButtonWidget(
                          onClick: () {
                            _loginPageController.loginUserWithOtp(data.getOtp);
                          },
                          height: _hight * 0.07,
                          textStyle: FontWeight.w600,
                          minWidth: _width * 0.45,
                          buttonName: "Submit",
                          bgColor: Colors.white,
                          borderSideColor: Colors.transparent,
                          textSize: _width * 0.045,
                          borderRadius: 10,
                          elevation: 1,
                          textColor: Colors.blue[900],
                          trailingIcon: Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.blue[900],
                          ),
                        ),
                      )
                  ],
                ),
              ),
              ProgressWaiter(
                contextt: context,
                loaderState: data.getLoader,
                loadingName: data.getLoading,
              ),
            ]),
          ],
        );
      }),
    );
  }
}
