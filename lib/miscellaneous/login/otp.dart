import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:spotmies/views/login/stepperPersonalInfo.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.white,
    //const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.white,
      //const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('OTP Verification'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Center(
                      child: Icon(
                    Icons.message,
                    color: Colors.blue[800],
                    size: 40,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter One Time Password You recieved to Verify',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  '+91 ${widget.phone}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle:
                  const TextStyle(fontSize: 25.0, color: Colors.blueGrey),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      // if(FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).)
                      print(widget.phone);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepperPersonalInfo(
                                  //value: widget.phone,
                                  )),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  // _scaffoldkey.currentState
                  //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StepperPersonalInfo(
                          //value: '+91${widget.phone}'
                          )),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    // implement initstate
    super.initState();
    _verifyPhone();
  }
}

// class Terms extends StatefulWidget {
//   final String value;
//   Terms({this.value});
//   @override
//   _TermsState createState() => _TermsState(value);
// }

// class _TermsState extends State<Terms> {
//   bool accept = false;
//   String tca;

//   String value;
//   _TermsState(this.value);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Terms & Conditions',
//           style: TextStyle(color: Colors.grey[800]),
//         ),
//         backgroundColor: Colors.grey[50],
//         elevation: 1,
//       ),
//       backgroundColor: Colors.grey[50],
//       body: Center(
//         child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('terms')
//                 .doc('eXiU3vxjO7qeVObTqvmQ')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData)
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               var document = snapshot.data;
//               return Container(
//                   padding: EdgeInsets.all(30),
//                   child: Container(
//                     height: 600,
//                     width: 350,
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[300],
//                             blurRadius: 1,
//                             //spreadRadius: 2
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(15)),
//                     child: ListView(children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '1.' + document['1'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '2.' + document['2'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '3.' + document['3'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '4.' + document['4'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '5.' + document['5'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '6.' + document['6'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '7.' + document['7'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Text(
//                             '8.' + document['8'],
//                             style: TextStyle(fontSize: 20),
//                           ),
//                           Row(
//                             children: [
//                               Checkbox(
//                                   value: accept,
//                                   onChanged: (bool value) {
//                                     setState(
//                                       () {
//                                         accept = value;
//                                         if (accept == true) {
//                                           tca = 'accepted';
//                                         }
//                                       },
//                                     );
//                                   }),
//                               Text(
//                                   'I agree to accept the terms and Conditions'),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               (accept == true)
//                                   ? ElevatedButton(
//                                       child: Text(
//                                         'accept',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       //color: Colors.blue,
//                                       onPressed: () {
//                                         print(value);
//                                         FirebaseFirestore.instance
//                                             .collection('users')
//                                             .doc(FirebaseAuth
//                                                 .instance.currentUser.uid)
//                                             .set({
//                                           'joinedat': DateTime.now(),
//                                           'name': null,
//                                           'email': null,
//                                           'profilepic': null,
//                                           'phone': '+91$value',
//                                           'altNum': null,
//                                           'terms&Conditions': tca,
//                                           'reference': 0,
//                                           'uid': FirebaseAuth
//                                               .instance.currentUser.uid
//                                         });

//                                         if (accept == true) {
//                                           Navigator.pushAndRemoveUntil(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       PersonalInfo()),
//                                               (route) => false);
//                                         }
//                                       })
//                                   : Container(height: 10, color: Colors.white)
//                             ],
//                           )
//                         ],
//                       ),
//                     ]),
//                   ));
//             }),
//       ),
//     );
//   }
// }
