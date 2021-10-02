import 'package:flutter/material.dart';

class ResponsesProvider extends ChangeNotifier {
  List responsesList = [];
  bool loader = true;
  List acceptOrRejectResponsesQueue = [];

  /* -------------------------------------------------------------------------- */
  /*                             THIS IS THE GETTERS                            */
  /* -------------------------------------------------------------------------- */
  List get getResponsesList => responsesList;
  bool get getLoader => loader;
  getResponseById(responseId) {
    int index = responsesList.indexWhere(
        (element) => element['responseId'].toString() == responseId.toString());
    if (index < 0) return null;
    return responsesList[index];
  }

  getResponseByordIdAndPid({ordId, pId}) {
    int index = responsesList.indexWhere((element) =>
        element['ordId'].toString() == ordId.toString() &&
        element['pId'].toString() == pId.toString());
    if (index < 0) return null;
    return responsesList[index];
  }

/* -------------------------------------------------------------------------- */
/*                               THIS IS SETTERS                              */
/* -------------------------------------------------------------------------- */

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

  void addNewResponsesQueue(newResponse) {
    acceptOrRejectResponsesQueue.add(newResponse);
    notifyListeners();
  }

  void resetResponsesQueue() {
    acceptOrRejectResponsesQueue.clear();
    notifyListeners();
  }
}
