import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';

class UserDetailsProvider extends ChangeNotifier {
  final controller = TestController();
  dynamic user;
  bool loader = true;

  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  void setUser(uDetails) {
    user = uDetails;
    loader = false;
    notifyListeners();
  }

  dynamic get getUser => user;

  userDetails() async {
    var response = await Server().getMethod(API.userDetails);
     if(response.statusCode == 200){
    user = jsonDecode(response.body);
      controller.getData();
      notifyListeners();
     }

  }
}
