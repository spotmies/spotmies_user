import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/chat/partnerDetailsSummery.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
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
    // log(_chatController.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    log("======= Render responses page ========");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _responsiveController.scaffoldkey,
        body: Consumer<ResponsesProvider>(builder: (context, data, child) {
          List listResponse = data.getResponsesList;
          if (data.loader) return Center(child: profileShimmer(context));
          if (listResponse.length < 1)
            return Center(
              child: TextWid(
                text: "No Responses",
                size: 30,
              ),
            );
          return Stack(children: [
            Container(
              child: RefreshIndicator(
                onRefresh: _responsiveController.fetchNewResponses,
                color: Colors.white,
                backgroundColor: Colors.indigo[900],
                child: ListView.builder(
                    itemCount: listResponse.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (BuildContext ctxt, int index) {
                      var responseData = listResponse[index];
                      var ord = responseData['orderDetails'];
                      var pDetails = responseData['pDetails'];
                      var uDetails = responseData['uDetails'];
                      log(uDetails.toString());

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              partnerDetailsSummury(
                                  context,
                                  _hight,
                                  _width,
                                  pDetails,
                                  _responsiveController,
                                  responseData,
                                  chatWithPatner, onClick: () {
                                // Navigator.of(context).psu
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PostOverView(
                                          ordId:
                                              responseData['ordId'].toString(),
                                        )));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              height: _hight * 0.27,
                              width: _width * 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 2,
                                        spreadRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: _hight * 0.1,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[50],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              text: _responsiveController.jobs
                                                  .elementAt(ord['job']),
                                              color: Colors.indigo[900],
                                              size: _width * 0.035,
                                              weight: FontWeight.w500,
                                              lSpace: 0.2,
                                            ),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.more_horiz,
                                                  size: _width * 0.06,
                                                  color: Colors.indigo[900],
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: _width * 0.015,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              color: Colors.indigo[900],
                                              size: _width * 0.045,
                                            ),
                                            SizedBox(
                                              width: _width * 0.015,
                                            ),
                                            TextWidget(
                                              text: getDate(ord['schedule']) +
                                                  ' - ' +
                                                  getTime(ord['schedule']),
                                              color: Colors.indigo[900],
                                              weight: FontWeight.w600,
                                              size: _width * 0.045,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            pDetails['partnerPic'],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width * 0.35,
                                        child: TextWidget(
                                          text: ord['problem'],
                                          flow: TextOverflow.visible,
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            responseData['money'] != null ||
                                                ord['money'] != null,
                                        child: Container(
                                          // width: _width * 0.08,
                                          child: TextWidget(
                                            text:
                                                "₹ ${responseData['money'] ?? ord['money']}",
                                            flow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.info,
                                            color: Colors.grey,
                                            size: _width * 0.05,
                                          ))
                                    ],
                                  ),
                                  responseData['isAccepted']
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green[700],
                                                  size: _width * 0.056,
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: TextWid(
                                                    text:
                                                        "Partner accepted your order",
                                                    size: _width * 0.04,
                                                    weight: FontWeight.bold,
                                                  ))
                                            ])
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButtonWidget(
                                              minWidth: _width * 0.3,
                                              height: _hight * 0.045,
                                              bgColor: Colors.indigo[50],
                                              buttonName: 'Decline',
                                              textColor: Colors.grey[900],
                                              borderRadius: 15.0,
                                              textSize: _width * 0.04,
                                              borderSideColor:
                                                  Colors.indigo[50],
                                              onClick: () {
                                                _responsiveController
                                                    .acceptOrRejectResponse(
                                                        responseData, "reject");
                                              },
                                            ),
                                            ElevatedButtonWidget(
                                              minWidth: _width * 0.5,
                                              height: _hight * 0.045,
                                              bgColor: Colors.indigo[900],
                                              buttonName: 'Accept',
                                              textColor: Colors.white,
                                              borderRadius: 15.0,
                                              textSize: _width * 0.04,
                                              borderSideColor:
                                                  Colors.indigo[900],
                                              onClick: () {
                                                _responsiveController
                                                    .acceptOrRejectResponse(
                                                        responseData, "accept");
                                              },
                                            )
                                          ],
                                        )
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
            ),
            // Visibility(
            //   visible: data.loader,
            //   child: Positioned.fill(
            //       child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
            //     child: Center(child: CircularProgressIndicator()),
            //   )),
            // ),
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





// Container(
//                                             width: _width * 0.63,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Visibility(
//                                                   visible: responseData[
//                                                       'isAccepted'],
//                                                   child: Container(
//                                                       child: TextWid(
//                                                           text:
//                                                               "Partner accepted you service request")),
//                                                 ),
//                                                 Visibility(
//                                                   visible: !responseData[
//                                                       'isAccepted'],
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       _responsiveController
//                                                           .acceptOrRejectResponse(
//                                                               responseData,
//                                                               "reject");
//                                                     },
//                                                     child: Container(
//                                                       // width: _width * 0.63,
//                                                       alignment:
//                                                           Alignment.center,
//                                                       child: Text('Reject',
//                                                           style: TextStyle(
//                                                             color: Colors
//                                                                 .grey[300],
//                                                           )),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Visibility(
//                                                   visible: !responseData[
//                                                       'isAccepted'],
//                                                   child: InkWell(
//                                                     onTap: () {
                                                      // _responsiveController
                                                      //     .acceptOrRejectResponse(
                                                      //         responseData,
                                                      //         "accept");
//                                                     },
//                                                     child: Container(
//                                                       // width: _width * 0.63,
//                                                       alignment:
//                                                           Alignment.center,
//                                                       child: Text('Accept',
//                                                           style: TextStyle(
//                                                             color: Colors
//                                                                 .grey[300],
//                                                           )),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     chatWithPatner(
//                                                         responseData);
//                                                   },
//                                                   child: Container(
//                                                     // width: _width * 0.63,
//                                                     alignment: Alignment.center,
//                                                     child: Text('Tap to chat',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Colors.grey[300],
//                                                         )),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           IconButton(
//                                             onPressed: () {
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           MyCalling(
//                                                             ordId: responseData[
//                                                                     'ordId']
//                                                                 .toString(),
//                                                             uId: FirebaseAuth
//                                                                 .instance
//                                                                 .currentUser
//                                                                 .uid
//                                                                 .toString(),
//                                                             pId: responseData[
//                                                                     'pId']
//                                                                 .toString(),
//                                                             isIncoming: false,
//                                                             name:
//                                                                 pDetails['name']
//                                                                     .toString(),
//                                                             profile: pDetails[
//                                                                     'partnerPic']
//                                                                 .toString(),
//                                                           )));
//                                             },
//                                             icon: Icon(
//                                               Icons.phone,
//                                               color: Colors.grey[900],
//                                             ),
//                                           ),