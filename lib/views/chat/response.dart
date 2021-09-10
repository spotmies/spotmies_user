import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';

import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class Responsee extends StatefulWidget {
  @override
  _ResponseeState createState() => _ResponseeState();
}

class _ResponseeState extends StateMVC<Responsee> {
  ResponsiveController _responsiveController;
  ResponsesProvider responseProvider;
  _ResponseeState() : super(ResponsiveController()) {
    this._responsiveController = controller;
  }

  void chatWithPatner(responseData) {
    //need display circular indicator with z index
    _responsiveController.chatWithpatner(responseData);
  }

  @override
  void initState() {
    super.initState();

    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    log("======= Render responses page ========");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    // refresh();
    return Scaffold(
        key: _responsiveController.scaffoldkey,
        body: Consumer<ResponsesProvider>(builder: (context, data, child) {
          List listResponse = data.getResponsesList;
          return Stack(children: [
            Container(
              child: ListView.builder(
                  itemCount: listResponse.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(20),
                  itemBuilder: (BuildContext ctxt, int index) {
                    var responseData = listResponse[index];
                    var ord = responseData['orderDetails'];
                    var pDetails = responseData['pDetails'];

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {},
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
                                      NetworkImage(pDetails['partnerPic']),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pDetails['name'] == null
                                          ? 'technician'
                                          : pDetails['name'].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          decoration: TextDecoration.underline),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            //"",
                                            _responsiveController.jobs
                                                    .elementAt(ord['job'])
                                                    .toString() +
                                                ' | ',
                                            style: TextStyle(fontSize: 8)),
                                        Row(
                                          children: [
                                            Text("",
                                                // (_responsiveController.avg(
                                                //             pDetails['rate']) /
                                                //         20)
                                                //     .toString(),
                                                style: TextStyle(fontSize: 8)),
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
                                                        responseData['money']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            _width * 0.02)),
                                                // SizedBox(
                                                //   width: 60,
                                                // ),
                                                Text(
                                                  'Away :   ' +
                                                      responseData['loc']
                                                          .toString() +
                                                      'KM',
                                                  style: TextStyle(
                                                      fontSize: _width * 0.02),
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
                                                        responseData['schedule']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            _width * 0.02)),
                                                Text(
                                                    'Date :   ' +
                                                        responseData['schedule']
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible: responseData['isAccepted'],
                                            child: Container(
                                                child: TextWid(
                                                    text:
                                                        "Partner accepted you service request")),
                                          ),
                                          Visibility(
                                            visible:
                                                !responseData['isAccepted'],
                                            child: InkWell(
                                              onTap: () {
                                                _responsiveController
                                                    .acceptOrRejectResponse(
                                                        responseData, "reject");
                                              },
                                              child: Container(
                                                // width: _width * 0.63,
                                                alignment: Alignment.center,
                                                child: Text('Reject',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                !responseData['isAccepted'],
                                            child: InkWell(
                                              onTap: () {
                                                _responsiveController
                                                    .acceptOrRejectResponse(
                                                        responseData, "accept");
                                              },
                                              child: Container(
                                                // width: _width * 0.63,
                                                alignment: Alignment.center,
                                                child: Text('Accept',
                                                    style: TextStyle(
                                                      color: Colors.grey[300],
                                                    )),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              chatWithPatner(responseData);
                                            },
                                            child: Container(
                                              // width: _width * 0.63,
                                              alignment: Alignment.center,
                                              child: Text('Tap to chat',
                                                  style: TextStyle(
                                                    color: Colors.grey[300],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
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
            ),
            Visibility(
              visible: data.loader,
              child: Positioned.fill(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                child: Center(child: CircularProgressIndicator()),
              )),
            ),
          ]);
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
