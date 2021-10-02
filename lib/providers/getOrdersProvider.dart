import 'package:flutter/material.dart';
import 'package:spotmies/apiCalls/testController.dart';

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
    int index = ordersList.indexWhere(
        (element) => element['ordId'].toString() == ordId.toString());
    if (index < 0) return;
    ordersList[index] = orderData;
    notifyListeners();
  }
}
