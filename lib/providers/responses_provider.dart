import 'package:flutter/material.dart';

class ResponsesProvider extends ChangeNotifier {
  List responsesList = [];

  List get getResponsesList => responsesList;

  void setResponsesList(list) {
    responsesList = list;
    notifyListeners();
  }

  void addNewResponse(newResponse) {
    responsesList.add(newResponse);
    notifyListeners();
  }
}
