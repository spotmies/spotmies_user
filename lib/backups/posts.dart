import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/views/home/ads/adedit.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/controllers/posts_controllers/posts_controller.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/Badge_icon.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends StateMVC<PostList> {
  PostsController _postsController;
  _PostListState() : super(PostsController()) {
    this._postsController = controller;
  }

  @override
  void initState() {
    var orders = Provider.of<GetOrdersProvider>(context, listen: false);

    orders.getOrders();

    super.initState();
    // print("tesing post");
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
          leading: Icon(Icons.work, color: Colors.grey[800]),
          title: Text(
            'My bookings',
            style: TextStyle(color: Colors.grey[700]),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 48,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          height: _hight * 1,
          width: _width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Consumer<GetOrdersProvider>(
            builder: (context, data, child) {
              if (data.orders == null)
                return Center(child: profileShimmer(context));
              var o = data.orders;

              // print(o);
              return ListView.builder(
                  itemCount: o.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    // final coordinates =
                    //     Coordinates(o[index]['loc'][0], o[index]['loc'][1]);
                    // var addresses = Geocoder.local
                    //     .findAddressesFromCoordinates(coordinates);

                    var orderid = o[index]['ordId'];
                    print(o[index]['ordId']);
                    // print(o[index]['media'][0]);

                    // var firstAddress = addresses.first.locality;
                    return Container(
                      child: InkWell(
                        onTap: () {
                          //  OrderOverViewProvider().orderDetails(orderid);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostOverView(ordId: orderid),
                          ));
                        },
                        child: Stack(
                          children: [
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: Container(
                                  height: _hight * 0.22,
                                  width: _width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    // border: Border.all(
                                    //     width: 1.0, color: Color(0xFFe5e5e5)),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: _hight * 0.040,
                                        width: _width * 1,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFe5e5e5),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                            )),
                                        padding: EdgeInsets.only(left: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: _width * 0.04,
                                                      right: _width * 0.01),
                                                  child: Icon(
                                                    _postsController
                                                        .orderStateIcon(o[index]
                                                            ['ordState']),
                                                    size: _width * 0.035,
                                                  ),
                                                ),
                                                Text(
                                                  _postsController
                                                      .orderStateText(
                                                          o[index]['ordState']),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: _width * 0.03),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                padding:
                                                    EdgeInsets.only(bottom: 0),
                                                icon: Icon(
                                                  Icons.more_horiz,
                                                  // color: Colors.white,
                                                  size: 24,
                                                ),
                                                onPressed: () {
                                                  postmenu(
                                                      orderid, _hight, _width);
                                                })
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: _hight * 0.018),
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
                                                color: Color(0xFFe5e5e5),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: o[index]['media'].isEmpty
                                                  ? Icon(
                                                      Icons.engineering,
                                                      color: Colors.blue[900],
                                                    )
                                                  : Container(
                                                      child: Image.network(
                                                        o[index]['media'][0],
                                                      ),
                                                    ),
                                            ),
                                            Container(
                                              //  color: Colors.amber,
                                              height: _hight * 0.07,
                                              width: _width * 0.4,
                                              padding: EdgeInsets.only(
                                                  left: _width * 0.06),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    toBeginningOfSentenceCase(
                                                        o[index]['problem']),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _width * 0.05),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: _hight * 0.07,
                                              // color: Colors.amber,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  BadgeIcon(
                                                    iconData: Icon(
                                                      Icons.messenger_rounded,
                                                      size: _width * 0.08,
                                                      color: Colors.grey[700],
                                                    ),
                                                    badgeText: Text(
                                                      o[index]['messages']
                                                          .length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 7),
                                                    ),
                                                    badgeColor: Colors.red,
                                                    onTap: () {},
                                                  ),
                                                  // BadgeIcon(
                                                  //   iconData: Icon(
                                                  //     Icons
                                                  //         .notifications_active_rounded,
                                                  //     size: _width * 0.08,
                                                  //     // color: Colors.grey[700],
                                                  //   ),
                                                  //   badgeText: Text(
                                                  //     o[index]['responses']
                                                  //         .length
                                                  //         .toString(),
                                                  //     style: TextStyle(
                                                  //         fontSize: 7),
                                                  //   ),
                                                  //   badgeColor: Colors.red,
                                                  //   onTap: () {},
                                                  // ),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        height: _hight * 0.08,
                                        // color: Colors.amber,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: _width * 0.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(o[
                                                                    index]
                                                                ['schedule'])),
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _width * 0.03),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.schedule,
                                                        color: Colors.grey,
                                                        size: _width * 0.025,
                                                      ),
                                                      SizedBox(
                                                        width: _width * 0.01,
                                                      ),
                                                      Text(
                                                        'Schedule',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                _width * 0.02),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Text(document['scheduletime']),
                                                  Text(
                                                    o[index]['money'] != null
                                                        ? '₹ ' +
                                                            o[index]['money']
                                                                .toString()
                                                        : "₹ --",
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _width * 0.03),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .account_balance_wallet,
                                                        color: Colors.grey,
                                                        size: _width * 0.025,
                                                      ),
                                                      SizedBox(
                                                        width: _width * 0.01,
                                                      ),
                                                      Text(
                                                        'Money',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                _width * 0.02),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.25,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Text(document['scheduletime']),
                                                  Text(
                                                    'Visakhaptnam',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _width * 0.03),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.grey,
                                                        size: _width * 0.025,
                                                      ),
                                                      SizedBox(
                                                        width: _width * 0.01,
                                                      ),
                                                      Text(
                                                        'location',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                _width * 0.02),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: _width * 0.21,
                                              // color: Colors.amber,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _postsController.jobs
                                                        .elementAt(
                                                      o[index]['job'],
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            _width * 0.03),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.work,
                                                        color: Colors.grey,
                                                        size: _width * 0.025,
                                                      ),
                                                      SizedBox(
                                                        width: _width * 0.01,
                                                      ),
                                                      Text(
                                                        'Category',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                _width * 0.02),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10),
                    );
                  });
            },
          ),
        ));
  }

  postmenu(orderid, double hight, double width) {
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
                Text('SELECT MENU',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w300)),
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
                          builder: (context) => PostOverView(ordId: orderid),
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
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              Text(
                                'View',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostAdEdit(value: orderid),
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
                                Icons.edit,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
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
                                      onPressed: () {
                                        String ordid =
                                            API.deleteOrder + '$orderid';
                                        Server().deleteMethod(ordid);
                                        _postsController.controller.getData();
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
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
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
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                              Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
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
