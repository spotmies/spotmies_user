import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/posts_controllers/postOvervire_controller.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/media_player.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/ads/page2.dart';
import 'package:spotmies/views/internet_calling/calling.dart';
import 'package:spotmies/views/maps/offLine_placesModel.dart';
import 'package:spotmies/views/profile/help&supportBS.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/progress_waiter.dart';
import 'package:spotmies/views/reusable_widgets/queryBS.dart';
import 'package:spotmies/views/reusable_widgets/rating/review_screen.dart';
import 'package:spotmies/views/reusable_widgets/rating/size_provider.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class PostOverView extends StatefulWidget {
  final String ordId;
  PostOverView({required this.ordId});
  @override
  _PostOverViewState createState() => _PostOverViewState();
}

class _PostOverViewState extends StateMVC<PostOverView> {
  late PostOverViewController _postOverViewController;
  _PostOverViewState() : super(PostOverViewController()) {
    this._postOverViewController = controller as PostOverViewController;
  }
  ProfileController? profileController = ProfileController();
  late ChatProvider chatProvider;
  late UniversalProvider up;
  late int ordId;
  bool showOrderStatusQuestion = false;
  late GetOrdersProvider ordersProvider;
  // _PostOverViewState(this.value);
  // int _currentStep = 0;
  void chatWithPatner(responseData) {
    _postOverViewController.chatWithpatner(
        responseData, context, ordersProvider, chatProvider);
  }

  @override
  void initState() {
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("orders");

    try {
      ordersProvider.getOrderById(widget.ordId)['orderState'] < 9 &&
              ordersProvider.getOrderById(widget.ordId)['orderState'] != 3
          ? showOrderStatusQuestion = true
          : showOrderStatusQuestion = false;

      refresh();
    } catch (e) {}

    super.initState();
  }

  isThisOrderCompleted(state, {String orderID = "123", String money = "0"}) {
    if (state) {
      _postOverViewController.isOrderCompleted(
        money,
        orderID,
        context,
        ordersProvider,
      );
    }
    showOrderStatusQuestion = false;
    refresh();
  }

  appBarColor(orderState) {
    switch (orderState) {
      case 1:
      case 2:
      case 5:
      case 6:
      case 7:
      case 8:
        return SpotmiesTheme.background;
      case 3:
      case 4:
        return SpotmiesTheme.light2;
      case 9:
      case 10:
        return SpotmiesTheme.light3;

      default:
        return SpotmiesTheme.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeProvider().init(context);
    return Consumer<GetOrdersProvider>(builder: (context, data, child) {
      dynamic d = data.getOrderById(widget.ordId);
      _postOverViewController.orderDetails = d;

      log("ord $d");
      if (d == null)
        return Scaffold(
            body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.manage_search_rounded,
                color: Colors.grey[700], size: width(context) * 0.3),
            TextWid(
              text: "Unable to Load this order",
              weight: FontWeight.bold,
              size: width(context) * 0.05,
            ),
          ],
        )));
      _postOverViewController.pickedDate =
          DateTime.fromMillisecondsSinceEpoch(d['schedule']);
      _postOverViewController.pickedTime =
          TimeOfDay.fromDateTime(_postOverViewController.pickedDate);

      List<String> images = List.from(d['media']);
      dynamic fullAddress;
      try {
        fullAddress = jsonDecode(d['address']);
      } catch (e) {
        fullAddress = {};
      }
      // final coordinates = Coordinates(d['loc'][0], d['loc'][1]);

      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: SpotmiesTheme.onBackground,
            appBar: AppBar(
              backgroundColor: appBarColor(d['orderState']),
              toolbarHeight: d['orderState'] < 9 && d['orderState'] != 3
                  ? height(context) * 0.16
                  : height(context) * 0.08,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: d['orderState'] > 8
                      ? SpotmiesTheme.background
                      : SpotmiesTheme.onBackground,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: up.getServiceNameById(d['job'].runtimeType == String
                        ? int.parse(d['job'])
                        : d['job']),
                    size: width(context) * 0.04,
                    color: d['orderState'] > 8
                        ? SpotmiesTheme.background
                        : SpotmiesTheme.title,
                    lSpace: 1.5,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: height(context) * 0.007,
                  ),
                  Row(
                    children: [
                      Icon(
                        orderStateIcon(ordState: d['orderState']),
                        color: d['orderState'] > 8
                            ? SpotmiesTheme.equal
                            : SpotmiesTheme.equal,
                        size: width(context) * 0.035,
                      ),
                      SizedBox(
                        width: width(context) * 0.01,
                      ),
                      Expanded(
                        child: TextWid(
                            text: orderStateString(ordState: d['orderState']),
                            color: d['orderState'] > 8
                                ? SpotmiesTheme.equal
                                : SpotmiesTheme.equal,
                            flow: TextOverflow.visible,
                            weight: FontWeight.w700,
                            size: width(context) * 0.03),
                      ),
                    ],
                  )
                ],
              ),
              bottom: PreferredSize(
                  child: d['orderState'] < 9 && d['orderState'] != 3
                      ? Container(
                          margin:
                              EdgeInsets.only(bottom: width(context) * 0.01),
                          height: height(context) * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButtonWidget(
                                onClick: () {
                                  _postOverViewController
                                      .rescheduleServiceOrCancel(
                                    d['orderState'],
                                    d['ordId'],
                                    ordersProvider,
                                    action: "CANCEL_ORDER",
                                  );
                                },
                                height: height(context) * 0.05,
                                minWidth: width(context) * 0.4,
                                bgColor: SpotmiesTheme.background,
                                borderSideColor: SpotmiesTheme.dull,
                                textColor: SpotmiesTheme.onBackground,
                                borderRadius: 10.0,
                                buttonName: 'Cancel',
                                textSize: width(context) * 0.04,
                                leadingIcon: Icon(
                                  Icons.cancel,
                                  color: SpotmiesTheme.onBackground,
                                  size: width(context) * 0.045,
                                ),
                              ),
                              ElevatedButtonWidget(
                                onClick: () async {
                                  await _postOverViewController
                                      .pickDate(context);
                                  await _postOverViewController
                                      .picktime(context);

                                  if (d['schedule'].toString() !=
                                      _postOverViewController
                                          .getDateAndTime()) {
                                    await _postOverViewController
                                        .rescheduleServiceOrCancel(
                                            d['orderState'],
                                            d['ordId'],
                                            ordersProvider,
                                            action: "UPDATE_SCHEDULE");
                                  }
                                },
                                height: height(context) * 0.05,
                                minWidth: width(context) * 0.55,
                                bgColor: SpotmiesTheme.primary,
                                borderSideColor: SpotmiesTheme.background,
                                borderRadius: 10.0,
                                buttonName: 'Re-schedule',
                                textColor: SpotmiesTheme.background,
                                textSize: width(context) * 0.04,
                                trailingIcon: Icon(
                                  Icons.refresh,
                                  color: SpotmiesTheme.background,
                                  size: width(context) * 0.045,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  preferredSize: Size.fromHeight(4.0)),
              actions: [
                IconButton(
                    onPressed: () {
                      log(d['uDetails'].toString());
                      helpAndSupport(context, height(context), width(context),
                          profileController!, d['uDetails']);
                    },
                    icon: Icon(Icons.help,
                        color: d['orderState'] > 8
                            ? SpotmiesTheme.background
                            : SpotmiesTheme.onBackground)),
                IconButton(
                    onPressed: () {
                      bottomOptionsMenu(context,
                          options: _postOverViewController.options);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: d['orderState'] > 8
                          ? SpotmiesTheme.background
                          : SpotmiesTheme.onBackground,
                    )),
              ],
            ),
            body: Container(
              height: height(context),
              width: width(context),
              color: SpotmiesTheme.background,
              child: ListView(
                children: [
                  Divider(
                    color: SpotmiesTheme.dull,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      TextWidget(
                        text: orderStateString(ordState: d['orderState']),
                        color: SpotmiesTheme.onBackground,
                      ),
                      TextWidget(
                          text: "orderId : ${d['ordId']}",
                          color: SpotmiesTheme.onBackground)
                    ],
                  ),
                  Divider(
                    color: SpotmiesTheme.dull,
                  ),
                  Container(
                    //height: height(context) * 0.45,
                    width: width(context),
                    color: SpotmiesTheme.background,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(top: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: 'Service Details :',
                                size: width(context) * 0.055,
                                weight: FontWeight.w600,
                                color: SpotmiesTheme.onBackground,
                              ),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: SpotmiesTheme.onBackground,
                                  ))
                            ],
                          ),
                        ),
                        serviceDetailsListTile(
                          width(context),
                          height(context),
                          'Issue/Problem',
                          Icons.settings,
                          d['problem'],
                        ),
                        serviceDetailsListTile(
                          width(context),
                          height(context),
                          'Schedule',
                          Icons.schedule,
                          getDate(d['schedule']) + "-" + getTime(d['schedule']),
                        ),
                        Stack(
                          children: [
                            serviceDetailsListTile(
                                width(context),
                                height(context),
                                'Location',
                                Icons.location_on,
                                fullAddress['subLocality'] ??
                                    "Unable to get service address"),
                            Positioned(
                                right: width(context) * 0.02,
                                top: height(context) * 0.02,
                                child: IconButton(
                                    onPressed: () {
                                      var coordiantes = {
                                        "latitude": double.parse(
                                            fullAddress['latitude'] ??
                                                d['loc']['coordinates'][0]
                                                    .toString()),
                                        "logitude": double.parse(
                                            fullAddress['logitude'] ??
                                                d['loc']['coordinates'][1]
                                                    .toString())
                                      };
                                      // log(fullAddress['latitude']);

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Maps(
                                                    coordinates: coordiantes,
                                                    isSearch: false,
                                                    isNavigate: false,
                                                    actionLabel:
                                                        "Update Location",
                                                    onSave: (cords, address) {
                                                      log("$cords $address");
                                                      Navigator.pop(context);
                                                      _postOverViewController
                                                          .rescheduleServiceOrCancel(
                                                              d['orderState'],
                                                              d['ordId'],
                                                              ordersProvider,
                                                              action:
                                                                  "UPDATE_LOCATION",
                                                              updatedAddress:
                                                                  address,
                                                              updatedCoordinate:
                                                                  cords);
                                                    },
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.edit_location_outlined,
                                      color: SpotmiesTheme.onBackground,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: SpotmiesTheme.dull,
                  ),
                  mediaView(height(context), width(context), images),
                  Divider(
                    color: SpotmiesTheme.dull,
                  ),
                  d['orderState'] > 8
                      ? warrentyCard(height(context), width(context))
                      : Container(),
                  Divider(
                    color: SpotmiesTheme.dull,
                  ),
                  (d['orderState'] > 6)
                      ? Container(
                          // height: height(context) * 0.3,
                          color: SpotmiesTheme.background,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: 'Technician Details :',
                                      size: width(context) * 0.055,
                                      weight: FontWeight.w600,
                                      color: SpotmiesTheme.onBackground,
                                    ),
                                  ],
                                ),
                              ),
                              d['pDetails'] != null
                                  ? partnerDetails(
                                      height(context),
                                      width(context),
                                      context,
                                      _postOverViewController,
                                      d,
                                      chatWithPatner,
                                      up)
                                  : Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      child: TextWid(
                                          color: SpotmiesTheme.onBackground,
                                          text:
                                              "Unable to get Technician details")),
                            ],
                          ))
                      : Container(),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  Container(
                    // height: 800,
                    // padding: EdgeInsets.only(left: 30, bottom: 50, top: 30),
                    // width: width(context) * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        showOrderStatusQuestion && d['orderState'] != 3
                            ? Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(
                                      left: width(context) * 0.04,
                                    ),
                                    child: TextWid(
                                      text: 'Is this order completed ?',
                                      size: width(context) * 0.055,
                                      weight: FontWeight.w600,
                                      color: SpotmiesTheme.onBackground,
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 40),
                                    height: height(context) * 0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButtonWidget(
                                          height: height(context) * 0.05,
                                          minWidth: width(context) * 0.35,
                                          onClick: () {
                                            isThisOrderCompleted(false);
                                          },
                                          bgColor: SpotmiesTheme.background,
                                          borderSideColor: SpotmiesTheme.dull,
                                          borderRadius: 10.0,
                                          buttonName: 'Not yet',
                                          textColor: SpotmiesTheme.onBackground,
                                          textSize: width(context) * 0.04,
                                          leadingIcon: Icon(
                                            Icons.cancel,
                                            color: SpotmiesTheme.onBackground,
                                            size: width(context) * 0.045,
                                          ),
                                        ),
                                        ElevatedButtonWidget(
                                          height: height(context) * 0.05,
                                          minWidth: width(context) * 0.45,
                                          bgColor: SpotmiesTheme.primary,
                                          borderSideColor: SpotmiesTheme.dull,
                                          borderRadius: 10.0,
                                          buttonName: 'Completed',
                                          onClick: () {
                                            newQueryBS(context,
                                                type: "number",
                                                heading: "How much you paid",
                                                hint:
                                                    "Enter amount you paid to partner",
                                                label: "Enter Money",
                                                onSubmit: (String value) {
                                              // log(value);
                                              isThisOrderCompleted(true,
                                                  orderID:
                                                      d['ordId'].toString(),
                                                  money: value);
                                            });
                                          },
                                          textColor: SpotmiesTheme.background,
                                          textSize: width(context) * 0.04,
                                          leadingIcon: Icon(
                                            Icons.check_circle,
                                            color: SpotmiesTheme.background,
                                            size: width(context) * 0.045,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        Visibility(
                          visible: d['orderState'] == 9 && d['pId'] != null,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10, right: 10),
                            child: ElevatedButtonWidget(
                              height: height(context) * 0.05,
                              minWidth: width(context) * 0.5,
                              onClick: () {
                                reviewBS(context,
                                    _postOverViewController.submitReview);
                              },
                              bgColor: SpotmiesTheme.onBackground,
                              borderSideColor: SpotmiesTheme.dull,
                              borderRadius: 10.0,
                              buttonName: 'Rate Service',
                              textSize: width(context) * 0.04,
                              leadingIcon: Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: width(context) * 0.045,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: width(context) * 0.04),
                          child: TextWid(
                            text: 'Service Status :',
                            size: width(context) * 0.055,
                            color: SpotmiesTheme.onBackground,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Container(
                            height: height(context) * 0.6,
                            padding:
                                EdgeInsets.only(left: width(context) * 0.04),
                            child: _Timeline2(context, orderData: d)),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Visibility(
                          visible: d['orderState'] < 3,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: width(context) * 0.05,
                                bottom: width(context) * 0.3),
                            child: ElevatedButtonWidget(
                              height: height(context) * 0.05,
                              minWidth: width(context) * 0.5,
                              onClick: () {
                                Map<String, dynamic> sendPayload = {
                                  "socketName": "broadCastOrder",
                                  "ordId": d['ordId']
                                };
                                chatProvider.setSendMessage(sendPayload);
                              },
                              bgColor: SpotmiesTheme.background,
                              borderSideColor: SpotmiesTheme.dull,
                              borderRadius: 10.0,
                              buttonName: 'Send order again',
                              textColor: SpotmiesTheme.onBackground,
                              textSize: width(context) * 0.04,
                              leadingIcon: Icon(
                                Icons.refresh_rounded,
                                color: SpotmiesTheme.onBackground,
                                size: width(context) * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ProgressWaiter(contextt: context, loaderState: data.orderViewLoader)
        ],
      );
    });
  }

  serviceDetailsListTile(
    width,
    hight,
    title,
    icon,
    subtitle,
  ) {
    return ListTile(
        // tileColor: Colors.redAccent,
        leading: Icon(
          icon,
          size: width * 0.045,
          color: SpotmiesTheme.onBackground,
        ),
        title: TextWidget(
          text: title,
          size: width * 0.045,
          weight: FontWeight.w600,
          color: SpotmiesTheme.onBackground,
          lSpace: 1.5,
        ),
        subtitle: TextWidget(
          text: subtitle,
          size: width * 0.04,
          flow: TextOverflow.visible,
          weight: FontWeight.w600,
          color: SpotmiesTheme.equal,
          lSpace: 1,
        ),
        trailing: Container(
          width: width * 0.07,
        ));
  }

  mediaView(hight, width, images) {
    return Container(
      //height: hight * 0.22,
      color: SpotmiesTheme.background,
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Media Files :',
                  size: width * 0.055,
                  weight: FontWeight.w600,
                  color: SpotmiesTheme.onBackground,
                ),
              ],
            ),
          ),
          images.length > 0
              ? Container(
                  height: hight * 0.14,
                  child: ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MediaPlayer(
                                          mediaList: [images[index]],
                                        )));
                              },
                              child: Container(
                                  height: width * 0.15,
                                  width: width * 0.15,
                                  child: mediaContent(images[index],
                                      isOnline: true)),
                            )
                            // Container(
                            //   child: images[index].contains('jpg')
                            //       ? InkWell(
                            //           onTap: () {
                            //             imageslider(images, hight, width);
                            //           },
                            //           child: Container(
                            //             width: width * 0.11,
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(10),
                            //                 image: DecorationImage(
                            //                     image: NetworkImage(
                            //                         images[index]))),
                            //           ),
                            //         )
                            //       : images[index].contains('mp4')
                            //           ? TextWidget(
                            //               text: 'Video',
                            //             )
                            //           : TextWidget(text: 'Audio'),
                            // ),
                          ],
                        );
                      }),
                )
              : Container(
                  padding: EdgeInsets.only(top: 10),
                  child: TextWid(
                    text: 'No media files found',
                    align: TextAlign.center,
                  ),
                ),
        ],
      ),
    );
  }

  warrentyCard(hight, width) {
    return Container(
      height: hight * 0.2,
      width: width,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: SpotmiesTheme.primary,
          border: Border.all(color: SpotmiesTheme.primary),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            // alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, right: 10),
            width: width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextWidget(
                  text: 'Warranty Card',
                  color: SpotmiesTheme.onBackground,
                  size: width * 0.05,
                  weight: FontWeight.w600,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'VALID TILL',
                      color: SpotmiesTheme.onBackground,
                      size: width * 0.035,
                      weight: FontWeight.w600,
                    ),
                    TextWidget(
                      text: '09 Oct,2021',
                      color: SpotmiesTheme.onBackground,
                      size: width * 0.04,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                TextWidget(
                  text: 'Claim Warranty >>',
                  color: SpotmiesTheme.onBackground,
                  size: width * 0.045,
                  weight: FontWeight.w600,
                )
              ],
            ),
          ),
          Container(
            width: width * 0.3,
            child: SvgPicture.asset('assets/like.svg'),
          )
        ],
      ),
    );
  }

  rating() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingCard(onFeedbackSubmitted: (int stars, String feedback) {
            print("$stars - $feedback");
          });
          // return RatingDialog(
          //   onSubmitted: (RatingDialogResponse) {}, submitButtonText: '',
          //   title: Text('data'),
          //   // icon: Icon(
          //   //   Icons.rate_review,
          //   //   size: 100,
          //   //   color: Colors.blue[800],
          //   // ),
          //   // // const FlutterLogo(
          //   // //   size: 100,
          //   // // ), // set your own image/icon widget
          //   // title: "Rate Your Technician!",
          //   // description: "Express Your Experience By Tapping \nOn Stars",
          //   // submitButton: "SUBMIT",
          //   // alternativeButton: "Contact us instead?", // optional
          //   // positiveComment: "We are so happy to hear :)", // optional
          //   // negativeComment: "We're sad to hear :(", // optional
          //   // accentColor: Colors.blue[800], // optional
          //   // onSubmitPressed: (int rating) {
          //   //   print("onSubmitPressed: rating = $rating");
          //   // },
          //   // onAlternativePressed: () {
          //   //   print("onAlternativePressed: do something");
          //   // },
          // );
        });
  }

  imageslider(List<String> images, double hight, double width) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Container(
                  height: hight * 0.35,
                  width: width * 1,
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (ctx, index, realIdx) {
                      return Container(
                          child: Image.network(images[index]
                              .substring(0, images[index].length - 1)));
                    },
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlay: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                  ))
            ],
          );
        });
  }
}

partnerDetails(hight, width, BuildContext context, controller, orderDetails,
    chatWithPatner, UniversalProvider up) {
  dynamic pDetails = orderDetails['pDetails'];
  log(pDetails['lang'].toString());
  List languages = pDetails['lang'];
  return Container(
    // height: hight * 0.24,
    child: Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfilePic(
                  profile: pDetails['partnerPic'],
                  name: pDetails['name'],
                  size: hight * 0.05,
                ),
                SizedBox(
                  width: width * 0.07,
                ),
                Container(
                  height: hight * 0.11,
                  width: width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: toBeginningOfSentenceCase(
                                      pDetails['name'],
                                    ) ??
                                    "",
                                size: width * 0.04,
                                weight: FontWeight.w600,
                                color: SpotmiesTheme.onBackground,
                              )
                            ],
                          ),
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: up.getServiceNameById(pDetails['job']) +
                                      ' | ',
                                  size: width * 0.025,
                                  weight: FontWeight.w600,
                                  color: SpotmiesTheme.equal,
                                ),
                                TextWidget(
                                  // text: pDetails['rate'][0].toString(),
                                  text: '4.5',
                                  size: width * 0.025,
                                  weight: FontWeight.w600,
                                  color: SpotmiesTheme.equal,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: width * 0.025,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                            children: languages
                                .map((lang) => Container(
                                      child: TextWid(
                                        text: lang + "  ",
                                        size: width * 0.026,
                                        weight: FontWeight.w600,
                                        color: SpotmiesTheme.onBackground,
                                      ),
                                    ))
                                .toList()),
                      ),
                      Container(
                        width: width * 0.45,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: width * 0.03,
                              color: SpotmiesTheme.onBackground,
                            ),
                            TextWid(
                              text: 'vizag',
                              size: width * 0.03,
                              weight: FontWeight.w600,
                              color: SpotmiesTheme.onBackground,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        SizedBox(
          height: hight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                bottomOptionsMenu(context,
                    options: Constants.bottomSheetOptionsForCalling,
                    option1Click: () {
                  launch("tel://${orderDetails['pDetails']['phNum']}");
                }, option2Click: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyCalling(
                            ordId: orderDetails['ordId'].toString(),
                            uId: orderDetails['uDetails']['uId'],
                            pId: orderDetails['pDetails']['pId'],
                            isIncoming: false,
                            name: orderDetails['pDetails']['name'].toString(),
                            profile: orderDetails['pDetails']['partnerPic']
                                .toString(),
                            partnerDeviceToken: orderDetails['pDetails']
                                    ['partnerDeviceToken']
                                .toString(),
                          )));
                });
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: SpotmiesTheme.dull,
                    child: Icon(
                      Icons.call,
                      color: SpotmiesTheme.onBackground,
                      size: width * 0.05,
                    ),
                  ),
                  SizedBox(
                    width: hight * 0.02,
                  ),
                  TextWidget(
                    text: 'Call',
                    size: width * 0.04,
                    weight: FontWeight.w600,
                    color: SpotmiesTheme.onBackground,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                chatWithPatner(orderDetails);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: SpotmiesTheme.dull,
                    child: Icon(
                      Icons.chat_bubble,
                      color: SpotmiesTheme.onBackground,
                      size: width * 0.05,
                    ),
                  ),
                  SizedBox(
                    width: hight * 0.02,
                  ),
                  TextWidget(
                    text: 'Message',
                    size: width * 0.04,
                    weight: FontWeight.w600,
                    color: SpotmiesTheme.onBackground,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

enum _TimelineStatus { request, accept, started, completed, feedback }

const kTileHeight = 90.0;

class _Timeline2 extends StatelessWidget {
  final BuildContext contextt;
  final dynamic orderData;
  _Timeline2(this.contextt, {@required this.orderData});
  isServiceStarted() {
    int schedule = orderData['schedule'].runtimeType == String
        ? int.parse(orderData['schedule'])
        : orderData['schedule'];
    int presentTimestamp = DateTime.now().millisecondsSinceEpoch;
    // if (orderData['orderState'] < 8) return false;
    if (schedule < presentTimestamp) {
      if (orderData['orderState'] > 6) {
        return true;
      }
      return false;
    }
    if (orderData['orderState'] > 6) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final data = _TimelineStatus.values;
    return Column(
      children: [
        Flexible(
          child: Timeline.tileBuilder(
            physics: NeverScrollableScrollPhysics(),
            theme: TimelineThemeData(
              nodePosition: 0,
              connectorTheme: ConnectorThemeData(
                thickness: 3.0,
                space: 20,
                color: SpotmiesTheme.dull,
              ),
              indicatorTheme: IndicatorThemeData(
                size: width(context) * 0.06,
              ),
            ),
            //padding: EdgeInsets.symmetric(vertical: 5.0),
            builder: TimelineTileBuilder.connected(
              contentsBuilder: (_, index) {
                return TimeLineTitle(index, contextt, orderData['orderState'],
                    isServiceStarted());
              },
              connectorBuilder: (_, index, connectorType) {
                var solidLineConnector = SolidLineConnector(
                  color: SpotmiesTheme.primary,
                  indent: connectorType == ConnectorType.start ? 0 : 2.0,
                  endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                );
                var solidLineConnectorEmpty = SolidLineConnector(
                  indent: connectorType == ConnectorType.start ? 0 : 2.0,
                  endIndent: connectorType == ConnectorType.end ? 0 : 2.0,
                );
                switch (index) {
                  case 0:
                    return solidLineConnector;
                  case 1:
                    if (orderData['orderState'] > 6) return solidLineConnector;
                    return solidLineConnectorEmpty;
                  case 2:
                    if (orderData['orderState'] > 8) return solidLineConnector;
                    return solidLineConnectorEmpty;
                  case 3:
                    if (orderData['orderState'] > 9) return solidLineConnector;
                    return solidLineConnectorEmpty;
                  default:
                    return solidLineConnectorEmpty;
                }
              },
              indicatorBuilder: (_, index) {
                switch (data[index]) {
                  case _TimelineStatus.request:
                    return DotIndicator(
                      color: SpotmiesTheme.primary,
                      child: Icon(
                        Icons.work_rounded,
                        color: SpotmiesTheme.dull,
                        size: width(context) * 0.035,
                      ),
                    );
                  case _TimelineStatus.accept:
                    return DotIndicator(
                      color: orderData['orderState'] > 6
                          ? SpotmiesTheme.primary
                          : SpotmiesTheme.dull,
                      child: Icon(
                        Icons.how_to_reg_rounded,
                        size: width(context) * 0.035,
                        color: orderData['orderState'] > 6
                            ? SpotmiesTheme.dull
                            : SpotmiesTheme.onBackground,
                      ),
                    );
                  case _TimelineStatus.started:
                    return DotIndicator(
                      color: isServiceStarted()
                          ? SpotmiesTheme.primary
                          : SpotmiesTheme.dull,
                      child: Icon(
                        Icons.build,
                        size: width(context) * 0.035,
                        color: SpotmiesTheme.onBackground,
                      ),
                    );
                  case _TimelineStatus.completed:
                    return DotIndicator(
                      color: orderData['orderState'] > 8
                          ? SpotmiesTheme.primary
                          : SpotmiesTheme.dull,
                      child: Icon(
                        Icons.verified_rounded,
                        size: width(context) * 0.035,
                        color: orderData['orderState'] > 8
                            ? SpotmiesTheme.dull
                            : SpotmiesTheme.onBackground,
                      ),
                    );
                  case _TimelineStatus.feedback:
                    return DotIndicator(
                      color: orderData['orderState'] > 9
                          ? SpotmiesTheme.primary
                          : SpotmiesTheme.dull,
                      child: Icon(
                        Icons.reviews,
                        size: width(context) * 0.035,
                        color: orderData['orderState'] > 9
                            ? SpotmiesTheme.dull
                            : SpotmiesTheme.onBackground,
                      ),
                    );
                  default:
                    return DotIndicator(
                      color: SpotmiesTheme.primary,
                      child: Icon(
                        Icons.verified_rounded,
                        size: width(context) * 0.035,
                        color: SpotmiesTheme.equal,
                      ),
                    );
                }
              },
              itemExtentBuilder: (_, __) => kTileHeight,
              itemCount: data.length,
            ),
          ),
        ),
      ],
    );
  }
}

class TimeLineTitle extends StatelessWidget {
  final int index;
  final BuildContext contextt;
  final int orderState;
  final bool orderStarted;
  TimeLineTitle(this.index, this.contextt, this.orderState, this.orderStarted);
  getStatus() {
    switch (index) {
      case 0:
        return "Service Requested";
      case 1:
        return "Order Accepted";
      case 2:
        return "Service Started";
      case 3:
        return "Service Completed";
      case 4:
        return "Feedback";
      default:
        return "Something Went wrong";
    }
  }

  isCompleted() {
    if (index < 2) return true;
    switch (index) {
      case 2:
        if (orderStarted) return true;
        return false;
      case 3:
        if (orderState > 8) return true;
        return false;
      case 4:
        if (orderState > 9) return true;
        return false;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: width(context) * 0.03),
        child: TextWid(
          text: getStatus(),
          size: width(context) * 0.04,
          weight: FontWeight.w600,
          color:
              isCompleted() ? SpotmiesTheme.onBackground : SpotmiesTheme.equal,
        ));
  }
}
