import 'package:flutter/material.dart';

class UniversalProvider extends ChangeNotifier {
  int currentNavigationPage = 0; //0 - home 1- chat 2-my booking 3 - account
  bool chatBadge = false;
  List geoLocations = [];
  List searchLocations = [];
  bool locationsLoader = false;
  bool enableRoute = false;
  Map<dynamic, dynamic> allConstants = {};
  String currentScreen = "";
  dynamic currentConstants;

  void setAllConstants(dynamic constants){
    allConstants = constants;
  }
   getAllConstants(){
    return allConstants;
  }
  void setCurrentScreen(String screenName){
    currentScreen = screenName;
    currentConstants = allConstants[currentScreen];
  }

    getText(String objId) {
    if (currentConstants == null) return "loading..";
    int index = currentConstants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());

    if (index == -1) return "null";
    return currentConstants[index]['label'];
  }

  void setEnableRoute(bool state) {
    enableRoute = state ?? false;
    notifyListeners();
  }

  void setLocationsLoader(bool state) {
    locationsLoader = state;
    notifyListeners();
  }

  int get getCurrentPage {
    return currentNavigationPage;
  }

  void setCurrentPage(int page) {
    currentNavigationPage = page;
    if (page == 1) chatBadge = false;
    notifyListeners();
  }

  void setGeoLocations(locations) {
    geoLocations = locations;
    searchLocations = locations;
    notifyListeners();
  }

  void setSearchLocations(locations) {
    searchLocations = locations;
    notifyListeners();
  }

  void showAllLocation() {
    searchLocations = geoLocations;
    notifyListeners();
  }

  bool get getChatBadge => chatBadge;

  void setChatBadge() {
    if (currentNavigationPage != 1) chatBadge = true;
    notifyListeners();
  }
}
