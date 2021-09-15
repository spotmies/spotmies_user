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

getDate(timeStamp) {
  if (timeStamp == null) {
    log(timeStamp);
    return '';
  }
  return DateFormat('dd MMM,yyyy').format(
    DateTime.fromMillisecondsSinceEpoch(timeStamp),
  );
}
