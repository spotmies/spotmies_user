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
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';
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
          // if (data.loader) return Center(child: profileShimmer(context));
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
                              // height: _hight * 0.27,
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
                                                  )),
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        _responsiveController
                                                            .deleteResponse(
                                                                responseData[
                                                                        'responseId']
                                                                    .toString());
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_sweep,
                                                        color: Colors.red,
                                                        size: _width * 0.056,
                                                      )),
                                                ),
                                              )
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
            ProgressWaiter(contextt: context, loaderState: data.loader)
          ]);
        }));
  }
}
