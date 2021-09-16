import 'package:flutter/cupertino.dart';

class TimeProvider extends ChangeNotifier {
  int countDown = 99;
  bool loader = false;
  String otp;

  void setOtp(value) {
    otp = value;
    notifyListeners();
  }

  get getOtp => otp;

  void setLoader(value) {
    loader = value;
    notifyListeners();
  }

  get getLoader => loader;
  updateTime() {
    if (countDown != 0) {
      countDown--;
    }
    notifyListeners();
  }

  void resetTimer() {
    countDown = 99;
    notifyListeners();
  }
}
