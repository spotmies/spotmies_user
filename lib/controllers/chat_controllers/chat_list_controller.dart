import 'dart:convert';

import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

var chat;
getChatListFromDb() async {
  var response = await Server().getMethod(API.userChatsList);
  chat = jsonDecode(response);
  return chat;
}

getResponseListFromDB() async {
  var response = await Server().getMethod(API.reponse).catchError((e) {
    print(e);
  });
  var responseDecode = jsonDecode(response);
  return responseDecode;
}
