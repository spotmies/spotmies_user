import 'package:flutter/material.dart';

class ResponsesProvider extends ChangeNotifier {
  List responsesList = [];
  bool loader = true;

  List get getResponsesList => responsesList;

  void sortListByTime() {
    responsesList.sort((a, b) {
      return b['join'].compareTo(a['join']);
    });
  }

  void setResponsesList(list) {
    responsesList = list;

    sortListByTime();
    loader = false;
    notifyListeners();
  }

  void removeResponseById(id) {
    responsesList.removeWhere(
        (element) => element['responseId'].toString() == id.toString());
    sortListByTime();
    notifyListeners();
  }

  void addNewResponse(newResponse) {
    responsesList.add(newResponse);
    sortListByTime();
    notifyListeners();
  }

  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  bool get getLoader => loader;
}
