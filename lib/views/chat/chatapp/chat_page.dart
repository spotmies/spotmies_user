// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:spotmies/utilities/appConfig.dart';
// import 'package:spotmies/views/chat/chatapp/chat_screen.dart';
// import 'package:spotmies/controllers/chat_controllers/chatPage_controller.dart';

// class ChatHome extends StatefulWidget {
//   @override
//   _ChatHomeState createState() => _ChatHomeState();
// }

// class _ChatHomeState extends StateMVC<ChatHome> {
//   late ChatPageController _chatPageController;
//   _ChatHomeState() : super(ChatPageController()) {
//     this._chatPageController = controller as ChatPageController;
//   }
//   late String value;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _chatPageController.scaffoldkey,
//         body: Container(
//           height: height(context) * 1,
//           width: width(context) * 1,
//           child: Column(
//             children: [
//               StreamBuilder<QuerySnapshot>(
//                   stream: _chatPageController.chatPageStream,
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
//                         children: snapshot.data != null
//                             ? snapshot.data!.docs.map((document) {
//                                 List<String> msgs = List.from(document['body']);
//                                 String msgid = document['id'];
//                                 return Column(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         _chatPageController.uread(msgid);
//                                         Navigator.of(context)
//                                             .push(MaterialPageRoute(
//                                           builder: (context) => ChatScreen(
//                                             value: msgid,
//                                           ),
//                                         ));
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.all(10),
//                                         height: height(context) * 0.14,
//                                         width: width(context) * 0.95,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   color: Colors.grey.shade300,
//                                                   blurRadius: 2,
//                                                   spreadRadius: 1,
//                                                   offset: Offset(3, 3)),
//                                               BoxShadow(
//                                                   color: Colors.grey.shade50,
//                                                   blurRadius: 2,
//                                                   spreadRadius: 2,
//                                                   offset: Offset(-3, -3))
//                                             ]),
//                                         child: ListView.builder(
//                                             controller: _chatPageController
//                                                 .scrollController,
//                                             itemCount: 1,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
//                                               // print(document['pmsgcount'].toString());
//                                               String msgData = msgs.last;
//                                               var data = jsonDecode(msgData);
//                                               return Row(
//                                                 children: [
//                                                   CircleAvatar(
//                                                     child: ClipOval(
//                                                       child: document['ppic'] ==
//                                                               null
//                                                           ? Icon(
//                                                               Icons.person,
//                                                               color: Colors
//                                                                   .blueGrey,
//                                                               size: 40,
//                                                             )
//                                                           : Image.network(
//                                                               document['ppic'],
//                                                               fit: BoxFit.cover,
//                                                               width:
//                                                                   MediaQuery.of(
//                                                                           context)
//                                                                       .size
//                                                                       .width,
//                                                             ),
//                                                     ),
//                                                     backgroundColor:
//                                                         Colors.black,
//                                                   ),
//                                                   // SizedBox(
//                                                   //   width: 20,
//                                                   // ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: width(context) *
//                                                             0.04,
//                                                         right: width(context) *
//                                                             0.04,
//                                                         top: width(context) *
//                                                             0.02,
//                                                         bottom: width(context) *
//                                                             0.02),
//                                                     // color: Colors.amber,
//                                                     width:
//                                                         width(context) * 0.69,
//                                                     height:
//                                                         height(context) * 0.12,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(document[
//                                                                         'uname'] ==
//                                                                     null
//                                                                 ? 'User'
//                                                                 : document[
//                                                                     'uname']),
//                                                             data['msg']
//                                                                     .startsWith(
//                                                                         'https')
//                                                                 ? Row(
//                                                                     children: [
//                                                                       Icon(
//                                                                           Icons
//                                                                               .image,
//                                                                           color: document['umsgcount'] > 0
//                                                                               ? Colors.black
//                                                                               : Colors.grey[500]),
//                                                                       Text(
//                                                                         'image',
//                                                                         style: TextStyle(
//                                                                             fontWeight: FontWeight
//                                                                                 .bold,
//                                                                             color: document['umsgcount'] > 0
//                                                                                 ? Colors.black
//                                                                                 : Colors.grey[500]),
//                                                                       ),
//                                                                     ],
//                                                                   )
//                                                                 : SizedBox(
//                                                                     width: width(
//                                                                             context) *
//                                                                         0.3,
//                                                                     child: Text(
//                                                                       data[
//                                                                           'msg'],
//                                                                       overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis,
//                                                                       maxLines:
//                                                                           1,
//                                                                       softWrap:
//                                                                           false,
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight
//                                                                               .bold,
//                                                                           color: document['pmsgcount'] > 0
//                                                                               ? Colors.black
//                                                                               : Colors.grey[500]),
//                                                                     ),
//                                                                   )
//                                                           ],
//                                                         ),
//                                                         Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceEvenly,
//                                                           children: [
//                                                             Text(DateFormat.jm()
//                                                                 .format(DateTime
//                                                                     .fromMillisecondsSinceEpoch(
//                                                                         (int.parse(
//                                                                             data['timestamp'].toString()))))),
//                                                             Container(
//                                                               child: document[
//                                                                           'umsgcount'] >
//                                                                       0
//                                                                   ? CircleAvatar(
//                                                                       backgroundColor:
//                                                                           Colors
//                                                                               .amber,
//                                                                       radius:
//                                                                           13,
//                                                                       child:
//                                                                           Text(
//                                                                         document['umsgcount']
//                                                                             .toString(),
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.white),
//                                                                       ),
//                                                                     )
//                                                                   : null,
//                                                             )
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               );
//                                             }),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 );
//                               }).toList()
//                             : [],
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ));
//   }
// }
