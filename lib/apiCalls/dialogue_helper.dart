import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogueHelper {
  static void showErrorDialogue(
      {String title = 'Error', String description = 'Something went wrong'}) {
    description== 'Something went wrong'?CircularProgressIndicator():
    Fluttertoast.showToast(
        msg: description,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        
        backgroundColor: Colors.grey[900],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
