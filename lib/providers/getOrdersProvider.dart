import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/testController.dart';
import 'package:spotmies/utilities/shared_preference.dart';

class GetOrdersProvider extends ChangeNotifier {
  final controller = TestController();
  List ordersList = [];
  bool loader = false;
  bool orderViewLoader = false;

  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  void setOrderViewLoader(state) {
    orderViewLoader = state;
    notifyListeners();
  }

  void sortListByTime() {
    ordersList.sort((a, b) {
      return b['join'].compareTo(a['join']);
    });
  }

  void setOrdersList(list) {
    ordersList = list;
    sortListByTime();
    loader = false;
    notifyListeners();
    saveOrders(list);
  }

  List get getOrdersList => ordersList;

  getOrderById(ordId) {
    int index = ordersList.indexWhere(
        (element) => element['ordId'].toString() == ordId.toString());
    if (index < 0) return null;
    return ordersList[index];
  }

  void addNewOrder(newOrder) {
    ordersList.add(newOrder);
    sortListByTime();
    notifyListeners();
  }

  void removeOrderById(ordId) {
    ordersList.removeWhere((element) => element['ordId'] == ordId);
    sortListByTime();
    notifyListeners();
  }

  void updateOrderById({ordId, orderData}) {
    log("order updating....");
    int index = ordersList.indexWhere(
        (element) => element['ordId'].toString() == ordId.toString());
    if (index < 0) return;
    log("order updated");
    ordersList[index] = orderData;
    notifyListeners();
  }
}
