import 'package:flutter/material.dart';

class ServiceViewModel extends ChangeNotifier {
  final List<bool> _list = [false, false, false, false, false];
  List<bool> get list => _list;
  String _feedbackText = "";
  String get feedback => _feedbackText;
  bool _canChangeFeedback = true;
  bool get canChangeFeedback => _canChangeFeedback;
  bool manas = true;
  void changeListState(int index) {
    for (var i = 0; i < _list.length; i++) {
      _list[i] = i == index ? !_list[index] : false;
    }
    _canChangeFeedback = index >= 0 ? true : false;

    print(_canChangeFeedback);
    notifyListeners();
  }

  void setFeedback(String feedback) {
    _feedbackText = feedback;
    notifyListeners();
  }
}
