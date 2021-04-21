// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:spotmies/home/ad/adedit.dart';
// import 'package:spotmies/posts/post_overview.dart';

// class PostList extends StatefulWidget {
//   @override
//   _PostListState createState() => _PostListState();
// }

// class _PostListState extends State<PostList> {
//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         // backgroundColor: Colors.blue[900],
//         appBar: AppBar(
//           title: Text('My posts'),
//           backgroundColor: Colors.blue[900],
//           toolbarHeight: 48,
//           elevation: 0,
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(FirebaseAuth.instance.currentUser.uid)
//               .collection('adpost')
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData)
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             return Container(
//               height: _hight * 1,
//               width: _width * 1,
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//               ),
//               child: ListView(
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.all(15),
//                 children: snapshot.data.docs.map((document) {
//                   // var state = document['orderstate'];
//                   // if (state == 0) {
//                   //   _shownotification();
//                   // }
//                   // if (state == 1) {
//                   //   _shownotification1();
//                   // }
//                   // if (state == 2) {
//                   //   _shownotification2();
//                   // }
//                   // if (state == 3) {
//                   //   _shownotification3();
//                   // }

//                   return Column(children: [
//                     InkWell(
//                       onTap: () {
//                         //print(document['orderid']);
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               PostOverView(value: document['orderid']),
//                         ));
//                       },
//                       child: Container(
//                           height: _hight * 0.30,
//                           width: _width * 1,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: kElevationToShadow[0]),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: _hight * 0.040,
//                                 width: _width * 1,
//                                 decoration: BoxDecoration(
//                                     color: Colors.blue[900],
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(15),
//                                       topRight: const Radius.circular(15),
//                                     )),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       (() {
//                                         if (document['job'] == 0) {
//                                           return 'AC Service';
//                                         }
//                                         if (document['job'] == 1) {
//                                           return 'Computer';
//                                         }
//                                         if (document['job'] == 2) {
//                                           return 'TV Repair';
//                                         }
//                                         if (document['job'] == 3) {
//                                           return 'Development';
//                                         }
//                                         if (document['job'] == 4) {
//                                           return 'Tutor';
//                                         }
//                                         if (document['job'] == 5) {
//                                           return 'Beauty';
//                                         }
//                                         if (document['job'] == 6) {
//                                           return 'Photography';
//                                         }
//                                         if (document['job'] == 7) {
//                                           return 'Drivers';
//                                         }
//                                         if (document['job'] == 8) {
//                                           return 'Events';
//                                         }
//                                       }())
//                                           .toString(),
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     SizedBox(
//                                       width: 150,
//                                     ),
//                                     IconButton(
//                                         padding: EdgeInsets.only(bottom: 15),
//                                         icon: Icon(
//                                           Icons.more_horiz,
//                                           color: Colors.white,
//                                           size: 30,
//                                         ),
//                                         onPressed: () {
//                                           showCupertinoModalPopup(
//                                               context: context,
//                                               builder: (context) =>
//                                                   CupertinoActionSheet(
//                                                     actions: [
//                                                       CupertinoActionSheetAction(
//                                                           isDefaultAction: true,
//                                                           onPressed: () {
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .push(
//                                                                     MaterialPageRoute(
//                                                               builder: (context) =>
//                                                                   PostAdEdit(
//                                                                       value: document[
//                                                                           'orderid']),
//                                                             ));
//                                                           },
//                                                           child: Text('Edit',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .black))),
//                                                       CupertinoActionSheetAction(
//                                                           isDefaultAction: true,
//                                                           onPressed: () {
//                                                             FirebaseFirestore
//                                                                 .instance
//                                                                 .collection(
//                                                                     'users')
//                                                                 .doc(document[
//                                                                     'orderid'])
//                                                                 .update({
//                                                               'delete': true,
//                                                             });
//                                                             FirebaseFirestore
//                                                                 .instance
//                                                                 .collection(
//                                                                     'users')
//                                                                 .doc(FirebaseAuth
//                                                                     .instance
//                                                                     .currentUser
//                                                                     .uid)
//                                                                 .collection(
//                                                                     'adpost')
//                                                                 .doc(document[
//                                                                     'orderid'])
//                                                                 .delete();
//                                                           },
//                                                           child: Text('Delete',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .black)))
//                                                     ],
//                                                     cancelButton:
//                                                         CupertinoActionSheetAction(
//                                                             onPressed: () {
//                                                               Navigator.pop(
//                                                                   context);
//                                                             },
//                                                             child: Text(
//                                                               'Cancel',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .black),
//                                                             )),
//                                                   ));
//                                         })
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                         document['media'].toString()),
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         height: _hight * 0.055,
//                                         width: _width * 0.7,
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               document['problem'].toString(),
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             height: 120,
//                                             width: 120,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 2,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons.remove_red_eye,
//                                                       size: 20,
//                                                     ),
//                                                     Text(' Money:' +
//                                                         document['money']
//                                                             .toString()),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 11,
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons.person_pin_circle,
//                                                       size: 20,
//                                                     ),
//                                                     Text(' Distance:' +
//                                                         document['money']
//                                                             .toString())
//                                                   ],
//                                                 ),
//                                                 TextButton(
//                                                     onPressed: () {},
//                                                     child: Text(
//                                                       'View your post',
//                                                       style: TextStyle(
//                                                           fontSize: 15,
//                                                           color:
//                                                               Colors.blue[900]),
//                                                     )),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 15,
//                                           ),
//                                           Container(
//                                             height: 120,
//                                             width: 120,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons.attach_money,
//                                                       size: 20,
//                                                     ),
//                                                     Text('Money:' +
//                                                         document['money']
//                                                             .toString()),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     Icon(
//                                                       Icons.timer,
//                                                       size: 20,
//                                                     ),
//                                                     // Text('$DateTime'),
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                     height: 25,
//                                                     width: 90,
//                                                     decoration: BoxDecoration(
//                                                         color: Colors.blue[900],
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(15)),
//                                                     child: Center(
//                                                       child: Text(
//                                                         'Active',
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ))
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     )
//                   ]);
//                 }).toList(),
//               ),
//             );
//           },
//         ));
//   }

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   //for notifications
//   //   var androidInitialize = AndroidInitializationSettings('asdf');
//   //   var initializesettings = InitializationSettings(android: androidInitialize);
//   //   localNotifications = FlutterLocalNotificationsPlugin();
//   //   localNotifications.initialize(initializesettings);
//   // }

//   // FlutterLocalNotificationsPlugin localNotifications;

//   // Future _shownotification() async {
//   //   var androidDetails = AndroidNotificationDetails(
//   //       'channelId', 'channelName', 'channelDescription',
//   //       importance: Importance.high);
//   //   var generalNotificationetails =
//   //       NotificationDetails(android: androidDetails);
//   //   await localNotifications.show(0, 'Order Posted',
//   //       'something behind the info', generalNotificationetails);
//   // }

//   // Future _shownotification1() async {
//   //   var androidDetails = AndroidNotificationDetails(
//   //       'channelId', 'channelName', 'channelDescription',
//   //       importance: Importance.high);
//   //   var generalNotificationetails =
//   //       NotificationDetails(android: androidDetails);
//   //   await localNotifications.show(
//   //       0, 'something', 'something behind the info', generalNotificationetails);
//   // }

//   // Future _shownotification2() async {
//   //   var androidDetails = AndroidNotificationDetails(
//   //       'channelId', 'channelName', 'channelDescription',
//   //       importance: Importance.high);
//   //   var generalNotificationetails =
//   //       NotificationDetails(android: androidDetails);
//   //   await localNotifications.show(0, 'Order Conformed',
//   //       'something behind the info', generalNotificationetails);
//   // }

//   // Future _shownotification3() async {
//   //   var androidDetails = AndroidNotificationDetails(
//   //       'channelId', 'channelName', 'channelDescription',
//   //       importance: Importance.high);
//   //   var generalNotificationetails =
//   //       NotificationDetails(android: androidDetails);
//   //   await localNotifications.show(0, 'Order Completed',
//   //       'something behind the info', generalNotificationetails);
//   // }
// }
