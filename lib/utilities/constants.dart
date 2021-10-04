import 'package:flutter/material.dart';

orderStateString({ordState = 0}) {
  int orderState =
      ordState.runtimeType == String ? int.parse(ordState) : ordState;
  switch (orderState) {
    case 0:
      return "Service Request by You";
    case 1:
      return "There is no partner available for this Service please try again later";
    case 2:
      return "You updated your Service updated";
    case 3:
      return "Service cancelled by You";
    case 4:
      return "Service cancelled by Partner";
    case 5:
      return "Something went wrong";
    case 6:
      return "There is not value for this string";
    case 7:
      return "Service reshedule by the You";
    case 8:
      return "Service is Ongoing";
    case 9:
      return "Service successfully completed";
    case 10:
      return "Service successfully completed and feedback given by You";

    default:
      return "Something went wrong";
  }
}

  orderStateIcon({ordState = 0}) {
      int orderState =
      ordState.runtimeType == String ? int.parse(ordState) : ordState;
  switch (orderState) {
    case 0:
      return Icons.pending_actions;
      break;
    case 1:
      return Icons.stop_circle;
      break;
    case 2:
      return Icons.update;
      break;
    case 8:
      return Icons.run_circle_rounded;
      break;
    case 9:
      return Icons.done_all;
      break;
    case 3:
      return Icons.cancel;
      break;
    default:
      return Icons.search;
  }
}
