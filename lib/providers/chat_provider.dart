import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotmies/views/chat/chatapp/chat_list.dart';

class ChatProvider extends ChangeNotifier {
  List<dynamic> chatList = [];
  List<dynamic> sendMessageQueue = [];
  List<dynamic> readReceipts = [];
  bool readyToSend = true;
  String currentMsgId = "";
  bool scrollEvent = false;
  int msgCount = 20;
  bool enableFoat = true;
  bool loader = true;
  bool personalChatLoader = false;

  //calling variables
  bool terminateCall = false;
  bool acceptCalls = true;
  int callDuration = 0;
  int callInitTimeOut = 15;
  bool stopTimer = false;

  int callStatus = 0; // 0- connecting or new connection 1-calling 2- ringing
  //3- connected 4- rejected 5- not lifted 6- call failed or disconnected

  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
  }

  void setPersonalChatLoader(state) {
    personalChatLoader = state;
    notifyListeners();
  }

  setChatList(var list) {
    print("loading chats ..........>>>>>>>>> $list");
    chatList = list;
    confirmReceiveAllMessages();
    loader = false;
    notifyListeners();
  }

  getChatList2() => chatList;
  getChatDetailsByMsgId(msgId) {
    int index = chatList.indexWhere((element) => element['msgId'] == msgId);
    return chatList[index];
  }

  void addNewchat(chat) {
    chatList.add(chat);
    notifyListeners();
  }

  newMessagetemp() => sendMessageQueue;

  addnewMessage(value) {
    String msgId = value['target']['msgId'];
    var sender = jsonDecode(value['object']);
    sender = sender['sender'];
    log("$msgId $currentMsgId $sender");
    var allChats = chatList;
    for (int i = 0; i < allChats.length; i++) {
      if (allChats[i]['msgId'] == msgId) {
        allChats[i]['msgs'].add(value['object']);
        allChats[i]['lastModified'] =
            int.parse(DateTime.now().millisecondsSinceEpoch.toString());
        if (sender == "user") {
          allChats[i]['uState'] = 0;
          callStatus = 0;
        } else {
          //read receipt code
          log("read receipt provider");

          //this means message recieved or read by end user
          Map object = {
            "uId": allChats[i]['uId'],
            "pId": allChats[i]['pId'],
            "msgId": allChats[i]['msgId'],
            "sender": "user",
            "status": currentMsgId == msgId ? 3 : 2
          };
          setReadReceipt(object);
        }
        if (msgId != currentMsgId) {
          allChats[i]['uCount'] = allChats[i]['uCount'] + 1;
        }
        allChats.sort((a, b) {
          return b['lastModified'].compareTo(a['lastModified']);
        });
        chatList = allChats;
        break;
      }
    }
    scrollEvent = !scrollEvent;
    notifyListeners();
  }

  confirmReceiveAllMessages() {
    log("confirmall messages ${chatList.length}");
    for (int i = 0; i < chatList.length; i++) {
      if (chatList[i]['uCount'] > 0 && chatList[i]['pState'] < 2) {
        log("confirmed");
        Map object = {
          "uId": chatList[i]['uId'],
          "pId": chatList[i]['pId'],
          "msgId": chatList[i]['msgId'],
          "sender": "user",
          "status": 2
        };

        readReceipts.add(object);
      }
    }
  }

  getPdetailsByMsgId(msgId) {
    int index = chatList.indexWhere(
        (element) => element['msgId'].toString() == msgId.toString());
    return chatList[index]['pDetails'];
  }

  resetMessageCount(msgId) {
    int index =
        chatList.indexWhere((element) => element['msgId'].toString() == msgId);
    log(chatList[index]['uCount'].toString());
    chatList[index]['uCount'] = 0;
    log(chatList[index]['uCount'].toString());

    notifyListeners();
  }

  setSendMessage(payload) {
    sendMessageQueue.add(payload);
    log(sendMessageQueue.toString());
    notifyListeners();
  }

  readReceipt(msgId, status) {
    int index = chatList.indexWhere((element) => element['msgId'] == msgId);
    if (index < 0) return;
    chatList[index]['uState'] = status;
  }

  chatReadReceipt(msgId, status) {
    readReceipt(msgId, status ?? 2);
    callStatus = status == 3 ? 2 : status;
    notifyListeners();
  }

  clearMessageQueue(msgId) {
    sendMessageQueue.clear();
    readyToSend = true;
    readReceipt(msgId, 1);

    notifyListeners();
  }

  clearMessageQueue2() {
    sendMessageQueue.clear();
    readyToSend = true;
    notifyListeners();
  }

  deleteChatByMsgId(msgId) {
    chatList.removeWhere(
        (element) => element['msgId'].toString() == msgId.toString());
    notifyListeners();
  }

  disableChatByMsgId(msgId) {
    chatList[chatList.indexWhere(
            (element) => element['msgId'].toString() == msgId.toString())]
        ['cBuild'] = 0;
    notifyListeners();
  }

  setScroll() {
    scrollEvent = !scrollEvent;
    notifyListeners();
  }

  getScroll() => scrollEvent;

  getMsgId() => currentMsgId;

  setMsgId(msgId) {
    currentMsgId = msgId;
    readyToSend = true;
    notifyListeners();
  }

  getMsgCount() => msgCount;
  setMsgCount(count) {
    msgCount = count;
    notifyListeners();
  }

  getFloat() => enableFoat;
  setFloat(state) {
    enableFoat = state;
    notifyListeners();
  }

  getReadyToSend() => readyToSend;
  setReadyToSend(state) {
    readyToSend = state;
  }

  setReadReceipt(payload) {
    if (payload == "clear")
      readReceipts.clear();
    else
      readReceipts.add(payload);
    notifyListeners();
  }

  getReadReceipt() => readReceipts;

  bool get getAcceptCall => acceptCalls;
  void setAcceptCall(state) {
    acceptCalls = state;
    notifyListeners();
  }

  int get duration => callDuration;

  void startCallDuration() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      callDuration++;
      notifyListeners();
      if (callStatus != 3) {
        // callDuration = 0;
        timer.cancel();
      }
    });
  }

  void resetDuration() {
    callDuration = 0;
  }

  int get getCallStatus => callStatus;

  void setCallStatus(state) {
    callStatus = state ?? 0;
    notifyListeners();
  }

  void resetCallInitTimeout() {
    callInitTimeOut = 15;
  }

  void setStopTimer() {
    stopTimer = true;
    notifyListeners();
  }

  void startCallTimeout() {
    log("timer started");
    Timer.periodic(Duration(seconds: 1), (timer) {
      callInitTimeOut--;
      if (callInitTimeOut < 1) notifyListeners();
      if (!acceptCalls || stopTimer) {
        timer.cancel();
        stopTimer = false;
        log("timer stopped");
      }
    });
  }

  int get callTimeout => callInitTimeOut;

  void resetAllCallingVariables() {
    acceptCalls = true;
    callDuration = 0;
    callInitTimeOut = 15;
    stopTimer = false;
    callStatus = 0;
    notifyListeners();
  }

  get getTerminateCall => terminateCall;
  void setTerminateCall(state) {
    terminateCall = state ?? true;
    notifyListeners();
  }

  void updateOrderState({ordId, ordState, orderState}) {
    for (int i = 0; i < chatList.length; i++) {
      if (chatList[i]['ordId'].toString() == ordId.toString()) {
        chatList[i]['orderDetails']['ordState'] = ordState;
        chatList[i]['orderDetails']['orderState'] = orderState;
      }
    }
    notifyListeners();
  }

  void revealProfile(bool state, msgId, pId) {
    int index = chatList.indexWhere(
        (element) => element['msgId'].toString() == msgId.toString());
    if (index < 0) return;
    if (state)
      chatList[index]['orderDetails']['revealProfileTo'].add(pId.toString());
    else
      chatList[index]['orderDetails']['revealProfileTo'].remove(pId.toString());
    notifyListeners();
  }
}
