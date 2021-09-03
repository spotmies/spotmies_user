import 'package:flutter/material.dart';

class UniversalProvider extends ChangeNotifier {
  int currentNavigationPage = 0; //0 - home 1- chat 2-my booking 3 - account
  bool chatBadge = false;

  int get getCurrentPage {
    return currentNavigationPage;
  }

  void setCurrentPage(int page) {
    currentNavigationPage = page;
    if (page == 1) chatBadge = false;
    notifyListeners();
  }

  bool get getChatBadge => chatBadge;

  void setChatBadge() {
    if (currentNavigationPage != 1) chatBadge = true;
    notifyListeners();
  }
}
