import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/responsive_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/chat/partnerDetailsSummery.dart';
import 'package:spotmies/views/home/data.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class Responsee extends StatefulWidget {
  @override
  _ResponseeState createState() => _ResponseeState();
}

class _ResponseeState extends StateMVC<Responsee> {
  ResponsiveController? _responsiveController = ResponsiveController();
  ResponsesProvider? responseProvider;
  UniversalProvider? up;
  ChatProvider? chatProvider;
  UserDetailsProvider? profileProvider;
  GetOrdersProvider? ordersProvider;

  List postMenuOptions = [
    {
      "name": "View",
      "icon": Icons.remove_red_eye,
    },
    {"name": "Store", "icon": Icons.engineering},
    {
      "name": "Close",
      "icon": Icons.close,
    },
  ];

  void chatWithPatner(responseData) {
    _responsiveController?.chatWithpatner(
        responseData, context, responseProvider, chatProvider);
  }

  @override
  void initState() {
    super.initState();
    up = Provider.of<UniversalProvider>(context, listen: false);

    responseProvider = Provider.of<ResponsesProvider>(context, listen: false);

    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    up?.setCurrentConstants("responses");
    //address

    responseProvider?.addListener(() {
      if ((responseProvider?.acceptOrRejectResponsesQueue.length)! > 0) {
        dynamic queueData = responseProvider?.acceptOrRejectResponsesQueue[0];
        dynamic targetResponse = responseProvider?.getResponseByordIdAndPid(
            ordId: queueData['ordId'], pId: queueData['pId']);
        log("targetresp $targetResponse  $queueData");
        if (targetResponse == null) {
          snackbar(context, "something went wrong");
          log("something went wrong");
          responseProvider?.resetResponsesQueue();
          return;
        }
        responseProvider?.resetResponsesQueue();
        _responsiveController?.acceptOrRejectResponse(
            targetResponse,
            queueData['responseType'],
            context,
            responseProvider,
            profileProvider,
            chatProvider,
            ordersProvider);
      }
      ;
    });

    // log(_chatController.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    log("======= Render responses page ========");
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: SpotmiesTheme.background,
        key: _responsiveController?.scaffoldkey,
        body: Consumer<ResponsesProvider>(builder: (context, data, child) {
          List listResponse = data.getResponsesList;
          // if (data.loader) return Center(child: profileShimmer(context));
          // if (listResponse.length < 1)
          //   return Center(
          //     child: TextWid(
          //       text: up?.getText("no_responses"),
          //       size: width(context) * 0.045,
          //     ),
          //   );
          // log(listResponse[0]["partnerPic"].toString());
          return Stack(children: [
            Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _responsiveController?.fetchNewResponses(
                      context, responseProvider);
                },
                color: SpotmiesTheme.primary,
                backgroundColor: SpotmiesTheme.dull,
                child: listResponse.length > 0
                    ? ListView.builder(
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PostOverView(
                                            ordId: responseData['ordId']
                                                .toString(),
                                          )));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  // height: height(context) * 0.27,

                                  width: width(context) * 1,
                                  decoration: BoxDecoration(
                                      color: SpotmiesTheme.surfaceVariant,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: SpotmiesTheme.shadow,
                                            blurRadius: 2,
                                            spreadRadius: 2)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height(context) * 0.1,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          color: SpotmiesTheme.surfaceVariant2,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  text: _responsiveController
                                                      ?.jobs
                                                      .elementAt(ord['job']),
                                                  color: SpotmiesTheme
                                                      .onBackground,
                                                  size: width(context) * 0.035,
                                                  weight: FontWeight.w500,
                                                  lSpace: 0.2,
                                                ),
                                                IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                    onPressed: () {
                                                      bottomOptionsMenu(
                                                        context,
                                                        menuTitle:
                                                            'More options',
                                                        option1Click: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PostOverView(
                                                                            ordId:
                                                                                responseData['ordId'].toString(),
                                                                          )));
                                                        },
                                                        option2Click: () {
                                                          partnerDetailsSummury(
                                                              context,
                                                              height(context),
                                                              width(context),
                                                              pDetails,
                                                              _responsiveController!,
                                                              responseData,
                                                              chatWithPatner,
                                                              onClick: () {
                                                            // Navigator.of(context).psu
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PostOverView(
                                                                              ordId: responseData['ordId'].toString(),
                                                                            )));
                                                          });
                                                        },
                                                        options:
                                                            postMenuOptions,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.more_horiz,
                                                      size:
                                                          width(context) * 0.06,
                                                      color: SpotmiesTheme
                                                          .onBackground,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: width(context) * 0.015,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.schedule,
                                                  color: SpotmiesTheme
                                                      .onBackground,
                                                  size: width(context) * 0.045,
                                                ),
                                                SizedBox(
                                                  width: width(context) * 0.015,
                                                ),
                                                TextWidget(
                                                  text: getDate(
                                                          ord['schedule']) +
                                                      ' - ' +
                                                      getTime(ord['schedule']),
                                                  color: SpotmiesTheme
                                                      .onBackground,
                                                  weight: FontWeight.w600,
                                                  size: width(context) * 0.045,
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
                                            child: pDetails == null
                                                ? Icon(Icons.engineering)
                                                : CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      pDetails['partnerPic'],
                                                    ),
                                                  ),
                                          ),
                                          Container(
                                            width: width(context) * 0.35,
                                            child: TextWidget(
                                              text: ord['problem'],
                                              flow: TextOverflow.visible,
                                              color: SpotmiesTheme.onBackground,
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                responseData['money'] != null ||
                                                    ord['money'] != null,
                                            child: Container(
                                              // width: width(context) * 0.08,
                                              child: TextWidget(
                                                text:
                                                    "₹ ${responseData['money'] ?? ord['money']}",
                                                flow: TextOverflow.visible,
                                                color:
                                                    SpotmiesTheme.onBackground,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                partnerDetailsSummury(
                                                    context,
                                                    height(context),
                                                    width(context),
                                                    pDetails,
                                                    _responsiveController!,
                                                    responseData,
                                                    chatWithPatner,
                                                    onClick: () {
                                                  // Navigator.of(context).psu
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostOverView(
                                                                ordId: responseData[
                                                                        'ordId']
                                                                    .toString(),
                                                              )));
                                                });
                                              },
                                              icon: Icon(
                                                Icons.info,
                                                color: Colors.grey,
                                                size: width(context) * 0.05,
                                              ))
                                        ],
                                      ),
                                      responseData['isAccepted']
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green[700],
                                                      size: width(context) *
                                                          0.056,
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: TextWid(
                                                        text:
                                                            "Partner accepted your order",
                                                        size: width(context) *
                                                            0.04,
                                                        weight: FontWeight.bold,
                                                      )),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            _responsiveController
                                                                ?.deleteResponse(
                                                                    responseData[
                                                                            'responseId']
                                                                        .toString(),
                                                                    context,
                                                                    responseProvider);
                                                          },
                                                          icon: Icon(
                                                            Icons.delete_sweep,
                                                            color: Colors.red,
                                                            size:
                                                                width(context) *
                                                                    0.056,
                                                          )),
                                                    ),
                                                  )
                                                ])
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButtonWidget(
                                                  minWidth:
                                                      width(context) * 0.3,
                                                  height:
                                                      height(context) * 0.045,
                                                  bgColor: SpotmiesTheme.dull,
                                                  buttonName: 'Decline',
                                                  textColor: SpotmiesTheme
                                                      .secondaryVariant,
                                                  borderRadius: 15.0,
                                                  textSize:
                                                      width(context) * 0.04,
                                                  borderSideColor:
                                                      Colors.indigo[50],
                                                  onClick: () {
                                                    _responsiveController
                                                        ?.acceptOrRejectResponse(
                                                      responseData,
                                                      "reject",
                                                      context,
                                                      responseProvider,
                                                      profileProvider,
                                                      chatProvider,
                                                      ordersProvider,
                                                    );
                                                  },
                                                ),
                                                ElevatedButtonWidget(
                                                  minWidth:
                                                      width(context) * 0.5,
                                                  height:
                                                      height(context) * 0.045,
                                                  bgColor:
                                                      SpotmiesTheme.primary,
                                                  buttonName: 'Accept',
                                                  textColor: Colors.white,
                                                  borderRadius: 15.0,
                                                  textSize:
                                                      width(context) * 0.04,
                                                  borderSideColor:
                                                      SpotmiesTheme.primary,
                                                  onClick: () {
                                                    _responsiveController
                                                        ?.acceptOrRejectResponse(
                                                      responseData,
                                                      "accept",
                                                      context,
                                                      responseProvider,
                                                      profileProvider,
                                                      chatProvider,
                                                      ordersProvider,
                                                    );
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
                        })
                    : NoDataPlaceHolder(
                        height: _height,
                        width: _width,
                        title: "No Responses Available",
                      ),
              ),
            ),
            ProgressWaiter(contextt: context, loaderState: data.loader)
          ]);
        }));
  }
}
