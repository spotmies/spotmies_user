import 'package:flutter/cupertino.dart';

class TimeProvider extends ChangeNotifier {
  int countDown = 99;
  bool loader = false;
  String otp;
  String verifiedPhoneNumber = "";
  String loading = "";

  void setPhoneNumber(number) {
    verifiedPhoneNumber = number;
    notifyListeners();
  }

  String get phoneNumber => verifiedPhoneNumber;

  void setOtp(value) {
    otp = value;
    notifyListeners();
  }

  get getOtp => otp;

  void setLoader(value, {loadingValue = "Please wait"}) {
    loader = value;
    loading = loadingValue;
    notifyListeners();
  }

  String get getLoading => loading;

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
