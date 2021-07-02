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

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends StateMVC<PostList> {
  PostsController _postsController;
  _PostListState() : super(PostsController()) {
    this._postsController = controller;
  }

  //var orders;
  textedit(orders) {
    return List.from(orders.reversed);
  }

  @override
  void initState() {
    var orders = Provider.of<GetOrdersProvider>(context, listen: false);

    orders.getOrders();

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
              var o = textedit(data.orders);

              // print(o);
              return ListView.builder(
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
                            builder: (context) => PostOverView(ordId: orderid),
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                                height: _hight * 0.20,
                                width: _width * 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue[800],
                                        Colors.blue[900]
                                      ],
                                      begin: FractionalOffset(0.0, 0.2),
                                      end: FractionalOffset(0.4, 0.9),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: _hight * 0.040,
                                      width: _width * 0.88,
                                      padding: EdgeInsets.only(left: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                _postsController.orderStateIcon(
                                                    o[index]['ordState']),
                                                color: Colors.white,
                                                size: _width * 0.035,
                                              ),
                                              SizedBox(
                                                width: _width * 0.01,
                                              ),
                                              Text(
                                                _postsController.orderStateText(
                                                    o[index]['ordState']),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _width * 0.03),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              padding:
                                                  EdgeInsets.only(bottom: 0),
                                              icon: Icon(
                                                Icons.more_horiz,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                postmenu(
                                                    orderid, _hight, _width);
                                              })
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
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: (images.length == 0)
                                                ? Icon(
                                                    Icons.engineering,
                                                    color: Colors.blue[900],
                                                  )
                                                : Image.network(images.first),
                                          ),
                                          Container(
                                            height: _hight * 0.07,
                                            width: _width * 0.6,
                                            padding: EdgeInsets.only(
                                                left: _width * 0.06),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.work,
                                                      color: Colors.white,
                                                      size: _width * 0.035,
                                                    ),
                                                    SizedBox(
                                                      width: _width * 0.01,
                                                    ),
                                                    Text(
                                                      _postsController.jobs
                                                          .elementAt(
                                                        o[index]['job'],
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              _width * 0.03),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  toBeginningOfSentenceCase(
                                                      o[index]['problem']),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: _width * 0.05),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      height: _hight * 0.08,
                                      // color: Colors.amber,
                                      child: Row(
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
                                                          .fromMillisecondsSinceEpoch(
                                                              o[index][
                                                                  'schedule'])),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _width * 0.03),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.schedule,
                                                      color: Colors.white,
                                                      size: _width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: _width * 0.01,
                                                    ),
                                                    Text(
                                                      'Schedule',
                                                      style: TextStyle(
                                                          color: Colors.white,
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
                                                  'Rs.' +
                                                      o[index]['money']
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _width * 0.03),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .account_balance_wallet,
                                                      color: Colors.white,
                                                      size: _width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: _width * 0.01,
                                                    ),
                                                    Text(
                                                      'Money',
                                                      style: TextStyle(
                                                          color: Colors.white,
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
                                                  // _postsController
                                                  //     .getAddressofLocation(
                                                  //         addresses),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: _width * 0.03),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                      size: _width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: _width * 0.01,
                                                    ),
                                                    Text(
                                                      'location',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              _width * 0.02),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Positioned(
                                right: -25,
                                bottom: -25,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: _width * 0.05,
                                    bottom: _width * 0.09,
                                  ),
                                  height: _hight * 0.15,
                                  width: _hight * 0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.indigo[700],
                                          spreadRadius: 4)
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text('4',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _width * 0.05)),
                                            Text('Responses',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _width * 0.02))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
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
