import 'dart:convert';

import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

dynamic chat;
getChatListFromDb(uuId) async {
  dynamic response = await Server().getMethod(API.userChatsList + uuId);
  if (response.statusCode == 200) {
    chat = jsonDecode(response.body);
    return chat;
  }
  return null;
}

getResponseListFromDB(uuId) async {
  dynamic response = await Server().getMethod(API.reponse + uuId);
  if (response.statusCode == 200) {
    dynamic responseDecode = jsonDecode(response.body);
    return responseDecode;
  }
  return null;
}

getOrderFromDB(uuId) async {
  dynamic response = await Server().getMethod(API.getOrders + uuId);
  if (response.statusCode == 200) {
    dynamic ordersList = jsonDecode(response.body);
    return ordersList;
  }
  return null;
}

getUserDetailsFromDB(uuId) async {
  dynamic response = await Server().getMethod(API.editPersonalInfo + uuId);
  if (response.statusCode == 200) {
    dynamic user = jsonDecode(response.body);
    return user;
  }
  return null;
}
