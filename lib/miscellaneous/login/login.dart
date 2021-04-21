// import 'package:flutter/material.dart';
// import 'package:spotmies/login/otp.dart';



// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController loginnum = TextEditingController();
  
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: ListView(children: [
//           Form(
//             key: _formkey,
//             child: Container(
//               height: _hight * 1,
//               width: _width * 1,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           height: _hight * 0.1,
//                         ),
//                         Container(
//                             height: _hight * 0.35,
//                             child: Image.asset('lib/assets/7.png')),
//                         // CircleAvatar(
//                         //   backgroundColor: Colors.white,
//                         //   radius: 50,
//                         //   child: Center(
//                         //       child: Icon(
//                         //     Icons.mobile_screen_share,
//                         //     color: Colors.blue[800],
//                         //     size: 40,
//                         //   )),
//                         // ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           height: _hight * 0.3,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.all(4),
//                                 constraints: BoxConstraints(
//                                     minHeight: _hight * 0.10,
//                                     maxHeight: _hight * 0.13),
//                                 margin:
//                                     EdgeInsets.only(top: 0, right: 5, left: 5),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   borderRadius: BorderRadius.circular(15),
//                                   // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 0)]
//                                 ),
//                                 child: Container(
//                                   margin: EdgeInsets.only(
//                                       top: 0, right: 5, left: 5),
//                                   padding: EdgeInsets.all(2),
//                                   // height: 80,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15),
//                                     // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 0)]
//                                   ),
//                                   child: TextFormField(
//                                     // maxLength: 10,
//                                     decoration: InputDecoration(
//                                       border: new OutlineInputBorder(
//                                           borderSide: new BorderSide(
//                                               color: Colors.white),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       suffixIcon: Icon(
//                                         Icons.phone_android,
//                                         color: Colors.blue[800],
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               width: 1, color: Colors.white)),
//                                       enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                           borderSide: BorderSide(
//                                               width: 1, color: Colors.white)),
//                                       hintStyle: TextStyle(fontSize: 17),
//                                       hintText: 'Phone Number',
//                                       prefix: Padding(
//                                         padding: EdgeInsets.all(4),
//                                         child: Text('+91'),
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value.isEmpty ||
//                                           value.length < 10 ||
//                                           value.length > 10) {
//                                         return 'Please Enter Valid Mobile Number';
//                                       }
//                                       return null;
//                                     },
//                                     //maxLength: 10,
//                                     keyboardType: TextInputType.number,
//                                     controller: loginnum,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 'Enter Your Number To Verify Your Mobile',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 'Eg.1234567890',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.grey[500],
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ]),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: _width * 0.6,
//                     height: _hight * 0.06,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),

//                       //border: Border.all(color: Colors.blue[700]),
//                       //color: Colors.blue[800],
//                     ),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.blue[900])),
//                       // color: Colors.blue[800],
//                       // shape: RoundedRectangleBorder(
//                       //     borderRadius: BorderRadius.circular(5.0)),
//                       onPressed: () {
//                         if (_formkey.currentState.validate()) {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => OTPScreen(loginnum.text)));
//                         }
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Verify',
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Icon(
//                             Icons.verified_user,
//                             color: Colors.lightGreen,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]));
//   }
// }
