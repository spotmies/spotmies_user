import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';

class GetResponseProvider extends ChangeNotifier {
  final controller = TestController();
  var responseData;
  var local;

  responseInfo(status) async {
    if (status == false) {
      await localData();
    }
    if (status == true) {
      await getResponse();
      await localStore();
      await localData();
      print('done all');
    }
  }

  getResponse() async {
    var response = await Server().getMethod(API.reponse).catchError((e) {
      print(e);
    });
    responseData = jsonDecode(response);
    controller.getData();
    notifyListeners();
  }

  localStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('orders', jsonEncode(responseData)).catchError((e) {
      print(e);
    });
  }

  localData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String orderData = prefs.getString('orders');
    List<dynamic> details = local == null ? jsonDecode(orderData) : local;
    local = details;
  }
}
