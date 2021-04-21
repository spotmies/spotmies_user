// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:spotmies/home/home.dart';
// import 'package:spotmies/chat/chat_tab.dart';
// import 'package:spotmies/posts/posts.dart';
// import 'package:spotmies/profile/profile.dart';

// void main() => runApp(GoogleNavBar());

// class GoogleNavBar extends StatefulWidget {
//   @override
//   _GoogleNavBarState createState() => _GoogleNavBarState();
// }

// class _GoogleNavBarState extends State<GoogleNavBar> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     Center(
//       child: Home(),
//     ),
//     Center(
//       child: Chat(),
//     ),
//     Center(
//       child: PostList(),
//     ),
//     Center(
//       child: Profile(),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       //title:"Google NavBar",
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Google NavBar'),
//         // ),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(color: Colors.white, boxShadow: [
//             BoxShadow(blurRadius: 0, color: Colors.black.withOpacity(.1)),
//           ]),
//           child: SafeArea(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//               child: GNav(
//                   gap: 8,
//                   activeColor: Colors.grey[800],
//                   iconSize: 24,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                   duration: Duration(milliseconds: 2),
//                   tabBackgroundColor: Colors.white,
//                   tabs: [
//                     GButton(
//                       icon: Icons.home,
//                       text: 'Home',
//                       iconColor: Colors.grey,
//                     ),
//                     GButton(
//                       icon: Icons.chat,
//                       text: 'Chat',
//                       iconColor: Colors.grey,
//                     ),
//                     GButton(
//                       icon: Icons.explore,
//                       text: 'Orders',
//                       iconColor: Colors.grey,
//                     ),
//                     GButton(
//                       icon: Icons.person,
//                       text: 'Profile',
//                       iconColor: Colors.grey,
//                     ),
//                   ],
//                   selectedIndex: _selectedIndex,
//                   onTabChange: (index) {
//                     setState(() {
//                       _selectedIndex = index;
//                     });
//                   }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
