import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/chat_list_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/views/home/ads/ad.dart';
import 'package:spotmies/views/home/home.dart';
import 'package:spotmies/views/chat/chat_tab.dart';
import 'package:spotmies/views/posts/posts.dart';
import 'package:spotmies/views/profile/profile.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() => runApp(GoogleNavBar());

class GoogleNavBar extends StatefulWidget {
  @override
  _GoogleNavBarState createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  ChatProvider chatProvider;
  int _selectedIndex = 0;

  List icons = [
    Icons.home,
    Icons.chat,
    Icons.home_repair_service,
    Icons.person
  ];
  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Home(),
    ),
    Center(
      child: Chat(),
    ),
    Center(
      child: PostList(),
    ),
    Center(
      child: Profile(),
    ),
  ];

  setBottomBarIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getChatList() async {
    var chatList = await getChatListFromDb();
    // log('chatlist $chatList ');
    chatProvider.setChatList(chatList);
  }

  StreamController _chatResponse;

  Stream stream;

  IO.Socket socket;

  void socketResponse() {
    socket = IO.io("https://spotmiesserver.herokuapp.com", <String, dynamic>{
      "transports": ["websocket", "polling", "flashsocket"],
      "autoConnect": false,
    });
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
      });
    });
    socket.connect();
    socket.emit('join-room', FirebaseAuth.instance.currentUser.uid);
    socket.on('recieveNewMessage', (socket) {
      _chatResponse.add(socket);
    });
    socket.on("chatReadReceipt", (data) {
      chatProvider.chatReadReceipt(data['object']['msgId']);
    });
  }

  @override
  initState() {
    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    getChatList();

    _chatResponse = StreamController();

    stream = _chatResponse.stream.asBroadcastStream();

    socketResponse();
    stream.listen((event) {
      chatProvider.addnewMessage(event);
    });

    chatProvider.addListener(() {
      log("event");
      var newMessageObject = chatProvider.newMessagetemp();
      if (chatProvider.getReadyToSend() == false) {
        log(chatProvider.getReadyToSend().toString());
        return;
      }

      if (newMessageObject.length > 0) {
        log("sending");
        chatProvider.setReadyToSend(false);
        for (int i = 0; i < newMessageObject.length; i++) {
          var item = newMessageObject[i];

          log("new msg $item");
          socket.emitWithAck('sendNewMessageCallback', item,
              ack: (var callback) {
            if (callback == 'success') {
              print('working Fine');
              if (i == newMessageObject.length - 1) {
                log("clear msg queue");
                var msgId = item['target']['msgId'];
                chatProvider.clearMessageQueue(msgId);
              }
              // chatProvider.addnewMessage(item);
            } else {
              log('notSuccess');
            }
          });
        }
        log("loop end");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          // color: Colors.amber,
          width: double.infinity,
          height: double.infinity,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: icons.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.grey[800] : Colors.grey;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Icon(
                      icons[index],
                      size: 24,
                      color: color,
                    ),
                   if(index==1) Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(radius: 4,backgroundColor: Colors.greenAccent,))
                  ],
                ),
              ],
            );
          },
          backgroundColor: Colors.white,
          activeIndex: _selectedIndex,
          splashColor: Colors.grey[200],
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          backgroundColor: Colors.indigo[800],
          child: Icon(Icons.engineering, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostAd()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
