import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/controllers/posts_controllers/posts_controller.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

import '../reusable_widgets/progress_waiter.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends StateMVC<PostList> {
  late PostsController _postsController;
  late GetOrdersProvider ordersProvider;
  late UniversalProvider up;

  _PostListState() : super(PostsController()) {
    this._postsController = controller as PostsController;
  }

  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    up.setCurrentConstants("orders");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: SpotmiesTheme.background,
        key: _postsController.scaffoldkey,
        appBar: AppBar(
          title: TextWidget(
            // text: up.getText("navbar_title"),
            // text: tr('my_services'),
            text: "My Services",
            color: SpotmiesTheme.secondaryVariant,
            size: width(context) * 0.06,
            weight: FontWeight.w600,
          ),
          backgroundColor: SpotmiesTheme.background,
          toolbarHeight: 48,
          elevation: 0,
        ),
        body: Container(
          // padding: EdgeInsets.all(10),
          height: height(context) * 1,
          width: width(context) * 1,
          padding: EdgeInsets.all(width(context) * 0.02),
          decoration: BoxDecoration(
            color: SpotmiesTheme.background,
          ),
          child: Consumer<GetOrdersProvider>(
            builder: (context, data, child) {
              var o = data.getOrdersList;
              if (data.getLoader) return Center(child: profileShimmer(context));
              // if (o.length < 1)
              //   return Center(
              //     child: TextWid(
              //       text: up.getText("no_orders"),
              //       size: width(context) * 0.05,
              //       color: SpotmiesTheme.secondaryVariant,
              //     ),
              //   );

              return RefreshIndicator(
                onRefresh: () async {
                  await _postsController.getOrderFromDB(
                      context, ordersProvider);
                },
                child: o.length > 0
                    ? ListView.builder(
                        itemCount: o.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          List<String> images = List.from(o[index]['media']);

                          var orderid = o[index]['ordId'];

                          return Container(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PostOverView(ordId: orderid.toString()),
                                ));
                              },
                              child: Container(
                                  height: height(context) * 0.22,
                                  width: width(context) * 1,
                                  decoration: BoxDecoration(
                                    color: SpotmiesTheme.lite,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: SpotmiesTheme.shadow,
                                          blurRadius: 3,
                                          spreadRadius: 3)
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height(context) * 0.05,
                                        width: width(context) * 1,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: width(context) * 0.04,
                                            right: width(context) * 0.02),
                                        decoration: BoxDecoration(
                                          color: SpotmiesTheme.surfaceVariant2,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                        ),
                                        child: Row(children: [
                                          SizedBox(
                                            width: width(context) * 0.6,
                                            child: TextWidget(
                                              text: up.getServiceNameById(
                                                  o[index]['job']),
                                              size: width(context) * 0.04,
                                              weight: FontWeight.w600,
                                              color: SpotmiesTheme.onBackground,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width(context) * 0.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          SpotmiesTheme
                                                              .surfaceVariant2,
                                                      child: Icon(
                                                        Icons.notifications,
                                                        color: Colors.grey[500],
                                                      ),
                                                    ),
                                                    Positioned(
                                                        right: width(context) *
                                                            0.015,
                                                        top: width(context) *
                                                            0.01,
                                                        child: CircleAvatar(
                                                            radius:
                                                                width(context) *
                                                                    0.015,
                                                            backgroundColor:
                                                                SpotmiesTheme
                                                                    .onBackground,
                                                            child: TextWidget(
                                                              text: o[index][
                                                                      'responses']
                                                                  .length
                                                                  .toString(),
                                                              color: SpotmiesTheme
                                                                  .background,
                                                              size: width(
                                                                      context) *
                                                                  0.025,
                                                            )))
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      bottomOptionsMenu(context,
                                                          menuTitle: up.getText(
                                                              "more_options"),
                                                          option1Click: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostOverView(
                                                                  ordId: orderid
                                                                      .toString()),
                                                        ));
                                                      }, option3Click: () {
                                                        showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                // insetAnimationCurve:
                                                                //     Curves.decelerate,
                                                                title: Text(
                                                                    up.getText(
                                                                        "delete_alert_heading")),
                                                                content: Text(
                                                                    up.getText(
                                                                        "delete_order_alert")),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        up.getText(
                                                                            "delete_deny"),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey[800],
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        Navigator.pop(
                                                                            context);
                                                                        ordersProvider
                                                                            .setLoader(true);
                                                                        String
                                                                            ordid =
                                                                            API.deleteOrder +
                                                                                '$orderid';
                                                                        var response =
                                                                            await Server().deleteMethod(ordid);
                                                                        ordersProvider
                                                                            .setLoader(false);
                                                                        if (response.statusCode ==
                                                                            200) {
                                                                          response =
                                                                              jsonDecode(response.body);
                                                                          ordersProvider
                                                                              .removeOrderById(response['ordId']);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        up.getText(
                                                                            "delete_order"),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight: FontWeight.bold),
                                                                      ))
                                                                ],
                                                              );
                                                            });
                                                      },
                                                          options: _postsController
                                                              .postMenuOptions);
                                                    },
                                                    icon: Icon(
                                                      Icons.more_vert,
                                                      color: SpotmiesTheme
                                                          .onBackground,
                                                      size:
                                                          width(context) * 0.05,
                                                    ))
                                              ],
                                            ),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        height: height(context) * 0.13,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: height(context) * 0.08,
                                              height: height(context) * 0.08,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: SpotmiesTheme
                                                    .surfaceVariant2,
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: (images.length == 0) ||
                                                      checkFileType(images.first
                                                              .toString()) !=
                                                          "image"
                                                  ? Icon(
                                                      Icons.engineering,
                                                      color: SpotmiesTheme
                                                          .secondaryVariant,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        images.first,
                                                        fit: BoxFit.cover,
                                                      )),
                                            ),
                                            Container(
                                              height: height(context) * 0.11,
                                              // width: width(context) * 0.6,
                                              padding: EdgeInsets.only(
                                                  left: width(context) * 0.06,
                                                  top: width(context) * 0.02),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        width(context) * 0.65,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .home_repair_service,
                                                              color: SpotmiesTheme
                                                                  .onBackground,
                                                              size: width(
                                                                      context) *
                                                                  0.04,
                                                            ),
                                                            SizedBox(
                                                              width: width(
                                                                      context) *
                                                                  0.01,
                                                            ),
                                                            SizedBox(
                                                              width: width(
                                                                      context) *
                                                                  0.6,
                                                              child: TextWidget(
                                                                text: toBeginningOfSentenceCase(
                                                                        o[index]
                                                                            [
                                                                            'problem']) ??
                                                                    "",
                                                                // +
                                                                // text: o[index][
                                                                //             'money'] ==
                                                                //         null
                                                                //     ? 'Not mentioned'
                                                                //     : o[index]
                                                                //             ['money']
                                                                //         .toString(),
                                                                size: width(
                                                                        context) *
                                                                    0.04,
                                                                color: SpotmiesTheme
                                                                    .onBackground,
                                                                flow: TextOverflow
                                                                    .ellipsis,
                                                                weight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        TextWidget(
                                                            text: o[index][
                                                                        'money'] ==
                                                                    null
                                                                ? 'Not mentioned'
                                                                : o[index][
                                                                        'money']
                                                                    .toString(),
                                                            flow: TextOverflow
                                                                .ellipsis,
                                                            color: SpotmiesTheme
                                                                .onBackground,
                                                            size:
                                                                width(context) *
                                                                    0.035),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              right: width(context) * 0.02,
                                              left: width(context) * 0.02,
                                            ),
                                            child: TextWidget(
                                              text: getDate(
                                                      o[index]['schedule']) +
                                                  ' - ' +
                                                  getTime(o[index]['schedule']),
                                              color: Colors.grey[600],
                                              size: width(context) * 0.03,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: width(context) * 0.02,
                                                left: width(context) * 0.02),
                                            height: height(context) * 0.032,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  orderStateIcon(
                                                      ordState: o[index]
                                                          ['orderState']),
                                                  color: SpotmiesTheme.primary,
                                                  size: width(context) * 0.04,
                                                ),
                                                SizedBox(
                                                  width: width(context) * 0.01,
                                                ),
                                                TextWidget(
                                                    text: orderStateString(
                                                        ordState: o[index]
                                                            ['orderState']),
                                                    color:
                                                        SpotmiesTheme.primary,
                                                    weight: FontWeight.w600,
                                                    size: width(context) * 0.03)
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            padding: EdgeInsets.only(top: 20),
                          );
                        })
                    : NoDataPlaceHolder(
                        height: _height,
                        width: _width,
                        title: "No Services Available",
                      ),
              );
            },
          ),
        ));
  }
}
