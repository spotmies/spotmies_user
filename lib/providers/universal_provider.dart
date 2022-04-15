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
  dynamic partnerStore;
  List partnerList = [];
  List catelogList = [];
  dynamic checkNull = {"content": "Loading", "id": "0"};
  dynamic user;
  String add2 = "";

  get getAdd2 => add2;

  void setAdd2(String address) {
    add2 = address;
  }

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

  getMainServiceId(id) async {
    List outputList = await getCategoryMainList()
        .where((o) => o['subServices'].isNotEmpty)
        .toList();
    dynamic index = await outputList
        .indexWhere((element) => element['subServices'].contains(id));
    return outputList[index];
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

  fetchPartnerStore(pid) async {
    dynamic response = await Server().getMethod(API.partnerStore + pid);
    if (response.statusCode == 200) {
      dynamic responseDecode = jsonDecode(response.body);
      partnerStore = responseDecode;
      notifyListeners();
    } else {
      log('Something went wrong');
    }
  }

  fetchPartnerList(skip, limit) async {
    var query = await {"skip": skip.toString(), "limit": limit.toString()};
    dynamic response = await Server().getMethodParems(API.partnerList, query);
    if (response.statusCode == 200) {
      dynamic responseDecode = jsonDecode(response.body);
      if (responseDecode.isNotEmpty) {
        partnerList.addAll(responseDecode);
      } else {
        checkNull = {"content": "No data found", "id": "1"};
      }
      notifyListeners();
      // return true;
    } else {
      log('Something went wrong');
      // return true;
    }
  }

  // refresh() async {
  //   await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
  //   partnerList.clear();
  //   fetchPartnerList(0, 3);
  // }

  fetchCatelogList(skip, limit, job) async {
    var query = await {"skip": skip.toString(), "limit": limit.toString()};
    dynamic response =
        await Server().getMethodParems(API.catelogList + job.toString(), query);
    if (response.statusCode == 200) {
      dynamic responseDecode = jsonDecode(response.body);
      if (responseDecode.isNotEmpty) {
        catelogList.addAll(responseDecode);
      } else {
        checkNull = {"content": "No data found", "id": "1"};
      }
      notifyListeners();
      // return true;
    } else {
      log('Something went wrong');
      // return true;
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
