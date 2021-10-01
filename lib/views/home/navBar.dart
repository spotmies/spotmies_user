import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/chat_list_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/notifications.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/home/ads/adpost.dart';
import 'package:spotmies/views/home/home.dart';
import 'package:spotmies/views/chat/chat_tab.dart';
import 'package:spotmies/views/internet_calling/calling.dart';
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
  ResponsesProvider responseProvider;
  GetOrdersProvider ordersProvider;
  UserDetailsProvider profileProvider;

  UniversalProvider universalProvider;
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

  hitAllApis() async {
    dynamic responsesList = await getResponseListFromDB();
    responseProvider.setResponsesList(responsesList);

    dynamic user = await getUserDetailsFromDB();
    profileProvider.setUser(user);
    ordersProvider.setOrdersList(user['orders'] != null ? user['orders'] : []);
    dynamic chatList = await getChatListFromDb();
    chatProvider.setChatList(chatList);

    dynamic ordersList = await getOrderFromDB();
    ordersProvider.setOrdersList(ordersList);
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
      var typeCheck = socket['target']['type'];
      if (typeCheck == "call") {
        log("======== incoming call ===========");
        // notification part
        chatProvider.startCallTimeout();
        var newTarget = socket['target'];
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyCalling(
                uId: newTarget['uId'],
                pId: newTarget['pId'],
                msgId: newTarget['msgId'],
                ordId: newTarget['ordId'],
                name: newTarget['incomingName'],
                profile: newTarget['incomingProfile'],
                isIncoming: true,
                roomId: newTarget['roomId'])));
      }

      _chatResponse.add(socket);
      universalProvider.setChatBadge();
    });
    socket.on("recieveReadReciept", (data) {
      chatProvider.chatReadReceipt(data['msgId'], data['status']);
    });
    socket.on("newResponse", (data) {
      responseProvider.addNewResponse(data);
      if (data['isAccepted']) {
        snackbar(context, "Accepted your request visit my order for more info");
      }
    });
  }

  @override
  initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      String token = value;
      log(token.toString());
    });
    //notifications
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final routefromMessage = message.data["route"];
      log(routefromMessage);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    });
    //forground
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
        LocalNotificationService.display(message);
      }
    });
    // when app background but in recent
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final routefromMessage = message.data["route"];
      log(routefromMessage);
      LocalNotificationService.display(message);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    });

    super.initState();
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);
    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);

    hitAllApis();

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
      if (chatProvider.getReadReceipt().length > 0) {
        log("readReceipt evewnt");
        socket.emit("sendReadReciept", chatProvider.getReadReceipt()[0]);
        chatProvider.setReadReceipt("clear");
      }

      if (newMessageObject.length > 0) {
        log("sending $newMessageObject");
        chatProvider.setReadyToSend(false);
        for (int i = 0; i < newMessageObject.length; i++) {
          log("i is $i");
          var payLoad = newMessageObject[i];
          socket.emitWithAck(newMessageObject[i]['socketName'], payLoad,
              ack: (var callback) {
            if (callback == 'success') {
              print('working Fine');
              switch (payLoad['socketName']) {
                case "sendNewMessageCallback":
                  if (i == newMessageObject.length - 1) {
                    var msgId = payLoad['target']['msgId'];
                    log("clear msg queue $msgId !!!!");
                    if (msgId == null || msgId == "" || msgId.isEmpty) {
                      log("empty msg id $msgId");
                      chatProvider.clearMessageQueue2();
                    } else {
                      log("proper msg id $msgId");
                      chatProvider.clearMessageQueue(msgId);
                    }
                  }
                  break;
                case "chatStream":
                  if (i == newMessageObject.length - 1) {
                    log("clear queue");
                    chatProvider.clearMessageQueue2();
                  }
                  if (payLoad['type'] == "disable") {
                    chatProvider.disableChatByMsgId(payLoad['msgId']);
                  } else if (payLoad['type'] == "delete") {
                    chatProvider.deleteChatByMsgId(payLoad['msgId']);
                  }
                  break;
                default:
              }
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
    log("redering nav bars");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<UniversalProvider>(
        builder: (context, data, child) {
          return Scaffold(
            body: Container(
              // color: Colors.amber,
              width: double.infinity,
              height: double.infinity,
              child: _widgetOptions.elementAt(data.getCurrentPage),
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
                          if (index == 1)
                            Positioned(
                                right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: data.getChatBadge
                                      ? Colors.indigo[800]
                                      : Colors.transparent,
                                ))
                        ],
                      ),
                    ],
                  );
                },
                backgroundColor: Colors.white,
                activeIndex: data.getCurrentPage,
                splashColor: Colors.grey[200],
                splashSpeedInMilliseconds: 300,
                notchSmoothness: NotchSmoothness.softEdge,
                gapLocation: GapLocation.center,
                leftCornerRadius: 32,
                rightCornerRadius: 32,
                onTap: (index) {
                  data.setCurrentPage(index);
                }),
            floatingActionButton: FloatingActionButton(
              elevation: 8,
              backgroundColor: Colors.indigo[800],
              child: Icon(Icons.engineering, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PostAd()));
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
