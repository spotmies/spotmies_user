import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';

class OrderOverViewProvider extends ChangeNotifier {
  final controller = TestController();
  var details;
  var id;

  orderDetails(ordId) async {
    print(ordId);
    var response = await Server().getMethod(API.particularOrder + '$ordId');
    details = jsonDecode(response);
    id = ordId;
    controller.getData();
    notifyListeners();
  }
}
