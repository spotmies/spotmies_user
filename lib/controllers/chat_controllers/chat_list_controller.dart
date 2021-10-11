import 'dart:convert';

import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

dynamic chat;
getChatListFromDb() async {
  dynamic response = await Server().getMethod(API.userChatsList);
  if (response.statusCode == 200) {
    chat = jsonDecode(response.body);
    return chat;
  }
  return null;
}

getResponseListFromDB() async {
  dynamic response = await Server().getMethod(API.reponse);
  if (response.statusCode == 200) {
    dynamic responseDecode = jsonDecode(response.body);
    return responseDecode;
  }
  return null;
}

getOrderFromDB() async {
  dynamic response = await Server().getMethod(API.getOrders);
  if (response.statusCode == 200) {
    dynamic ordersList = jsonDecode(response.body);
    return ordersList;
  }
  return null;
}

getUserDetailsFromDB() async {
  dynamic response = await Server().getMethod(API.userDetails);
  if (response.statusCode == 200) {
    dynamic user = jsonDecode(response.body);
    return user;
  }
  return null;
}
