import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/navBar.dart';
import 'package:spotmies/views/login/onboard.dart';

import 'login_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      bool resp =
          await checkUserRegistered(FirebaseAuth.instance.currentUser.uid);
      if (resp != false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => GoogleNavBar()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OnboardingScreen()),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => OnboardingScreen()),
          (route) => false);
    }
    
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () {
      // print("18 ${FirebaseAuth.instance.currentUser}");
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: _hight * 0.1,
              // ),
              Container(
                  height: _hight * 0.23,
                  // width: 150,
                  child: Lottie.asset('assets/spotmies_logo.json')),
              SizedBox(
                height: _hight * 0.15,
              ),
              Column(
                children: [
                  TextWidget(
                      text: 'SPOTMIES',
                      size: _width * 0.08,
                      color: Colors.indigo[900],
                      lSpace: 6.0,
                      weight: FontWeight.w600),
                  TextWidget(
                      text: 'Experience the Excellence',
                      size: _width * 0.05,
                      color: Colors.grey[700],
                      weight: FontWeight.w500),
                  // SizedBox(
                  //   height: _hight * 0.1,
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}




// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spotmies/views/home/navBar.dart';
// import 'package:spotmies/views/login/onboard.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(Duration(seconds: 5), () {
//       // print("18 ${FirebaseAuth.instance.currentUser}");
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









