import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/snackbar.dart';

class ChatController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  ChatProvider chatProvider;
  UserDetailsProvider profileProvider;

  @override
  void initState() {
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);

    super.initState();
  }

  cardOnClick(msgId, msgId2, readReceiptObj) {
    log("$msgId $msgId2");
    if (readReceiptObj != "" &&
        chatProvider.getChatDetailsByMsgId(msgId)['uCount'] > 0) {
      log("readdd////////////////////");
      chatProvider.setReadReceipt(readReceiptObj);
    }
    chatProvider.setMsgCount(20);
    chatProvider.resetMessageCount(msgId);
    chatProvider.setMsgId(msgId2);
  }

  dateCompare(msg1, msg2) {
    var time1 = msg1;
    var time2 = msg2;
    if (time1.runtimeType != int) time1 = int.parse(time1);
    if (time2.runtimeType != int) time2 = int.parse(time2);
    var ct =
        DateFormat('dd').format(DateTime.fromMillisecondsSinceEpoch(time1));
    var pt =
        DateFormat('dd').format(DateTime.fromMillisecondsSinceEpoch(time2));
    var daynow = DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(
        int.parse(DateTime.now().millisecondsSinceEpoch.toString())));
    var daypast =
        DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(time1));
    if (ct != pt) {
      return (daypast == daynow
          ? 'Today'
          : (DateFormat('dd MMM yyyy')
              .format(DateTime.fromMillisecondsSinceEpoch(time1))));
    } else {
      return "false";
    }
  }

  getTargetChat(list, msgId) {
    List currentChatData =
        list.where((i) => i['msgId'].toString() == msgId.toString()).toList();

    return currentChatData[0];
  }

  sendMessageHandler(msgId, targetChat, value, {sender: "user", action: ""}) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, String> msgData = {
      'msg': value.toString(),
      'time': timestamp,
      'sender': sender,
      'type': 'text',
      'action': action,
    };
    Map<String, dynamic> target = {
      'pId': targetChat['pId'],
      'uId': FirebaseAuth.instance.currentUser.uid,
      'msgId': msgId,
      'ordId': targetChat['ordId'],
      'incomingName': profileProvider.getUser['name'],
      'incomingProfile': profileProvider.getUser['pic'],
      'deviceToken': [targetChat['pDetails']['partnerDeviceToken']]
      // 'deviceToken':['dVMBmjRYQTSXm0twrxhQ5p:APA91bH-tfbTwRZGRLRwYxmrYOiJ8tA6WxHhyGkAKv8NxPUCs9Z_uIjmITGjyxwzrQjT60AVdcDCi2f5Juo249VrakEoKTf8242iLmvceCB2ik2gzc4Y9pYJH-drcX2A1vtcPwlMPtwJ']
    };
    Map<String, Object> sendPayload = {
      "object": jsonEncode(msgData),
      "target": target,
      "socketName": "sendNewMessageCallback".toString()
    };
    log("pay load $sendPayload");
    // return;
    chatProvider.addnewMessage(sendPayload);
    chatProvider.setSendMessage(sendPayload);
    // scrollToBottom();
  }

  deleteOrBlockThisChat(msgId, {bool isChatDelete = false}) async {
    snackbar(context, "wait a moment");
    Map<String, String> body = {'cBuild': "0"};
    if (isChatDelete) body['isDeletedForUser'] = "true";
    dynamic response =
        await Server().editMethod(API.specificChat + msgId.toString(), body);
    if (response != null) {
      //need to block or delete chat here
      if (isChatDelete) {
        snackbar(context, "Your chat deleted and disable too");
        chatProvider.deleteChatByMsgId(msgId);
      } else {
        snackbar(context, "Blocked successfully");
        chatProvider.disableChatByMsgId(msgId);
      }
    }
  }

  chatStreamSocket(targetChat,
      {typeOfAction: "disable", revealProfile: "true"}) {
    Map<String, Object> sendPayload = {
      "uId": targetChat['uId'],
      "pId": targetChat['pId'],
      "msgId": targetChat['msgId'],
      "ordId": targetChat['ordId'],
      "sender": "user",
      "type": typeOfAction,
      "socketName": "chatStream"
    };
    if (typeOfAction == "revealProfile")
      sendPayload['revealProfile'] = revealProfile;

    chatProvider.setSendMessage(sendPayload);
    // chatProvider.disableChatByMsgId(targetChat['msgId']);
  }

  revealProfile(chatDetails, {bool revealProfile = true}) async {
    // chatStreamSocket(chatDetails,
    //     revealProfile: revealProfile, typeOfAction: "revealProfile");
    Map<String, dynamic> body = {
      "revealProfile": revealProfile ? "true" : "false",
      "ordId": chatDetails['ordId'],
      "pId": chatDetails['pId']
    };
    snackbar(context, "Wait a moment");
    dynamic response = await Server().postMethod(API.revealProfile, body);
    if (response.statusCode == 200) {
      chatProvider.revealProfile(
          revealProfile, chatDetails['msgId'], chatDetails['pId']);
      revealProfile
          ? snackbar(context, "You shared your Profile to partner")
          : snackbar(context, "You disabled your Profile to partner");
    } else {
      snackbar(context, "something went wrong");
    }
  }

  getDate(stamp) {
    int timeStamp = stamp.runtimeType == String ? int.parse(stamp) : stamp;
    log(timeStamp.runtimeType.toString());
    var daynow = DateFormat('EEE').format(DateTime.fromMillisecondsSinceEpoch(
        int.parse(DateTime.now().millisecondsSinceEpoch.toString())));
    var daypast = DateFormat('EEE')
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    if (daypast == daynow) {
      return "Today";
    } else {
      return DateFormat('dd MMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
    }
  }

  Future fetchNewChatList() async {
    var response = await Server().getMethod(API.userChatsList);
    dynamic chatList = jsonDecode(response);
    chatProvider.setChatList(chatList);
    snackbar(context, "sync with new changes");
  }
}
