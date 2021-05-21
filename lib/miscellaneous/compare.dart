// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:spotmies/miscellaneous/chat/chatapp/chat_screen.dart';
// import 'package:spotmies/miscellaneous/profile/settings.dart';

// class ChatHome extends StatefulWidget {
//   @override
//   _ChatHomeState createState() => _ChatHomeState();
// }

// class _ChatHomeState extends State<ChatHome> {
//   ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 icon: Icon(
//                   Icons.person_pin_rounded,
//                   size: 27,
//                   color: Colors.blue[900],
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Setting()));
//                 })
//           ],
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Text('Conversations',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold)),
//         ),
//         body: Container(
//           height: _hight * 1,
//           width: _width * 1,
//           child: Column(
//             children: [
//               StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('messaging')
//                       .where('partnerid',
//                           isEqualTo: FirebaseAuth.instance.currentUser.uid)
//                       // .orderBy('createdAt', descending: true)
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (!snapshot.hasData)
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     return Expanded(
//                       child: ListView(
//                         scrollDirection: Axis.vertical,
//                         padding: EdgeInsets.all(20),
//                         children: snapshot.data.docs.map((document) {
//                           List<String> msgs = List.from(document['body']);

//                           var msgid = document['id'];
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   print('$msgid');
//                                   FirebaseFirestore.instance
//                                       .collection('messaging')
//                                       .doc(msgid)
//                                       .update({'pstatus': 1, 'pmsgcount': 0});
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => ChatScreen(
//                                       value: msgid,
//                                     ),
//                                   ));
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   height: _hight * 0.14,
//                                   width: _width * 0.95,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                       boxShadow: kElevationToShadow[0]),
//                                   child: ListView.builder(
//                                       controller: _scrollController,
//                                       itemCount: 1,
//                                       itemBuilder:
//                                           (BuildContext ctxt, int index) {
//                                         String msgData = msgs.last;
//                                         var data = jsonDecode(msgData);
//                                         return Row(
//                                           children: [
//                                             CircleAvatar(
//                                               child: ClipOval(
//                                                 child: document['upic'] == null
//                                                     ? Icon(
//                                                         Icons.person,
//                                                         color: Colors.black,
//                                                         size: 30,
//                                                       )
//                                                     : Image.network(
//                                                         document['upic'],
//                                                         fit: BoxFit.cover,
//                                                         width: MediaQuery.of(
//                                                                 context)
//                                                             .size
//                                                             .width,
//                                                       ),
//                                               ),
//                                               backgroundColor: Colors.grey[100],
//                                             ),
//                                             SizedBox(
//                                               width: 20,
//                                             ),
//                                             Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 20,
//                                                   right: 20,
//                                                   top: 10,
//                                                   bottom: 10),
//                                               // color: Colors.amber,
//                                               width: _width * 0.69,
//                                               height: _hight * 0.12,
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(document['uname'] ==
//                                                               null
//                                                           ? 'User'
//                                                           : document['uname']),
//                                                       data['msg'].startsWith(
//                                                               'https')
//                                                           ? Row(
//                                                               children: [
//                                                                 Icon(
//                                                                     Icons.image,
//                                                                     color: document['pmsgcount'] >
//                                                                             0
//                                                                         ? Colors
//                                                                             .black
//                                                                         : Colors
//                                                                             .grey[500]),
//                                                                 Text(
//                                                                   'image',
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: document['pmsgcount'] > 0
//                                                                           ? Colors
//                                                                               .black
//                                                                           : Colors
//                                                                               .grey[500]),
//                                                                 ),
//                                                               ],
//                                                             )
//                                                           : Text(
//                                                               data['msg'],
//                                                               style: TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: document[
//                                                                               'pmsgcount'] >
//                                                                           0
//                                                                       ? Colors
//                                                                           .black
//                                                                       : Colors.grey[
//                                                                           500]),
//                                                             )
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     children: [
//                                                       Text(DateFormat.jm().format(
//                                                           DateTime.fromMillisecondsSinceEpoch(
//                                                               (int.parse(data[
//                                                                   'timestamp']))))),
//                                                       Container(
//                                                         child: document[
//                                                                     'pmsgcount'] >
//                                                                 0
//                                                             ? CircleAvatar(
//                                                                 backgroundColor:
//                                                                     Colors
//                                                                         .amber,
//                                                                 radius: 13,
//                                                                 child: Text(
//                                                                   document[
//                                                                           'pmsgcount']
//                                                                       .toString(),
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               )
//                                                             : null,
//                                                       )
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         );
//                                       }),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ));
//   }
// }
