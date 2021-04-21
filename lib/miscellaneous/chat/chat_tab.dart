// import 'package:flutter/material.dart';
// import 'package:spotmies/chat/chatapp/chat_page.dart';
// import 'package:spotmies/chat/response.dart';

// class Chat extends StatefulWidget {
//   @override
//   _ChatState createState() => _ChatState();
// }

// class _ChatState extends State<Chat> {
//   var list = [
//     Center(
//       child: Responsee(),
//     ),
//     Center(
//       child: ChatHome(),
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(0),
//               ),
//             ),
//             toolbarHeight: 48,
//             backgroundColor: Colors.blue[800],
//             elevation: 0,
//             bottom: TabBar(
//                 indicator: UnderlineTabIndicator(
//                     borderSide: BorderSide(
//                       color: Colors.amber,
//                       width: 3.0,
//                     ),
//                     insets: EdgeInsets.symmetric(horizontal: 45.0)),
//                 indicatorColor: Colors.white,
//                 tabs: [
//                   Tab(
//                     icon: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Responses',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         // GestureDetector(
//                         //   onTap: () {
//                         //     setState(() {
//                         //       _radius = !_radius;
//                         //     });
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ),
//                   Tab(
//                     icon: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         //Icon(Icons.chat, color: Colors.blue[900]),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           'Chat',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         //  GestureDetector(
//                         //   onTap: () {
//                         //     setState(() {
//                         //       _radius = !_radius;
//                         //     });
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ),
//                   // Tab(
//                   //   //icon: Icon(Icons.feedback),
//                   //   text: 'responce',
//                   // ),
//                 ]),
//           ),
//           body: TabBarView(children: list),
//         ));
//   }
// }
