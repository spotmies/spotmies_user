import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
import 'package:video_player/video_player.dart';

class ChatController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  ChatProvider chatProvider;
  UserDetailsProvider profileProvider;
  List chatList = [];
  Map targetChat = {};
  Map partner = {};
  Map userDetails = {};
  Map orderDetails = {};
  String currentMsgId = "";
  List<File> chatimages = [];
  List<File> chatVideo = [];
  List imageLink = [];
  List videoLink = [];
  List audioLink = [];
  final picker = ImagePicker();
  VideoPlayerController videoPlayerController;
  @override
  void initState() {
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    log("<<<<<<<<<<chat controller initiated>>>>>>>>>>>");
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

  sendMessageHandler(msgId, value,
      {String sender: "user",
      String action: "",
      dynamic chatDetails,
      String type: "text"}) {
    if (chatProvider.personalChatLoader) {
      snackbar(context, "wait a moment");
      return;
    }
    log("target chat is $partner $orderDetails");
    //return;
    Map<dynamic, dynamic> targetC = chatDetails ?? targetChat;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, String> msgData = {
      'msg': value.toString(),
      'time': timestamp,
      'sender': sender,
      'type': type,
      'action': action,
    };
    Map<String, dynamic> target = {
      'pId': targetC['pId'],
      'uId': FirebaseAuth.instance.currentUser.uid,
      'msgId': msgId,
      'ordId': targetC['ordId'],
      'incomingName': profileProvider.getUser['name'],
      'incomingProfile': profileProvider.getUser['pic'],
      'deviceToken': [targetC['pDetails']['partnerDeviceToken']]
      // 'deviceToken':['dVMBmjRYQTSXm0twrxhQ5p:APA91bH-tfbTwRZGRLRwYxmrYOiJ8tA6WxHhyGkAKv8NxPUCs9Z_uIjmITGjyxwzrQjT60AVdcDCi2f5Juo249VrakEoKTf8242iLmvceCB2ik2gzc4Y9pYJH-drcX2A1vtcPwlMPtwJ']
    };
    Map<String, Object> sendPayload = {
      "object": jsonEncode(msgData),
      "target": target,
      "socketName": "sendNewMessageCallback"
    };
    log("pay load $sendPayload");
    // return;
    chatProvider.addnewMessage(sendPayload);
    chatProvider.setSendMessage(sendPayload);
    // scrollToBottom();
  }

  deleteOrBlockThisChat(msgId, {bool isChatDelete = false}) async {
    if (chatProvider.personalChatLoader) {
      snackbar(context, "wait a moment");
      return;
    }
    chatProvider.setPersonalChatLoader(true);
    Map<String, String> body = {'cBuild': "0"};
    if (isChatDelete) body['isDeletedForUser'] = "true";
    dynamic response =
        await Server().editMethod(API.specificChat + msgId.toString(), body);
    chatProvider.setPersonalChatLoader(false);
    if (response != null) {
      //need to block or delete chat here
      if (isChatDelete) {
        Navigator.pop(context);
        Navigator.pop(context);
        snackbar(context, "Your chat deleted and disable too");
        Timer(Duration(seconds: 1), () {
          chatProvider.deleteChatByMsgId(msgId);
        });
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
    if (chatProvider.personalChatLoader) {
      snackbar(context, "wait a moment");
      return;
    }

    // chatStreamSocket(chatDetails,
    //     revealProfile: revealProfile, typeOfAction: "revealProfile");
    Map<String, dynamic> body = {
      "revealProfile": revealProfile ? "true" : "false",
      "ordId": chatDetails['ordId'],
      "pId": chatDetails['pId']
    };
    chatProvider.setPersonalChatLoader(true);
    dynamic response = await Server().postMethod(API.revealProfile, body);
    chatProvider.setPersonalChatLoader(false);
    if (response.statusCode == 200) {
      chatProvider.revealProfile(
          revealProfile, chatDetails['msgId'], chatDetails['pId']);
      revealProfile
          ? snackbar(context, "You shared your Profile to partner")
          : snackbar(context, "You disabled your Profile to partner");
    } else {
      snackbar(context, "something went wrong try again later");
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
    if (chatProvider.personalChatLoader) {
      snackbar(context, "wait a moment");
      return;
    }
    chatProvider.setPersonalChatLoader(true);
    dynamic response = await Server().getMethod(API.userChatsList);
    chatProvider.setPersonalChatLoader(false);
    dynamic chatList = jsonDecode(response);
    chatProvider.setChatList(chatList);
    snackbar(context, "sync with new changes");
  }

  chooseImage(sendCallBack, String msgId) async {
    if (imageLink.length != 0) {
      await imageLink.removeAt(0);
      chatimages.removeAt(0);
    }
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );
    setState(() {
      chatimages.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();

    await uploadFilesLoop(msgId, fileArray: chatimages, type: "img");
    chatimages.clear();
  }

  uploadAudioFiles(File audioFile) async {
    await uploadFilesLoop(currentMsgId, fileArray: [audioFile], type: "audio");
  }

  Future<void> uploadFilesLoop(String msgId,
      {fileArray, String type = "img"}) async {
    String extensionType() {
      switch (type) {
        case "img":
          return ".jpg";
        case "audio":
          return ".aac";
        case "video":
          return ".mp4";

          break;
        default:
          return ".jpg";
      }
    }

    fileArray.forEach((imgFile) async {
      chatProvider.setPersonalChatLoader(true, text: "Sending Files");
      String uploadedFile = await uploadFilesToCloud(imgFile,
          fileType: extensionType(), cloudLocation: "chatMedia");
      chatProvider.setPersonalChatLoader(false);
      sendMessageHandler(msgId, uploadedFile, type: type);
    });
  }

  pickVideo(sendCallBack, String msgId) async {
    PickedFile pickedFile = await picker.getVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 10));
    chatVideo.add(File(pickedFile.path));
    videoPlayerController = VideoPlayerController.file(chatVideo[0]);
    // uploadVideo(sendCallBack, msgId);
    await uploadFilesLoop(msgId, fileArray: chatVideo, type: "video");
    chatVideo.clear();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        chatimages.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }
}
