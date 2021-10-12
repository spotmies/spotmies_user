import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/utilities/constants.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/controllers/posts_controllers/posts_controller.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends StateMVC<PostList> {
  PostsController _postsController;
  GetOrdersProvider ordersProvider;
  _PostListState() : super(PostsController()) {
    this._postsController = controller;
  }

  @override
  void initState() {
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _postsController.scaffoldkey,
        // backgroundColor: Colors.blue[900],
        appBar: AppBar(
          leading: Icon(Icons.work, color: Colors.grey[900]),
          title: TextWidget(
            text: 'My Bookings',
            color: Colors.grey[900],
            size: _width * 0.05,
            weight: FontWeight.w600,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          elevation: 0,
        ),
        body: Container(
          // padding: EdgeInsets.all(10),
          height: _hight * 1,
          width: _width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Consumer<GetOrdersProvider>(
            builder: (context, data, child) {
              var o = data.getOrdersList;
              if (data.getLoader) return Center(child: profileShimmer(context));
              if (o.length < 1)
                return Center(
                  child: TextWid(
                    text: "No Orders",
                    size: 30,
                  ),
                );

              return RefreshIndicator(
                onRefresh: _postsController.getOrderFromDB,
                child: ListView.builder(
                    itemCount: o.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      List<String> images = List.from(o[index]['media']);
                      // final coordinates =
                      //     Coordinates(o[index]['loc'][0], o[index]['loc'][1]);
                      // var addresses = Geocoder.local
                      //     .findAddressesFromCoordinates(coordinates);

                      var orderid = o[index]['ordId'];
                      print(o[index]['ordId']);

                      // var firstAddress = addresses.first.locality;
                      return Container(
                        child: InkWell(
                          onTap: () {
                            //  OrderOverViewProvider().orderDetails(orderid);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PostOverView(ordId: orderid.toString()),
                            ));
                          },
                          child: Container(
                              height: _hight * 0.265,
                              width: _width * 1,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                // borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: _hight * 0.09,
                                    width: _width * 1,
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      // borderRadius: BorderRadius.only(
                                      //     topLeft: Radius.circular(15),
                                      //     topRight: Radius.circular(15)),
                                    ),
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: _hight * 0.08,
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0, top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    text: _postsController.jobs
                                                        .elementAt(
                                                      o[index]['job'],
                                                    ),
                                                    size: _width * 0.045,
                                                    weight: FontWeight.w600,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 5, left: 5),
                                                    height: _hight * 0.032,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          orderStateIcon(
                                                              ordState: o[index]
                                                                  [
                                                                  'orderState']),
                                                          color: Colors
                                                              .indigo[900],
                                                          size: _width * 0.04,
                                                        ),
                                                        SizedBox(
                                                          width: _width * 0.01,
                                                        ),
                                                        TextWidget(
                                                            text: orderStateString(
                                                                ordState: o[
                                                                        index][
                                                                    'orderState']),
                                                            color: Colors
                                                                .indigo[900],
                                                            weight:
                                                                FontWeight.w600,
                                                            size: _width * 0.03)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              TextWidget(
                                                text: getDate(
                                                        o[index]['schedule']) +
                                                    ' - ' +
                                                    getTime(
                                                        o[index]['schedule']),
                                                color: Colors.grey[600],
                                                size: _width * 0.03,
                                                weight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: _hight * 0.06,
                                          height: _hight * 0.06,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[50],
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: (images.length == 0)
                                              ? Icon(
                                                  Icons.engineering,
                                                  color: Colors.grey[900],
                                                )
                                              : Image.network(images.first),
                                        ),
                                        Container(
                                          height: _hight * 0.11,
                                          // width: _width * 0.6,
                                          padding: EdgeInsets.only(
                                              left: _width * 0.06,
                                              top: _width * 0.02),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: _width * 0.65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .account_balance_wallet,
                                                          color:
                                                              Colors.grey[900],
                                                          size: _width * 0.04,
                                                        ),
                                                        SizedBox(
                                                          width: _width * 0.01,
                                                        ),
                                                        TextWidget(
                                                          text: 'Rs.1500',
                                                          // +
                                                          // o[index]['money']
                                                          //     .toString(),
                                                          size: _width * 0.035,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      ],
                                                    ),
                                                    TextWidget(
                                                        text:
                                                            toBeginningOfSentenceCase(
                                                                o[index][
                                                                    'problem']),
                                                        flow: TextOverflow
                                                            .ellipsis,
                                                        size: _width * 0.045),
                                                  ],
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    child: Icon(
                                                      Icons.chat_bubble,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: CircleAvatar(
                                                          radius: _width * 0.02,
                                                          backgroundColor:
                                                              Colors
                                                                  .indigo[900],
                                                          child: TextWidget(
                                                            text: '5',
                                                            color: Colors.white,
                                                            size:
                                                                _width * 0.025,
                                                          )))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButtonWidget(
                                          minWidth: _width * 0.498,
                                          height: _hight * 0.06,
                                          bgColor: Colors.grey[50],
                                          buttonName: 'Need Help ?',
                                          textColor: Colors.grey[900],
                                          borderRadius: 0.0,
                                          textSize: _width * 0.04,
                                          leadingIcon: Icon(
                                            Icons.help,
                                            size: _width * 0.04,
                                            color: Colors.grey[900],
                                          ),
                                          borderSideColor: Colors.grey[50],
                                        ),
                                        ElevatedButtonWidget(
                                          minWidth: _width * 0.498,
                                          height: _hight * 0.06,
                                          bgColor: Colors.grey[50],
                                          buttonName: 'View Menu',
                                          textColor: Colors.grey[900],
                                          borderRadius: 0.0,
                                          textSize: _width * 0.04,
                                          trailingIcon: Icon(
                                            Icons.menu,
                                            size: _width * 0.04,
                                            color: Colors.grey[900],
                                          ),
                                          borderSideColor: Colors.grey[50],
                                          onClick: () {
                                            postmenu(
                                                orderid, _hight, _width, index);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        padding: EdgeInsets.only(top: 10),
                      );
                    }),
              );
            },
          ),
        ));
  }

  postmenu(orderid, double hight, double width, int index) {
    showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          color: Colors.white,
          height: hight * 0.18,
          child: Center(
            child: Column(
              children: [
                TextWidget(
                  text: 'Select Menu',
                  size: width * 0.04,
                  color: Colors.grey[900],
                  weight: FontWeight.w600,
                ),
                Divider(
                  thickness: width * 0.005,
                  indent: width * 0.15,
                  endIndent: width * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PostOverView(ordId: orderid.toString()),
                        ));
                      },
                      child: Container(
                        child: CircleAvatar(
                          radius: width * 0.099,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.grey[900],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              TextWidget(
                                text: 'View',
                                color: Colors.grey[900],
                                weight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => PostAdEdit(value: orderid),
                        // ));
                      },
                      child: Container(
                        child: CircleAvatar(
                          radius: width * 0.099,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.grey[900],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              TextWidget(
                                text: 'Edit',
                                color: Colors.grey[900],
                                weight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                insetAnimationCurve: Curves.decelerate,
                                title: Text('Alert'),
                                content: Text(
                                    'Are you sure,you want delete the post ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Deny',
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        ordersProvider.setLoader(true);
                                        String ordid =
                                            API.deleteOrder + '$orderid';
                                        var response =
                                            await Server().deleteMethod(ordid);
                                        ordersProvider.setLoader(false);
                                        if (response.statusCode == 200) {
                                          response = jsonDecode(response.body);
                                          ordersProvider.removeOrderById(
                                              response['ordId']);
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              );
                            });
                      },
                      child: Container(
                        child: CircleAvatar(
                          radius: width * 0.099,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.grey[900],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              TextWidget(
                                text: 'Delete',
                                color: Colors.grey[900],
                                weight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: CircleAvatar(
                          radius: width * 0.099,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.backspace,
                                color: Colors.grey[900],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              TextWidget(
                                text: 'Close',
                                color: Colors.grey[900],
                                weight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}







// Container(
//                                     padding:
//                                         EdgeInsets.only(left: 10, right: 10),
//                                     height: _hight * 0.08,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Container(
//                                           width: _width * 0.2,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               TextWidget(
//                                                   text: getDate(
//                                                       o[index]['schedule']),
//                                                   flow: TextOverflow.ellipsis,
//                                                   weight: FontWeight.w600,
//                                                   size: _width * 0.03),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.schedule,
//                                                     color: Colors.grey[700],
//                                                     size: _width * 0.025,
//                                                   ),
//                                                   SizedBox(
//                                                     width: _width * 0.01,
//                                                   ),
//                                                   TextWidget(
//                                                       text: 'Schedule',
//                                                       flow:
//                                                           TextOverflow.ellipsis,
//                                                       size: _width * 0.025),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: _width * 0.2,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               // Text(document['scheduletime']),

//                                               TextWidget(
//                                                   text: 'Rs.' +
//                                                       o[index]['money']
//                                                           .toString(),
//                                                   flow: TextOverflow.ellipsis,
//                                                   weight: FontWeight.w600,
//                                                   size: _width * 0.03),

//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons
//                                                         .account_balance_wallet,
//                                                     color: Colors.grey[700],
//                                                     size: _width * 0.025,
//                                                   ),
//                                                   SizedBox(
//                                                     width: _width * 0.01,
//                                                   ),
//                                                   TextWidget(
//                                                       text: 'Money',
//                                                       flow:
//                                                           TextOverflow.ellipsis,
//                                                       size: _width * 0.025),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: _width * 0.25,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               // Text(document['scheduletime']),

//                                               TextWidget(
//                                                   text: 'Visakhaptnam',
//                                                   // _postsController
//                                                   //     .getAddressofLocation(
//                                                   //         addresses),
//                                                   flow: TextOverflow.ellipsis,
//                                                   color: Colors.grey[900],
//                                                   weight: FontWeight.w600,
//                                                   size: _width * 0.03),

//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     color: Colors.grey[700],
//                                                     size: _width * 0.025,
//                                                   ),
//                                                   SizedBox(
//                                                     width: _width * 0.01,
//                                                   ),
//                                                   TextWidget(
//                                                       text: 'Location',
//                                                       flow:
//                                                           TextOverflow.ellipsis,
//                                                       size: _width * 0.025),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),






// Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment
                                        //           .spaceBetween,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         Icon(
                                        //           _postsController
                                        //               .orderStateIcon(
                                        //                   o[index]
                                        //                       ['ordState']),
                                        //           color: Colors.indigo[900],
                                        //           size: _width * 0.04,
                                        //         ),
                                        //         SizedBox(
                                        //           width: _width * 0.01,
                                        //         ),
                                        //         TextWidget(
                                        //             text: _postsController
                                        //                 .orderStateText(o[
                                        //                         index]
                                        //                     ['ordState']),
                                        //             color:
                                        //                 Colors.indigo[900],
                                        //             weight: FontWeight.w600,
                                        //             size: _width * 0.03)
                                        //       ],
                                        //     ),
                                        //     IconButton(
                                        //         padding: EdgeInsets.zero,
                                        //         constraints:
                                        //             BoxConstraints(),
                                        //         icon: Icon(
                                        //           Icons.more_horiz,
                                        //           color: Colors.indigo[900],
                                        //           size: _width * 0.06,
                                        //         ),
                                        //         onPressed: () {
                                        //           postmenu(orderid, _hight,
                                        //               _width);
                                        //         })
                                        //   ],
                                        // ),
                                        // SizedBox(
                                        //   height: _hight * 0.007,
                                        // ),