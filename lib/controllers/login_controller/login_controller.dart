import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/miscellaneous/login/otp.dart';
import 'package:spotmies/models/loginModel.dart';
import 'package:spotmies/providers/timer_provider.dart';

class LoginPageController extends ControllerMVC {
  TimeProvider timerProvider;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var formkey1 = GlobalKey<FormState>();
  TextEditingController loginnum = TextEditingController();

  LoginModel loginModel;

  LoginPageController() {
    this.loginModel = LoginModel();
  }

  @override
  void initState() {
    timerProvider = Provider.of<TimeProvider>(context, listen: false);

    super.initState();
  }

  dataToOTP() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      timerProvider.resetTimer();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OTPScreen(loginnum.text)));
    }
  }
}

checkUserRegistered(uid) async {
  var obj = {"lastLogin": DateTime.now().millisecondsSinceEpoch.toString()};
  // print("checkUserreg");
  var response = await Server().editMethod(API.userDetails, obj);
  // print("36 $response");
  if (response != null)
    return true;
  else
    return false;
}
