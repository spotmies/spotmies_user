import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/* -------------------------------------------------------------------------- */
/*                       SAVE DATA TO SHARED PREFERENCE                       */
/* -------------------------------------------------------------------------- */

setAppConstants(dynamic data) {
  setStringToSF(id: "constants", value: data);
}

setListOfServices(dynamic data) {
  setStringToSF(id: "servicesList", value: data);
}

saveMyProfile(dynamic data) {
  setStringToSF(id: "profile", value: data);
}

saveResponses(dynamic data) {
  setStringToSF(id: "responses", value: data);
}

saveChats(dynamic data) {
  setStringToSF(id: "chats", value: data);
}

saveOrders(dynamic data) {
  setStringToSF(id: "orders", value: data);
}

/* -------------------------------------------------------------------------- */
/*                       GET DATA FROM SHARED PREFERENCE                      */
/* -------------------------------------------------------------------------- */

getListOfServices() async {
  return await getStringValuesSF("servicesList");
}

getAppConstants() async {
  dynamic constants = await getStringValuesSF("constants");
  return constants;
}

getMyProfile() async {
  dynamic myProfile = await getStringValuesSF("profile");
  return myProfile;
}

getResponses() async {
  dynamic responses = await getStringValuesSF("responses");
  return responses;
}

getChats() async {
  dynamic responses = await getStringValuesSF("chats");
  return responses;
}

getOrders() async {
  dynamic responses = await getStringValuesSF("orders");
  return responses;
}

setStringToSF({String id, value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(id, jsonEncode(value));
}

getStringValuesSF(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  if (!prefs.containsKey(id)) return null;
  String stringValue = prefs.getString(id);
  dynamic returnedValue = jsonDecode(stringValue);
  return returnedValue;
}
