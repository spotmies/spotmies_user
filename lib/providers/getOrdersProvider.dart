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

  // getOrders() async {
  //   var response = await Server().getMethod(API.getOrders);
  //   orders = jsonDecode(response);
  //   controller.getData();
  //   notifyListeners();
  // }

  // localStore() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('orders', jsonEncode(orders));
  // }

  // localData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String orderData = prefs.getString('orders');
  //   Map<String, dynamic> details =
  //       jsonDecode(orderData) as Map<String, dynamic>;
  //   local = details;
  // }
}
