import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/apiCalls/apiCalling.dart';
import 'package:spotmies/apiCalls/apiUrl.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/shared_preference.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/home/navBar.dart';
import 'package:spotmies/views/login/onboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UniversalProvider universalProvider;
  bool loading = false;
  checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => OnboardingScreen()),
          (route) => false);
    }
  }

  getConstants({bool alwaysHit = false}) async {
    if (alwaysHit == false) {
      dynamic constantsFromSf = await await getAppConstants();
      if (constantsFromSf != null) {
        universalProvider.setAllConstants(constantsFromSf);

        log("constants already in sf");
        return;
      }
    }

    dynamic appConstants = await constantsAPI();
    if (appConstants != null) {
      universalProvider.setAllConstants(appConstants);
      // snackbar(context, "new settings imported");
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    universalProvider = Provider.of<UniversalProvider>(context, listen: false);

    Timer(Duration(milliseconds: 500), () async {
      // print("18 ${FirebaseAuth.instance.currentUser}");
      setState(() {
        loading = true;
      });
      await getConstants(alwaysHit: false);
      await universalProvider.fetchServiceList(alwaysHit: false);
      setState(() {
        loading = false;
      });
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
        backgroundColor: SpotmiesTheme.background,
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
                      color: SpotmiesTheme.primary,
                      lSpace: 6.0,
                      weight: FontWeight.w600),
                  TextWidget(
                      text: 'Experience the Excellence',
                      size: _width * 0.05,
                      color: SpotmiesTheme.secondary,
                      weight: FontWeight.w500),
                  // SizedBox(
                  //   height: _hight * 0.1,
                  // ),
                ],
              ),
              SizedBox(
                height: _hight * 0.05,
              ),
              loading
                  ? CircularProgressIndicator(
                      strokeWidth: 4.0,
                      backgroundColor: SpotmiesTheme.background,
                    )
                  : Container(
                      height: _hight * 0.01,
                    ),
            ],
          ),
        ));
  }
}

constantsAPI() async {
  dynamic response = await Server().getMethod(API.cloudConstants);
  if (response.statusCode == 200) {
    dynamic appConstants = jsonDecode(response?.body);
    log(appConstants.toString());
    setAppConstants(appConstants);
    dynamic currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      log("confirming all costanst downloaded");

      /* -------------- CONFIRM ALL CONSTANTS AND SETTINGS DOWNLOADED ------------- */
      Map<String, String> body = {"appConfig": "false"};
      Server()
          .editMethod(API.editPersonalInfo + currentUser.uid.toString(), body);
    }
    return appConstants;
  } else {
    log("something went wrong status code ${response.statusCode}");
    return null;
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









