import 'dart:developer';

import 'package:intl/intl.dart';

getTime(timeStamp) {
  if (timeStamp == null) {
    log(timeStamp);
    return '';
  }
  return DateFormat.jm().format(
      DateTime.fromMillisecondsSinceEpoch((int.parse(timeStamp.toString()))));
}

getDate(dynamic timeStamp) {
  if (timeStamp == null || timeStamp == "null" || timeStamp == "") {
    log(timeStamp);
    return '';
  }
  return DateFormat('dd MMM,yyyy').format(
    DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp.toString())),
  );
}
