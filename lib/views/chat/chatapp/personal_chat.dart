import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/views/reusable_widgets/chat_input_field.dart';
import 'package:spotmies/views/reusable_widgets/date_formates.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PersonalChat extends StatefulWidget {
  final String msgId;
  PersonalChat(this.msgId);
  @override
  _PersonalChatState createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  ChatProvider chatProvider;
  ScrollController _scrollController = ScrollController();
  List chatList = [];
  Map targetChat = {};
  Map partner = {};
  int msgCount = 20;
  void scrollToBottom() {
    Timer(
        Duration(milliseconds: 200),
        () => _scrollController
            .jumpTo(_scrollController.position.minScrollExtent));
  }

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // log("at top >>>");
        chatProvider.setMsgCount(chatProvider.getMsgCount() + 20);
      }
      if (_scrollController.position.pixels < 40) {
        // log('disable float >>>>>>>>>>>>');
        if (chatProvider.getFloat()) chatProvider.setFloat(false);
      } else if (_scrollController.position.pixels > 40) {
        if (!chatProvider.getFloat()) {
          chatProvider.setFloat(true);
          // log('en float >>>>>>>>>>>>');
        }
      }
    });
  }

  getTargetChat(list, msgId) {
    List currentChatData = list.where((i) => i['msgId'] == msgId).toList();

    return currentChatData[0];
  }

  sendMessageHandler(value) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, String> msgData = {
      'msg': value.toString(),
      'time': timestamp,
      'sender': 'user',
      'type': 'text'
    };
    Map<String, dynamic> target = {
      'pId': targetChat['pId'],
      // 'uId': "FtaZm2dasvN7cL9UumTG98ksk6I3",
      'uId': FirebaseAuth.instance.currentUser.uid,
      'msgId': widget.msgId,
      'ordId': targetChat['ordId'],
      // 'ordId': "2"
    };
    Map<String, Object> sendPayload = {
      "object": jsonEncode(msgData),
      "target": target
    };
    chatProvider.addnewMessage(sendPayload);
    chatProvider.setSendMessage(sendPayload);
    // scrollToBottom();
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

  @override
  Widget build(BuildContext context) {
    log("======== render chat screen =============");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: _buildAppBar(context, _hight, _width),
        body: Container(
          child: Column(children: [
            Expanded(
              child: Container(
                child: Consumer<ChatProvider>(
                  builder: (context, data, child) {
                    chatList = data.getChatList2();
                    targetChat = getTargetChat(chatList, widget.msgId);
                    partner = targetChat['uDetails'];
                    List messages = targetChat['msgs'];
                    // if (data.getScroll() || !data.getScroll()) scrollToBottom();
                    return ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: data.getMsgCount() < messages.length
                            ? data.getMsgCount()
                            : messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map rawMsgDataprev = jsonDecode(
                              messages[(messages.length - 1) - (index + 1)]);
                          Map rawMsgData = jsonDecode(
                              messages[(messages.length - 1) - index]);
                          String message = rawMsgData['msg'];
                          String sender = rawMsgData['sender'];
                          String type = rawMsgData['type'];

                          return Container(
                            padding: EdgeInsets.only(
                                left: sender != "user" ? 10 : 0,
                                bottom: 5,
                                right: sender != "user" ? 0 : 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: sender != "user"
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              minHeight: _hight * 0.05,
                                              minWidth: 30,
                                              maxWidth: _width * 0.50),
                                          decoration: BoxDecoration(
                                              color: sender != "user"
                                                  ? Colors.white
                                                  : Colors.blueGrey[500],
                                              border: Border.all(
                                                  color: Colors.blueGrey[500],
                                                  width: 0.3),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomRight: Radius.circular(
                                                      sender != "user"
                                                          ? 15
                                                          : 0),
                                                  bottomLeft: Radius.circular(
                                                      sender == "user"
                                                          ? 15
                                                          : 0))),
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      top: 10,
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: type == "text"
                                                      ? TextWid(
                                                          text:
                                                              toBeginningOfSentenceCase(
                                                                  message),
                                                          maxlines: 200,
                                                          lSpace: 1.5,
                                                          color: sender ==
                                                                  "user"
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[900],
                                                        )
                                                      : type != "audio"
                                                          ? Image.network(
                                                              message)
                                                          : type != "video"
                                                              ? Text('audio')
                                                              : Text('video')),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 10, top: 5),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextWid(
                                                  text: getTime(
                                                      rawMsgData['time']),
                                                  size: _width * 0.03,
                                                  color: sender == "user"
                                                      ? Colors.grey[50]
                                                      : Colors.grey[500],
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //

                                        Visibility(
                                          visible:
                                              index == 0 && sender == "user",
                                          child: readReciept(
                                              _width, targetChat['uState']),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: dateCompare(rawMsgData['time'],
                                          rawMsgDataprev['time']) !=
                                      "false",
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[900],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.only(
                                              right: 20,
                                              left: 20,
                                              top: 7,
                                              bottom: 7),
                                          alignment: Alignment.center,
                                          child: TextWid(
                                            text: dateCompare(
                                                rawMsgData['time'],
                                                rawMsgDataprev['time']),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
            chatInputField(sendMessageHandler, context, _hight, _width)
          ]),
        ),
        floatingActionButton: Container(
          height: _hight * 0.2,
          padding: EdgeInsets.only(bottom: _hight * 0.1),
          child: Consumer<ChatProvider>(
            builder: (context, data, child) {
              return data.getFloat()
                  ? FloatingActionButton(
                      elevation: 0,
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        scrollToBottom();

                        // _scrollController
                        //     .jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue[900],
                        size: _width * 0.07,
                      ),
                    )
                  : Container();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Container readReciept(double _width, status) {
    getIcon() {
      switch (status) {
        case 0:
          return Icons.watch_later;
        case 1:
          return Icons.done;
        case 2:
        case 3:
          return Icons.done_all;

          break;
        default:
          return Icons.done;
      }
    }

    return Container(
        padding: EdgeInsets.only(right: 5),
        alignment: Alignment.centerRight,
        child: Icon(
          getIcon(),
          // Icons.done,
          // Icons.done_all,
          // Icons.watch_later,
          color: status == 3 ? Colors.blue : Colors.grey[400],
          size: _width * 0.05,
        ));
  }

  Widget _buildAppBar(BuildContext context, double hight, double width) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[50],
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.read_more,
            color: Colors.grey[900],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.phone,
            color: Colors.grey[900],
          ),
        ),
      ],
      title: Consumer<ChatProvider>(
        builder: (context, data, child) {
          chatList = data.getChatList2();
          targetChat = getTargetChat(chatList, widget.msgId);
          partner = targetChat['pDetails'];
          return Row(
            children: [
              ProfilePic(
                name: partner['name'],
                profile: partner['pic'],
                status: false,
                bgColor: Colors.blueGrey[600],
                size: width * 0.045,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: TextWid(
                text: partner['name'] ?? "Spotmies User",
                size: width * 0.058,
                weight: FontWeight.w600,
              )
                  // Text(
                  //   user['name'] ?? "Unknown",
                  //   maxLines: 1,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
