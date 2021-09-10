import 'dart:convert';
import 'dart:developer';

import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

var chat;
getChatListFromDb() async {
  var response = await Server().getMethod(API.userChatsList);
  chat = jsonDecode(response);
  return chat;
}

getResponseListFromDB() async {
  var response = await Server().getMethod(API.reponse);
  // log("${response.statusCode} $response");
  var responseDecode = jsonDecode(response);
  return responseDecode;
}

getOrderFromDB() async {
  var response = await Server().getMethod(API.getOrders);
  var ordersList = jsonDecode(response);
  return ordersList;
}
