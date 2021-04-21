// import 'dart:async';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:spotmies/home/navbar.dart';

// TextEditingController nameTf = TextEditingController();
// TextEditingController dobTf = TextEditingController();
// TextEditingController emailTf = TextEditingController();
// TextEditingController numberTf = TextEditingController();
// TextEditingController altnumberTf = TextEditingController();
// TextEditingController peradTf = TextEditingController();
// TextEditingController tempadTf = TextEditingController();
// TextEditingController experienceTf = TextEditingController();
// TextEditingController businessNameTf = TextEditingController();
// ScrollController _scrollController = ScrollController();

// class StepperPersonalInfo extends StatefulWidget {
//   @override
//   _StepperPersonalInfoState createState() => _StepperPersonalInfoState();
// }

// class _StepperPersonalInfoState extends State<StepperPersonalInfo> {
//   int _currentStep = 0;
//   String name;
//   String email;
//   String number;
//   String altnumber;
//   bool accept = false;
//   String tca;
//   File _profilepic;
//   String imageLink3 = "";
//   DateTime now = DateTime.now();
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           'Create account',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.grey[50],
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[50],
//       body: Theme(
//         data: ThemeData(primaryColor: Colors.blue[900]),
//         child: Stepper(
//             type: StepperType.horizontal,
//             currentStep: _currentStep,
//             onStepTapped: (int step) => setState(() => _currentStep = step),
//             controlsBuilder: (BuildContext context,
//                 {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Container(
//                       width: _width * 0.35,
//                       child: ElevatedButton(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Icon(Icons.navigate_before),
//                             Text('Back'),
//                           ],
//                         ),
//                         onPressed: onStepCancel,
//                         style: ButtonStyle(
//                           backgroundColor: _currentStep > 0
//                               ? MaterialStateProperty.all(Colors.blue[900])
//                               : MaterialStateProperty.all(Colors.white),
//                         ),
//                       ),
//                     ),
//                     _currentStep == 2 // this is the last step
//                         ? Container(
//                             width: _width * 0.35,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 await uploadimage();
//                                 Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => GoogleNavBar()),
//                                     (route) => false);
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text('Finish'),
//                                   Icon(Icons.navigate_next),
//                                 ],
//                               ),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(Colors.blue[900]),
//                               ),
//                               //color: Colors.green,
//                             ),
//                           )
//                         : Container(
//                             width: _width * 0.35,
//                             child: ElevatedButton(
//                               onPressed: onStepContinue,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text('Next'),
//                                   Icon(Icons.navigate_next),
//                                 ],
//                               ),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all(Colors.blue[900]),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               );
//             },
//             onStepContinue: _currentStep == 0
//                 ? () => setState(() => step1())
//                 : _currentStep == 1
//                     ? () => setState(() => step2())
//                     : _currentStep == 2
//                         ? () => setState(() => step3())
//                         : null,
//             onStepCancel: _currentStep > 0
//                 ? () => setState(() => _currentStep -= 1)
//                 : null,
//             steps: <Step>[
//               Step(
//                 title: Text('Step1'),
//                 subtitle: Text('Terms'),
//                 content: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       height: _hight * 0.75,
//                       child: StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('terms')
//                               .doc('eXiU3vxjO7qeVObTqvmQ')
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData)
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             var document = snapshot.data;
//                             return ListView(
//                                 controller: _scrollController,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         '1. ' + document['1'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '2.' + document['2'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '3.' + document['3'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '4.' + document['4'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '5.' + document['5'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '6.' + document['6'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '7.' + document['7'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Text(
//                                         '8.' + document['8'],
//                                         style: TextStyle(fontSize: 20),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Checkbox(
//                                               activeColor: Colors.white,
//                                               checkColor: Colors.lightGreen,
//                                               value: accept,
//                                               onChanged: (bool value) {
//                                                 setState(
//                                                   () {
//                                                     accept = value;
//                                                     if (accept == true) {
//                                                       tca = 'accepted';
//                                                     }
//                                                   },
//                                                 );
//                                               }),
//                                           Text(
//                                               'I agree to accept the terms and Conditions'),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ]);
//                           }),
//                     ),
//                   ],
//                 ),
//                 isActive: _currentStep >= 0,
//                 state:
//                     _currentStep >= 0 ? StepState.complete : StepState.disabled,
//               ),
//               Step(
//                 title: Text('Step 2'),
//                 subtitle: Text('Profile'),
//                 content: Form(
//                   key: _formkey,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: _hight * 0.75,
//                         child: ListView(
//                           children: [
//                             Container(
//                               // padding: EdgeInsets.all(10),
//                               height: _hight * 0.1,
//                               width: _width * 1,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: TextFormField(
//                                 keyboardType: TextInputType.name,
//                                 controller: nameTf,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   hintStyle: TextStyle(
//                                       fontSize: 17, color: Colors.grey),
//                                   hintText: 'Name',
//                                   suffixIcon: Icon(Icons.person),
//                                   //border: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(20),
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return 'Please Enter Your Name';
//                                   }
//                                   return null;
//                                 },
//                                 onChanged: (value) {
//                                   this.name = value;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 7,
//                             ),
//                             Container(
//                               //padding: EdgeInsets.all(10),
//                               height: _hight * 0.1,
//                               width: _width * 1,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: TextFormField(
//                                 keyboardType: TextInputType.emailAddress,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   hintStyle: TextStyle(
//                                       fontSize: 17, color: Colors.grey),
//                                   hintText: 'Email',
//                                   suffixIcon: Icon(Icons.email),
//                                   //border: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(20),
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty || !value.contains('@')) {
//                                     return 'Please Enter Valid Email';
//                                   }
//                                   return null;
//                                 },
//                                 controller: emailTf,
//                                 onChanged: (value) {
//                                   this.email = value;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 7,
//                             ),
//                             Container(
//                               //padding: EdgeInsets.all(10),
//                               height: _hight * 0.1,
//                               width: _width * 1,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: TextFormField(
//                                 keyboardType: TextInputType.phone,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   hintStyle: TextStyle(
//                                       fontSize: 17, color: Colors.grey),
//                                   hintText: 'Mobile Number',
//                                   suffixIcon: Icon(Icons.dialpad),
//                                   //border: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(20),
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty || value.length < 10) {
//                                     return 'Please Enter Valid Mobile Number';
//                                   }
//                                   return null;
//                                 },
//                                 controller: numberTf,
//                                 onChanged: (value) {
//                                   this.number = value;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 7,
//                             ),
//                             Container(
//                               //padding: EdgeInsets.all(10),
//                               height: _hight * 0.1,
//                               width: _width * 1,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: TextFormField(
//                                 keyboardType: TextInputType.phone,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(15)),
//                                       borderSide: BorderSide(
//                                           width: 1, color: Colors.white)),
//                                   hintStyle: TextStyle(
//                                       fontSize: 17, color: Colors.grey),
//                                   hintText: 'Alternative Mobile Number',
//                                   suffixIcon: Icon(Icons.dialpad),
//                                   //border: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(20),
//                                 ),
//                                 validator: (value) {
//                                   if (value.isEmpty || value.length < 10) {
//                                     return 'Please Enter Valid Mobile Number';
//                                   }
//                                   return null;
//                                 },
//                                 controller: altnumberTf,
//                                 onChanged: (value) {
//                                   this.altnumber = value;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 isActive: _currentStep >= 1,
//                 state:
//                     _currentStep >= 1 ? StepState.complete : StepState.disabled,
//               ),
//               Step(
//                 title: Text('Step 3'),
//                 subtitle: Text('Photo'),
//                 content: Column(
//                   children: [
//                     Container(
//                       height: _hight * 0.75,
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Profile Picture',
//                               style: TextStyle(fontSize: 25),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Center(
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 height: 220,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(30),
//                                       topRight: Radius.circular(30)),
//                                   // border: Border.all()
//                                 ),
//                                 child: CircleAvatar(
//                                   child: Center(
//                                     child: _profilepic == null
//                                         ? Icon(
//                                             Icons.person,
//                                             color: Colors.blueGrey,
//                                             size: 200,
//                                           )
//                                         : Container(
//                                             height: _hight * 0.27,
//                                             decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 image: DecorationImage(
//                                                     fit: BoxFit.fill,
//                                                     image: FileImage(
//                                                         _profilepic))),
//                                             // child: Image.file(
//                                             //   _profilepic,
//                                             //   fit: BoxFit.cover,
//                                             //   width: MediaQuery.of(context)
//                                             //       .size
//                                             //       .width,
//                                             // ),
//                                           ),
//                                   ),
//                                   radius: 30,
//                                   backgroundColor: Colors.grey[100],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 40,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(30),
//                                     bottomRight: Radius.circular(30)),
//                                 // border: Border.all()
//                               ),
//                               child: TextButton(
//                                   onPressed: () {
//                                     profilePic();
//                                   },
//                                   // icon: Icon(Icons.select_all),
//                                   child: Text(
//                                     'Choose Image',
//                                     style: TextStyle(
//                                         fontSize: 18, color: Colors.grey),
//                                   )),
//                               // child: FlatButton(color:Colors.blue[700], onPressed: (){}, child: Text('Choose image')),
//                             ),
//                             SizedBox(
//                               height: 65,
//                             ),
//                             if (_profilepic == null)
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 GoogleNavBar()),
//                                         (route) => false);
//                                   },
//                                   child: Text('Skip',
//                                       style: TextStyle(
//                                           fontSize: 20, color: Colors.black)))
//                           ]),
//                     )
//                   ],
//                 ),
//                 isActive: _currentStep >= 2,
//                 state:
//                     _currentStep >= 2 ? StepState.complete : StepState.disabled,
//               ),
//             ]),
//       ),
//     );
//   }

//   step1() {
//     if (accept == true) {
//       _currentStep += 1;

//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser.uid)
//           .set({
//         'joinedat': DateTime.now(),
//         'name': null,
//         'email': null,
//         'profilepic': null,
//         // 'phone': '+91$value',
//         'altNum': null,
//         'terms&Conditions': tca,
//         'reference': 0,
//         'uid': FirebaseAuth.instance.currentUser.uid
//       });
//     } else {
//       Timer(
//           Duration(milliseconds: 100),
//           () => _scrollController
//               .jumpTo(_scrollController.position.maxScrollExtent));
//       final snackBar = SnackBar(
//         content: Text('Need to accept all the terms & conditions'),
//         action: SnackBarAction(
//           label: 'Close',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );

//       // Find the ScaffoldMessenger in the widget tree
//       // and use it to show a SnackBar.
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   step2() {
//     if (_formkey.currentState.validate()) {
//       _currentStep += 1;
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser.uid)
//           .update({
//         'name': this.name,
//         'altNum': this.altnumber,
//         'Num': this.number,
//         'email': this.email,
//         'uid': FirebaseAuth.instance.currentUser.uid,
//         'reference': 0,
//         'profilepic': null
//       }).catchError((e) {
//         print(e);
//       });
//     } else {
//       final snackBar = SnackBar(
//         content: Text('Fill all the fields'),
//         action: SnackBarAction(
//           label: 'Close',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );

//       // Find the ScaffoldMessenger in the widget tree
//       // and use it to show a SnackBar.
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   step3() async {
//     await uploadimage();
//     _currentStep += 1;
//   }

//   //image pick
//   Future<void> profilePic() async {
//     var front = await ImagePicker().getImage(
//       source: ImageSource.camera,
//       imageQuality: 40,
//       preferredCameraDevice: CameraDevice.rear,
//     );
//     setState(() {
//       _profilepic = File(front.path);
//     });
//   }

// //image upload function
//   Future<void> uploadimage() async {
//     var postImageRef = FirebaseStorage.instance.ref().child('legalDoc');
//     UploadTask uploadTask = postImageRef
//         .child(DateTime.now().toString() + ".jpg")
//         .putFile(_profilepic);
//     print(uploadTask);
//     var imageUrl = await (await uploadTask).ref.getDownloadURL();
//     imageLink3 = imageUrl.toString();
//     print(imageUrl);
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .update({'profilepic': imageLink3});
//   }
// }

// //step1

// // Row(
// //   mainAxisAlignment: MainAxisAlignment.end,
// //   children: [
// //     (accept == true)
// //         ? ElevatedButton(
// //             child: Text(
// //               'accept',
// //               style: TextStyle(
// //                   color: Colors.white),
// //             ),
// //             //color: Colors.blue,
// //             onPressed: () {
// //               // print(value);
// //               FirebaseFirestore.instance
// //                   .collection('users')
// //                   .doc(FirebaseAuth
// //                       .instance.currentUser.uid)
// //                   .set({
// //                 'joinedat': DateTime.now(),
// //                 'name': null,
// //                 'email': null,
// //                 'profilepic': null,
// //                 // 'phone': '+91$value',
// //                 'altNum': null,
// //                 'terms&Conditions': tca,
// //                 'reference': 0,
// //                 'uid': FirebaseAuth
// //                     .instance.currentUser.uid
// //               });

// //               if (accept == true) {
// //                 Navigator.pushAndRemoveUntil(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) =>
// //                             PersonalInfo()),
// //                     (route) => false);
// //               }
// //             })
// //         : Container(
// //             height: 10, color: Colors.white)
// //   ],
// // )

// //step2
// //  Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               ElevatedButton(
// //                                   child: Text(
// //                                     'Submit',
// //                                     style: TextStyle(color: Colors.white),
// //                                   ),
// //                                   onPressed: () async {
// //                                     if (_formkey.currentState.validate()) {
// //                                       Navigator.pushAndRemoveUntil(
// //                                           context,
// //                                           MaterialPageRoute(
// //                                               builder: (_) => ProfilePic()),
// //                                           (route) => false);
// //                                     }

// //                                     FirebaseFirestore.instance
// //                                         .collection('users')
// //                                         .doc(FirebaseAuth
// //                                             .instance.currentUser.uid)
// //                                         .update({
// //                                       'name': this.name,
// //                                       'altNum': this.number,
// //                                       'email': this.email,
// //                                       'uid':
// //                                           FirebaseAuth.instance.currentUser.uid,
// //                                       'reference': 0,
// //                                       'profilepic': null
// //                                     }).catchError((e) {
// //                                       print(e);
// //                                     });
// //                                     val = true;
// //                                   }),
// //                             ],
// //                           )
// // class PersonalInfo extends StatefulWidget {
// //   @override
// //   _PersonalInfoState createState() => _PersonalInfoState();
// // }

// // class _PersonalInfoState extends State<PersonalInfo> {
// //   String name;
// //   String email;
// //   String number;

// //   // var format = DateFormat.yMd('ar').format(DateTime.now());
// //   DateTime now = DateTime.now();

// //   // CrudMethods adPost = new CrudMethods();

// //   final _formkey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: IconThemeData(color: Colors.black),
// //         title: Text(
// //           'Create account',
// //           style: TextStyle(color: Colors.black),
// //         ),
// //         backgroundColor: Colors.grey[100],
// //         elevation: 0,
// //       ),
// //       backgroundColor: Colors.grey[100],
// //       body: Form(
// //         key: _formkey,
// //         child: ListView(children: [
// //           Column(
// //             children: [
// //               Container(
// //                 height: 600,
// //                 width: 380,
// //                 //color: Colors.amber,
// //                 child: ListView(
// //                   children: [
// //                     Container(
// //                       padding: EdgeInsets.all(10),
// //                       height: 90,
// //                       width: 380,
// //                       decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(15)),
// //                       child: TextFormField(
// //                         keyboardType: TextInputType.name,
// //                         controller: nameTf,
// //                         decoration: InputDecoration(
// //                           hintStyle: TextStyle(fontSize: 17),
// //                           hintText: 'Name',
// //                           suffixIcon: Icon(Icons.person),
// //                           //border: InputBorder.none,
// //                           contentPadding: EdgeInsets.all(20),
// //                         ),
// //                         validator: (value) {
// //                           if (value.isEmpty) {
// //                             return 'Please Enter Your Name';
// //                           }
// //                           return null;
// //                         },
// //                         onChanged: (value) {
// //                           this.name = value;
// //                         },
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 7,
// //                     ),
// //                     Container(
// //                       padding: EdgeInsets.all(10),
// //                       height: 90,
// //                       width: 380,
// //                       decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(15)),
// //                       child: TextFormField(
// //                         keyboardType: TextInputType.emailAddress,
// //                         decoration: InputDecoration(
// //                           hintStyle: TextStyle(fontSize: 17),
// //                           hintText: 'Email',
// //                           suffixIcon: Icon(Icons.email),
// //                           //border: InputBorder.none,
// //                           contentPadding: EdgeInsets.all(20),
// //                         ),
// //                         validator: (value) {
// //                           if (value.isEmpty || !value.contains('@')) {
// //                             return 'Please Enter Valid Email';
// //                           }
// //                           return null;
// //                         },
// //                         controller: emailTf,
// //                         onChanged: (value) {
// //                           this.email = value;
// //                         },
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 7,
// //                     ),
// //                     Container(
// //                       padding: EdgeInsets.all(10),
// //                       height: 90,
// //                       width: 380,
// //                       decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(15)),
// //                       child: TextFormField(
// //                         keyboardType: TextInputType.phone,
// //                         decoration: InputDecoration(
// //                           hintStyle: TextStyle(fontSize: 17),
// //                           hintText: 'Alternative Mobile Number',
// //                           suffixIcon: Icon(Icons.dialpad),
// //                           //border: InputBorder.none,
// //                           contentPadding: EdgeInsets.all(20),
// //                         ),
// //                         validator: (value) {
// //                           if (value.isEmpty || value.length < 10) {
// //                             return 'Please Enter Valid Mobile Number';
// //                           }
// //                           return null;
// //                         },
// //                         controller: numberTf,
// //                         onChanged: (value) {
// //                           this.number = value;
// //                         },
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 7,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   ElevatedButton(
// //                       child: Text(
// //                         'Submit',
// //                         style: TextStyle(color: Colors.white),
// //                       ),
// //                       // color: Colors.blue[900],
// //                       // splashColor: Colors.blue,
// //                       // shape: RoundedRectangleBorder(
// //                       //     borderRadius:
// //                       //         BorderRadius.all(Radius.circular(10.0))),
// //                       onPressed: () async {
// //                         if (_formkey.currentState.validate()) {
// //                           Navigator.pushAndRemoveUntil(
// //                               context,
// //                               MaterialPageRoute(builder: (_) => ProfilePic()),
// //                               (route) => false);
// //                         }
// //                         //print(now);

// //                         // Map<String, dynamic> postData = {
// //                         //   'name': this.name,
// //                         //   'altNum': this.number,
// //                         //   'email': this.email,
// //                         //   'uid': FirebaseAuth.instance.currentUser.uid,
// //                         //   'reference': 0,
// //                         //   'profilepic': null
// //                         // };
// //                         // adPost.addData(postData).then((result) {
// //                         //   // dialogTrrigger(context);
// //                         // }).catchError((e) {
// //                         //   print(e);
// //                         // });
// //                       }),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }

// // class CrudMethods {
// //   bool isLoggedIn() {
// //     if (FirebaseAuth.instance.currentUser != null) {
// //       return true;
// //     } else {
// //       return false;
// //     }
// //   }

// //   Future<void> addData(postData) async {
// //     if (isLoggedIn()) {
// //       FirebaseFirestore.instance
// //           .collection('users')
// //           .doc(FirebaseAuth.instance.currentUser.uid)
// //           .update(postData)
// //           .catchError((e) {
// //         print(e);
// //       });
// //     } else {
// //       print('You need to login');
// //     }
// //   }
// // }
