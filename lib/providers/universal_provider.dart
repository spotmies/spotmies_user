import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/utilities/shared_preference.dart';

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
  List faqList = [];
  dynamic user;

  void setUser(data) {
    user = data;
  }

  void setAllConstants(dynamic constants) {
    allConstants = constants;
  }

  getAllConstants() {
    return allConstants;
  }

  void setCurrentConstants(String screenName) {
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

  getValue(String objId) {
    if (currentConstants == null) return null;
    int index = currentConstants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());
    if (index == -1) return null;
    dynamic retrive = jsonDecode(currentConstants[index]['value']);
    log("retrive $retrive");
    return retrive;
  }

/* -------------------------- service list details -------------------------- */
  List servicesList = [];
  getServiceListFromServer() async {
    dynamic resp = await Server().getMethod(API.servicesList);
    if (resp.statusCode == 200) {
      dynamic list = jsonDecode(resp.body);
      log(list.toString());
      log("confirming all serviceslist are downloaded....");
      servicesList = list;
      sortServiceList();
      setListOfServices(list);
      return true;
    } else {
      return false;
    }
  }

  fetchServiceList({bool alwaysHit = false}) async {
    if (!alwaysHit) {
      dynamic servicesListFromSf = await getListOfServices();
      if (servicesListFromSf != null) {
        servicesList = servicesListFromSf;

        log("service list already in sf");
        return;
      }
    }

    getServiceListFromServer();
  }

  List<dynamic> getCategoryMainList() {
    List outputList =
        servicesList.where((o) => o['isMainService'] == true).toList();
    return outputList;
  }

  List<dynamic> getCategorySubList() {
    List outputList =
        servicesList.where((o) => o['isMainService'] == false).toList();
    return outputList;
  }

  getMainServiceId(id) {
    int index =
        getCategoryMainList().indexWhere((element) => element['_id'] == 1);
    return getCategoryMainList()[index];
  }

  void sortServiceList() {
    servicesList.sort((a, b) {
      return a['sort'].compareTo(b['sort']);
    });
  }

  getServiceNameById(int id) {
    int index =
        servicesList.indexWhere((element) => element['serviceId'] == id);
    if (index < 0) return "null";
    return servicesList[index]['nameOfService'];
  }
  /* ----------------------------------- xxx ---------------------------------- */

  fetchFAQfromDB() async {
    dynamic response = await Server().getMethod(API.faq);
    if (response.statusCode == 200) {
      dynamic responseDecode = jsonDecode(response.body);
      faqList = responseDecode;
      notifyListeners();
    }
  }

  void setEnableRoute(bool state) {
    enableRoute = state;
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
