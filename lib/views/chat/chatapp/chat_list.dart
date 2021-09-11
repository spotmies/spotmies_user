import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/chat_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/views/chat/chatapp/personal_chat.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/date_formates.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends StateMVC<ChatList> {
  ChatController _chatController;
  _ChatListState() : super(ChatController()) {
    this._chatController = controller;
  }
  ChatProvider chatProvider;
  @override
  void initState() {
    chatProvider = Provider.of<ChatProvider>(context, listen: false);

    chatProvider.setMsgId("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    print('======render chatList screen =======');
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     title: TextWid(
      //       text: 'My Conversations',
      //       size: _width * 0.045,
      //       weight: FontWeight.w600,
      //     )),
      key: _chatController.scaffoldkey,
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Consumer<ChatProvider>(
                    builder: (context, data, child) {
                      List chatList = data.getChatList2();

                      if (data.getLoader)
                        return Center(child: profileShimmer(context));
                      if (chatList.length < 1) {
                        return Center(
                            child: TextWid(
                          text: "No Chats Available",
                          size: 30,
                        ));
                      }
                      return RefreshIndicator(
                        onRefresh: _chatController.fetchNewChatList,
                        child: ListView.builder(
                          itemCount: chatList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map user = chatList[index]['pDetails'];
                            List messages = chatList[index]['msgs'];
                            int count = chatList[index]['uCount'];
                            log("count $count");

                            var lastMessage = jsonDecode(messages.last);

                            return ChatListCard(
                              user['partnerPic'],
                              user['name'],
                              lastMessage['msg'].toString(),
                              getTime(lastMessage['time']),
                              chatList[index]['msgId'],
                              count,
                              chatList[index]['uId'],
                              chatList[index]['pId'],
                              callBack: _chatController.cardOnClick,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatListCard extends StatefulWidget {
  final String profile;
  final String name;
  final String lastMessage;
  final String time;
  final String msgId;
  final int count;
  final Function callBack;
  final String uId;
  final String pId;
  const ChatListCard(this.profile, this.name, this.lastMessage, this.time,
      this.msgId, this.count, this.uId, this.pId,
      {this.callBack});

  @override
  _ChatListCardState createState() => _ChatListCardState();
}

class _ChatListCardState extends State<ChatListCard> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return ListTile(
        onTap: () async {
          Map readReceiptobject = {
            "uId": widget.uId,
            "pId": widget.pId,
            "msgId": widget.msgId,
            "sender": "user",
            "status": 3
          };
          widget.callBack(widget.msgId, widget.msgId, readReceiptobject);
          //navigate strore msg count value

          final count = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PersonalChat(widget.msgId.toString())));
          log("fback $count");

          widget.callBack(widget.msgId, "", "");
        },
        title: TextWid(
            text: widget.name,
            size: _width * 0.045,
            weight: FontWeight.w600,
            color: widget.count > 0 ? Colors.black : Colors.grey[700]),
        subtitle: TextWid(
            text: widget.lastMessage,
            size: _width * 0.035,
            weight: widget.count > 0 ? FontWeight.w600 : FontWeight.w500,
            color: widget.count > 0 ? Colors.blueGrey[600] : Colors.grey[500]),
        leading: ProfilePic(
          profile: widget.profile,
          name: widget.name,
          bgColor: ([...Colors.primaries]..shuffle()).first,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextWid(
                text: widget.time,
                size: _width * 0.035,
                weight: FontWeight.w600,
                color: widget.count > 0 ? Colors.black : Colors.grey[700]),
            SizedBox(
              height: 10,
            ),
            widget.count > 0
                ? Container(
                    width: _width * 0.1,
                    height: _width * 0.055,
                    margin: EdgeInsets.only(right: _width * 0.035),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30.0)),
                    alignment: Alignment.center,
                    child: Center(
                      child: TextWid(
                          text: widget.count.toString(),
                          size: _width * 0.03,
                          weight: FontWeight.w900,
                          color: Colors.blueGrey[700]),
                    ),
                  )
                : Container(
                    width: 40.0,
                    height: 20.0,
                  ),
          ],
        ));
  }
}
