import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/getResponseProvider.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Responsee extends StatefulWidget {
  @override
  _ResponseeState createState() => _ResponseeState();
}

class _ResponseeState extends StateMVC<Responsee> {
  ResponsiveController _responsiveController;
  _ResponseeState() : super(ResponsiveController()) {
    this._responsiveController = controller;
  }

  StreamController _socketResponse;

  Stream stream;

  textedit() {
    return List.from(res.reversed);
  }

  var res;

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
    socket.on('newResponse', (socket) {
      _socketResponse.add(socket);
    });
  }

  @override
  void initState() {
    super.initState();
    var respons = Provider.of<GetResponseProvider>(context, listen: false);
    _socketResponse = StreamController();

    stream = _socketResponse.stream.asBroadcastStream();
    respons.responseInfo(_socketResponse == null ? false : true);
    socketResponse();
    stream.listen((event) {
      log(event.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    refresh();
    return Scaffold(
        key: _responsiveController.scaffoldkey,
        body: StreamBuilder<Object>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) res.add(snapshot.data);
              return Consumer<GetResponseProvider>(
                  builder: (context, data, child) {
                if (data.local == null)
                  return Center(child: CircularProgressIndicator());
                res = data.local;
                var p = res[0]['pDetails'];
                var r = textedit();
                return Container(
                  child: ListView.builder(
                      itemCount: r.length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (BuildContext ctxt, int index) {
                        //String msgid = document['msgid'];
                        // o['orderState'] == null
                        //     ? _responsiveController.shownotification()
                        //     : print('object');
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => ChatScreen(value: msgid),
                                // ));
                                // CircularProgressIndicator();
                                // FirebaseFirestore.instance
                                //     .collection('messaging')
                                //     .doc(document['msgid'])
                                //     .update({
                                //   'uname': 'name',
                                //   'userid': FirebaseAuth.instance.currentUser.uid,
                                //   'upic':
                                //       'https://images.indulgexpress.com/uploads/user/imagelibrary/2020/1/25/original/MaheshBabuSourceInternet.jpg'
                                // });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: _hight * 0.2,
                                width: _width * 1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: kElevationToShadow[0]),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(p['partnerPic']),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //'Nani',
                                          p['name'] == null
                                              ? 'technician'
                                              : p['name'].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                //"",
                                                _responsiveController.jobs
                                              .elementAt(r[index]['orderDetails']['job'])
                                                
                                                        .toString() +
                                                    ' | ',
                                                style: TextStyle(fontSize: 8)),
                                            Row(
                                              children: [
                                                Text(
                                                    (_responsiveController.avg(
                                                                p['rate']) /
                                                            20)
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 8)),
                                                Icon(
                                                  Icons.star,
                                                  size: 8,
                                                  color: Colors.amber,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: _width * 0.635,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: _width * 0.3,
                                                height: _hight * 0.05,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Money :   ' +
                                                            r[index]['money']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                _width * 0.02)),
                                                    // SizedBox(
                                                    //   width: 60,
                                                    // ),
                                                    Text(
                                                      'Away :   ' +
                                                          r[index]['loc']
                                                              .toString() +
                                                          'KM',
                                                      style: TextStyle(
                                                          fontSize:
                                                              _width * 0.02),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: _width * 0.3,
                                                height: _hight * 0.05,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Time :   ' +
                                                            r[index]['schedule']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                _width * 0.02)),
                                                    Text(
                                                        'Date :   ' +
                                                            r[index]['schedule']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                _width * 0.02))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: _width * 0.63,
                                          alignment: Alignment.center,
                                          child: Text('Tap to chat',
                                              style: TextStyle(
                                                color: Colors.grey[300],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                );
              });
            }));
  }
}

  // return StreamBuilder(
                //   stream: stream,
                //   builder: (context, snapshot) {
                //     // if (!snapshot.hasData) {
                //     //   return Center(
                //     //     child: CircularProgressIndicator(),
                //     //   );
                //     // }
                //     res.add(snapshot.data);
                //     return ListView(
                //       //itemCount: snapshot.data.length,
                //       //itemBuilder: (context, index) {
                //       children: [Text(res.toString())],
                //       // return Text('data');
                //       // Text(
                //       //     "${snapshot.data[index]["name"]} : ${snapshot.data[index]["symbol"]} : ${snapshot.data[index]["current_price"]}");
                //     );
                //   },
                // );



// void connect() {
//     // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
//     socket = IO.io("https://spotmiesserver.herokuapp.com", <String, dynamic>{
//       "transports": ["websocket", "polling", "flashsocket"],
//       "autoConnect": false,
//     });

//     socket.onConnect((data) {
//       print("Connected");
//       socket.on("message", (msg) {
//         print(msg);
//       });
//     });
//     socket.connect();
//     socket.emit('join-room', FirebaseAuth.instance.currentUser.uid);
//     socket.on('newResponse', (socket) {
//       _socketResponse.add(socket);
//       // res.add(socket);
//       log('satish kumar');
//     });

//     print(socket.connected);
//   }
