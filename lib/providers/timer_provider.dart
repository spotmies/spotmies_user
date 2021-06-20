import 'package:flutter/cupertino.dart';

class TimeProvider extends ChangeNotifier {
  int countDown = 99;

  updateTime() {
    if (countDown != 0) {
      countDown--;
    }
    notifyListeners();
  }
}
