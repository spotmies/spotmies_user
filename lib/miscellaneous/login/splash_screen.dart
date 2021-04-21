// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spotmies/home/navbar.dart';
// import 'package:spotmies/login/onboard.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(Duration(seconds: 5), () {
//       if (FirebaseAuth.instance.currentUser != null) {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (_) => GoogleNavBar()),
//             (route) => false);
//       } else {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (_) => OnboardingScreen()),
//             (route) => false);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.blue[900],
//                 radius: 50,
//                 child: Center(
//                     child: Icon(
//                   Icons.location_on,
//                   color: Colors.white,
//                   size: 40,
//                 )),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Spot',
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.blue[900],
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'mies',
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

// //Second Splash Screen

// // class SplashScreen2 extends StatefulWidget {
// //   final String value;
// //   SplashScreen2({this.value});
// //   @override
// //   _SplashScreen2State createState() => _SplashScreen2State(value);
// // }

// // class _SplashScreen2State extends State<SplashScreen2> {
// //   var path = FirebaseFirestore.instance
// //       .collection('users')
// //       .doc(FirebaseAuth.instance.currentUser.uid)
// //       .get();

// //   String value;
// //   _SplashScreen2State(this.value);
// //   @override
// //   void initState() {
// //     super.initState();

// //     Timer(Duration(seconds: 4), () async {
// //       (path == null)
// //           ? Navigator.pushAndRemoveUntil(
// //               context,
// //               MaterialPageRoute(builder: (_) => Terms(value: value)),
// //               (route) => false)
// //           : Navigator.pushAndRemoveUntil(
// //               context,
// //               MaterialPageRoute(builder: (_) => GoogleNavBar()),
// //               (route) => false);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final _hight = MediaQuery.of(context).size.height -
// //         MediaQuery.of(context).padding.top -
// //         kToolbarHeight;
// //     final _width = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //         backgroundColor: Colors.white,
// //         body: Column(
// //           children: [
// //             Container(
// //               height: _hight * 0.85,
// //               width: _width * 1,
// //               child: Center(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     CircleAvatar(
// //                       backgroundColor: Colors.blue[900],
// //                       radius: 50,
// //                       child: Center(
// //                           child: Icon(
// //                         Icons.location_on,
// //                         color: Colors.white,
// //                         size: 40,
// //                       )),
// //                     ),
// //                     SizedBox(
// //                       height: 10,
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Text(
// //                           'Spot',
// //                           style: TextStyle(
// //                               fontSize: 30,
// //                               color: Colors.blue[900],
// //                               fontWeight: FontWeight.bold),
// //                         ),
// //                         Text(
// //                           'mies',
// //                           style: TextStyle(
// //                               fontSize: 30,
// //                               color: Colors.orange,
// //                               fontWeight: FontWeight.bold),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             Container(
// //               height: _hight * 0.15,
// //               width: _width * 1,
// //               child: Column(
// //                 children: [
// //                   CircularProgressIndicator(),
// //                   SizedBox(
// //                     height: _hight * 0.02,
// //                   ),
// //                   Text('Please wait fetching data'),
// //                 ],
// //               ),
// //             )
// //           ],
// //         ));
// //   }
// // }
