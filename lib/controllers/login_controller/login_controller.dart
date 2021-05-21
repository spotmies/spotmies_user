import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/miscellaneous/login/otp.dart';
import 'package:spotmies/models/loginModel.dart';

class LoginPageController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var formkey1 = GlobalKey<FormState>();
  TextEditingController loginnum = TextEditingController();

  LoginModel loginModel;
 
  LoginPageController() {
    this.loginModel = LoginModel();
  }
  dataToOTP() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OTPScreen(loginnum.text)));
    }
  }
 
}
