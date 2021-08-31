import 'dart:convert';

import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';

var chat;
getChatListFromDb() async {
  var response = await Server().getMethod(API.userChatsList);
  chat = jsonDecode(response);
  return chat;
}
