// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:spotmies/chat/chatapp/chat_screen.dart';

// var partnerid;
// var pid;
// void getDatails() async {
//   QuerySnapshot getOrderDetails;

//   getOrderDetails = await FirebaseFirestore.instance
//       .collection('partner')
//       .doc()
//       .collection('profileInfo')
//       .get();

//   partnerid = getOrderDetails.docs[0]['userid'];
// }

// class Responsee extends StatefulWidget {
//   @override
//   _ResponseeState createState() => _ResponseeState();
// }

// class _ResponseeState extends State<Responsee> {
//   String value;
//   @override
//   void initState() {
//     super.initState();
//     //address

//     //for notifications
//     var androidInitialize = AndroidInitializationSettings('asdf');
//     var initializesettings = InitializationSettings(android: androidInitialize);
//     localNotifications = FlutterLocalNotificationsPlugin();
//     localNotifications.initialize(initializesettings);
//   }

//   FlutterLocalNotificationsPlugin localNotifications;

//   Future _shownotification() async {
//     var androidDetails = AndroidNotificationDetails(
//         'channelId', 'channelName', 'channelDescription',
//         importance: Importance.high);
//     var generalNotificationetails =
//         NotificationDetails(android: androidDetails);
//     await localNotifications.show(0, 'orderState', 'something behind the info',
//         generalNotificationetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       //backgroundColor: Colors.blue[900],
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(FirebaseAuth.instance.currentUser.uid)
//               .collection('response')
//               .where('orderstate', isEqualTo: 0)
//               .snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData)
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             return Container(
//               child: ListView(
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.all(20),
//                 children: snapshot.data.docs.map((document) {
//                   String msgid = document['msgid'];
//                   document['orderstate'] == null
//                       ? _shownotification()
//                       : print('object');
//                   return Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => ChatScreen(value: msgid),
//                           ));
//                           CircularProgressIndicator();
//                           FirebaseFirestore.instance
//                               .collection('messaging')
//                               .doc(document['msgid'])
//                               .update({
//                             'uname': 'name',
//                             'userid': FirebaseAuth.instance.currentUser.uid,
//                             'upic':
//                                 'https://images.indulgexpress.com/uploads/user/imagelibrary/2020/1/25/original/MaheshBabuSourceInternet.jpg'
//                           });
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(20),
//                           height: _hight * 0.2,
//                           width: _width * 1,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20.0),
//                               boxShadow: kElevationToShadow[0]),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               CircleAvatar(
//                                 backgroundImage: NetworkImage(document['ppic']),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     //'',
//                                     document['pname'] == null
//                                         ? 'technician'
//                                         : document['pname'].toString(),
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         decoration: TextDecoration.underline),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(document['job'].toString() + ' | ',
//                                           style: TextStyle(fontSize: 8)),
//                                       Row(
//                                         children: [
//                                           Text(document['rating'].toString(),
//                                               style: TextStyle(fontSize: 8)),
//                                           Icon(
//                                             Icons.star,
//                                             size: 8,
//                                             color: Colors.amber,
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     width: _width * 0.635,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Container(
//                                           width: _width * 0.3,
//                                           height: _hight * 0.05,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text('Money :   ' +
//                                                   document['pmoney']
//                                                       .toString()),
//                                               // SizedBox(
//                                               //   width: 60,
//                                               // ),
//                                               Text('Away :   ' +
//                                                   document['distance']
//                                                       .toString() +
//                                                   'KM'),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: _width * 0.3,
//                                           height: _hight * 0.05,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text('Time :   ' +
//                                                   document['scheduletime']),
//                                               Text('Date :   ' +
//                                                   document['scheduledate'])
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     width: _width * 0.63,
//                                     alignment: Alignment.center,
//                                     child: Text('Tap to chat',
//                                         style: TextStyle(
//                                           color: Colors.grey[300],
//                                         )),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             );
//           }),
//     );
//   }
// }

// // class ChatScreen extends StatefulWidget {
// //   @override
// //   _ChatScreenState createState() => _ChatScreenState();
// // }

// // class _ChatScreenState extends State<ChatScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.amber,
// //       appBar: AppBar(
// //         backgroundColor: Colors.blue[800],
// //         title: StreamBuilder(
// //             stream: FirebaseFirestore.instance
// //                 .collection('messaging')
// //                 .doc(msgid)
// //                 .snapshots(),
// //             builder: (context, snapshot) {
// //               var document = snapshot.data;
// //               return Text(document['name']);
// //             }),
// //       ),
// //     );
// //   }
// // }
