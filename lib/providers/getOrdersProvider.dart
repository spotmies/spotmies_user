import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/apiCalls/testController.dart';

class GetOrdersProvider extends ChangeNotifier {
  final controller = TestController();
  var orders;

  getOrders() async {
    var response = await Server().getMethod(API.getOrders);
    orders = jsonDecode(response);
    controller.getData();
    notifyListeners();
  }
}