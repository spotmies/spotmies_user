import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/chat/chatapp/personal_chat.dart';

class ResponsiveController extends ControllerMVC {
  ChatProvider chatProvider;
  ResponsesProvider responseProvider;

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var partnerid;
  var pid;
  String value;

  List jobs = [
    'AC Service',
    'Computer',
    'TV Repair',
    'development',
    'tutor',
    'beauty',
    'photography',
    'drivers',
    'events',
    'Electrician',
    'Carpentor',
    'Plumber',
  ];

//rating average function

  avg(List<dynamic> args) {
    var sum = 0;
    var avg = args;

    for (var i = 0; i < avg.length; i++) {
      sum += avg[i];
    }

    return sum;
  }

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);
    //address

    //for notifications
    var androidInitialize = AndroidInitializationSettings('asdf');
    var initializesettings = InitializationSettings(android: androidInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializesettings);
  }

  FlutterLocalNotificationsPlugin localNotifications;

  Future fetchNewResponses() async {
    dynamic response = await Server().getMethod(API.reponse);
    dynamic responseDecode = jsonDecode(response);
    log("$responseDecode");
    responseProvider.setResponsesList(responseDecode);
  }

  acceptOrRejectResponse(responseData, responseType) async {
    if (responseProvider.getLoader) return;
    //enable loader
    responseProvider.setLoader(true);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> body = {};
    if (responseType == "accept") {
      body["responseType"] = responseType.toString();
      body["ordId"] = responseData['orderDetails']['ordId'].toString();
      body["pId"] = responseData['pId'].toString();
      body["uId"] = responseData['orderDetails']['uId'].toString();
      body["ordState"] = "onGoing".toString();
      body["acceptBy"] = "user".toString();
      body["acceptAt"] = timestamp.toString();
      body["acceptResponse"] = responseData['_id'].toString();
      body["pDetails"] = responseData['pDetails']['_id'].toString();
    } else if (responseType == "reject") {
      body["responseType"] = responseType.toString();
      body["acceptResponse"] = responseData['_id'].toString();
    } else {
      snackbar(context, "Something went wrong");
      //disable loader
      responseProvider.setLoader(false);
    }
    var response = await Server().postMethod(API.confirmDeclineOrder, body);
    responseProvider.setLoader(false);
    if (response.statusCode == 200 || response.statusCode == 204) {
      responseProvider.removeResponseById(responseData['responseId']);
      snackbar(context, "Request succeed");
    } else {
      snackbar(context, "Unable to process request please try again later");
    }
  }

  Future chatWithpatner(responseData) async {
    if (responseProvider.getLoader) return;

    String ordId = responseData['ordId'].toString();
    String pId = responseData['pId'].toString();
    List chatList = chatProvider.getChatList2();
    int index = chatList.indexWhere((element) =>
        element['ordId'].toString() == ordId &&
        element['pId'].toString() == pId);
    log("index $index");
    if (index < 0) {
      responseProvider.setLoader(true);
      //this means there is no previous chat with this partner about this post
      //create new chat here
      log("creating new chat room");
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      var newChatObj = {
        "msgId": timestamp,
        "msgs":
            "{\"msg\":\"New Chat Created for this service\",\"type\":\"text\",\"sender\":\"bot\",\"time\":$timestamp}",
        "ordId": ordId,
        "pId": pId,
        "uId": responseData['uId'],
        "uDetails": responseData['uDetails'],
        "pDetails": responseData['pDetails']['_id'],
        "orderDetails": responseData['orderDetails']['_id']
      };
      var response = await Server().postMethod(API.createNewChat, newChatObj);
      responseProvider.setLoader(false);
      if (response.statusCode == 200) {
        log("success ${jsonDecode(response.body)}");
        var newChat = jsonDecode(response.body);
        chatProvider.addNewchat(newChat);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PersonalChat(newChat['msgId'].toString())));
      } else {
        log("req failed $response please try again later");
      }
    } else {
      //already there is a conversation about this post with this partner
      var msgId = chatList[index]['msgId'];
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PersonalChat(msgId.toString())));
    }
  }

  Future shownotification() async {
    var androidDetails = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.high);
    var generalNotificationetails =
        NotificationDetails(android: androidDetails);
    await localNotifications.show(0, 'orderState', 'something behind the info',
        generalNotificationetails);
  }
}
