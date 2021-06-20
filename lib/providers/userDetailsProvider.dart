import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';

class UserDetailsProvider extends ChangeNotifier {
  final controller = TestController();
  var user;

  userDetails() async {
    var response = await Server().getMethod(API.userDetails);
    user = jsonDecode(response);
    controller.getData();
    notifyListeners();
  }
}
