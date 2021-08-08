import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/getResponseProvider.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/chat/partnerDetailsSummery.dart';

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
              // if (snapshot.data != null) res.add(snapshot.data);
              return Consumer<GetResponseProvider>(
                  builder: (context, data, child) {
                // if (data.local == null)
                //   return Center(child: CircularProgressIndicator());
                res = data.local;
                // var p = res[0]['pDetails'];
                // var r = textedit();
                return Container(
                  child: ListView.builder(
                      // itemCount: r.length,
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      // padding: EdgeInsets.all(20),
                      itemBuilder: (BuildContext ctxt, int index) {
                        //String msgid = document['msgid'];
                        // o['orderState'] == null
                        //     ? _responsiveController.shownotification()
                        //     : print('object');
                        return Column(
                          children: [
                            Container(
                              width: _width * 0.9,
                              height: _hight * 0.1,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.indigo[900],
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: Offset(0, -4))
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: _width * 0.055,
                                            right: _width * 0.055),
                                        // color: Colors.amber,
                                        height: _hight * 0.1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWid(
                                              text: 'Electrician',
                                              // text: _responsiveController.jobs
                                              //         .elementAt(r[index]
                                              //                 ['orderDetails']
                                              //             ['job'])
                                              //         .toString() +
                                              //     ' | ',
                                              weight: FontWeight.w500,
                                              color: Colors.white54,
                                              size: _width * 0.035,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    child: Icon(
                                                  Icons.schedule_outlined,
                                                  color: Colors.grey[200],
                                                )),
                                                Container(
                                                  child: TextWid(
                                                    text:
                                                        " 12 july 2021, 1pm - 6pm",
                                                    weight: FontWeight.bold,
                                                    color: Colors.grey[200],
                                                    size: _width * 0.045,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 30),
                                        // color: Colors.amber,
                                        child: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.more_horiz,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: _width * 0.9,
                              padding: EdgeInsets.all(_width * 0.03),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: Offset(0, 4))
                                  ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      // color: Colors.amber,
                                      child: Container(
                                        height: _width * 0.14,
                                        width: _width * 0.16,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: _width * 0.3,
                                            padding: EdgeInsets.all(10),
                                            child: TextWid(
                                              text: "Louis Peterson",
                                              weight: FontWeight.w600,
                                              size: _width * 0.045,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          Container(
                                            width: _width * 0.15,
                                            child: TextWid(
                                              text: "₹ 1500",
                                              weight: FontWeight.w600,
                                              size: _width * 0.040,
                                              color: Colors.grey[700],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                          onPressed: () {
                                            partnerDetailsSummury(
                                                context, _hight, _width);
                                          },
                                          icon: Icon(
                                            Icons.info_rounded,
                                            color: Colors.grey[300],
                                          )),
                                    ),
                                  ]),
                            ),
                            Container(
                              width: _width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButtonWidget(
                                      minWidth: _width * 0.3,
                                      height: _hight * 0.05,
                                      buttonName: 'Decline',
                                      textColor: Colors.grey,
                                      bgColor: Colors.grey[300],
                                      borderRadius: 15.0,
                                      textSize: _width * 0.04,
                                      borderSideColor: Colors.grey[300],
                                      onClick: () {},
                                    ),
                                    ElevatedButtonWidget(
                                      minWidth: _width * 0.3,
                                      height: _hight * 0.05,
                                      buttonName: 'Accept',
                                      textColor: Colors.white,
                                      bgColor: Colors.indigo[900],
                                      borderRadius: 15.0,
                                      textSize: _width * 0.04,
                                      borderSideColor: Colors.indigo[900],
                                      onClick: () {},
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






 // InkWell(
                              //   onTap: () {
                              //     // Navigator.of(context).push(MaterialPageRoute(
                              //     //   builder: (context) => ChatScreen(value: msgid),
                              //     // ));
                              //     // CircularProgressIndicator();
                              //     // FirebaseFirestore.instance
                              //     //     .collection('messaging')
                              //     //     .doc(document['msgid'])
                              //     //     .update({
                              //     //   'uname': 'name',
                              //     //   'userid': FirebaseAuth.instance.currentUser.uid,
                              //     //   'upic':
                              //     //       'https://images.indulgexpress.com/uploads/user/imagelibrary/2020/1/25/original/MaheshBabuSourceInternet.jpg'
                              //     // });
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.all(10),
                              //     height: _hight * 0.2,
                              //     width: _width * 1,
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(20.0),
                              //         boxShadow: kElevationToShadow[0]),
                              //     child: Row(
                              //       children: [
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //         CircleAvatar(
                              //           backgroundImage:
                              //               // NetworkImage(p['partnerPic']),
                              //               NetworkImage(
                              //                   "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                              //         ),
                              //         SizedBox(
                              //           width: 20,
                              //         ),
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               'Nani',
                              //               // p['name'] == null
                              //               //     ? 'technician'
                              //               //     : p['name'].toString(),
                              //               style: TextStyle(
                              //                   fontSize: 18,
                              //                   decoration:
                              //                       TextDecoration.underline),
                              //             ),
                              //             Row(
                              //               children: [
                              //                 Text("Electrician",
                              //                     // _responsiveController.jobs
                              //                     //         .elementAt(r[index]
                              //                     //                 ['orderDetails']
                              //                     //             ['job'])
                              //                     //         .toString() +
                              //                     //     ' | ',
                              //                     style: TextStyle(fontSize: 8)),
                              //                 Row(
                              //                   children: [
                              //                     Text('4.5',
                              //                         // (_responsiveController.avg(
                              //                         //             p['rate']) /
                              //                         //         20)
                              //                         //     .toString(),
                              //                         style:
                              //                             TextStyle(fontSize: 8)),
                              //                     Icon(
                              //                       Icons.star,
                              //                       size: 8,
                              //                       color: Colors.amber,
                              //                     ),
                              //                   ],
                              //                 )
                              //               ],
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Container(
                              //               width: _width * 0.635,
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.spaceEvenly,
                              //                 children: [
                              //                   Container(
                              //                     width: _width * 0.3,
                              //                     height: _hight * 0.05,
                              //                     child: Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text('Money :   ',
                              //                             // +
                              //                             //     r[index]['money']
                              //                             //         .toString(),
                              //                             style: TextStyle(
                              //                                 fontSize:
                              //                                     _width * 0.02)),
                              //                         // SizedBox(
                              //                         //   width: 60,
                              //                         // ),
                              //                         Text(
                              //                           'Away :   ',
                              //                           //  +
                              //                           //     r[index]['loc']
                              //                           //         .toString() +
                              //                           //     'KM',
                              //                           style: TextStyle(
                              //                               fontSize:
                              //                                   _width * 0.02),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                   Container(
                              //                     width: _width * 0.3,
                              //                     height: _hight * 0.05,
                              //                     child: Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text('Time :   ',
                              //                             // +
                              //                             //     r[index]['schedule']
                              //                             //         .toString(),
                              //                             style: TextStyle(
                              //                                 fontSize:
                              //                                     _width * 0.02)),
                              //                         Text('Date :   ',
                              //                             // +
                              //                             //     r[index]['schedule']
                              //                             //         .toString(),
                              //                             style: TextStyle(
                              //                                 fontSize:
                              //                                     _width * 0.02))
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Container(
                              //               width: _width * 0.63,
                              //               alignment: Alignment.center,
                              //               child: Text('Tap to chat',
                              //                   style: TextStyle(
                              //                     color: Colors.grey[300],
                              //                   )),
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),