// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:spotmies/home/navbar.dart';

// //path for adding post data
// var docc;
// Future<void> docid() async {
//   docc = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser.uid)
//       .collection('adpost')
//       .doc();
// }

// class PostAdEdit extends StatefulWidget {
//   final String value;
//   PostAdEdit({this.value});
//   @override
//   _PostAdEditState createState() => _PostAdEditState(value);
// }

// class _PostAdEditState extends State<PostAdEdit> {
//   String service;
//   String title;
//   String time;
//   String upload;
//   String discription;
//   String money;
//   String state;
//   String adtime;
//   File _profilepic;
//   String imageLink = "";
//   DateTime pickedDate;
//   TimeOfDay pickedTime;

//   DateTime now = DateTime.now();

//   // drop down menu for service type
//   int dropDownValue = 0;
//   //dummy data for accept/reject requests condition
//   String dummy = 'nothing';
//   //user id
//   var uid = FirebaseAuth.instance.currentUser.uid;
//   //location
//   String location = 'seethammadhara,visakhapatnam';

//   //creating var for crud ops
//   //CrudMethods adPost = new CrudMethods();

//   // location and place access

//   var latitude = "";
//   var longitude = "";
//   String add1 = "";
//   String add2 = "";
//   String add3 = "";

//   //function for location
//   void getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     var lastPosition = await Geolocator.getLastKnownPosition();
//     print(lastPosition);

//     String lat = '${position.latitude}';
//     String long = '${position.longitude}';

//     print('$lat,$long');

//     setState(() {
//       latitude = '${position.latitude}';
//       longitude = '${position.longitude}';
//     });
//   }

//   String value;
//   _PostAdEditState(this.value);
//   @override
//   void initState() {
//     super.initState();
//     getAddressofLocation();
//     pickedDate = DateTime.now();
//     pickedTime = TimeOfDay.now();
//   }

//   getAddressofLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     final coordinates = Coordinates(position.latitude, position.longitude);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);

//     setState(() {
//       add1 = addresses.first.featureName;
//       add2 = addresses.first.addressLine;
//       add3 = addresses.first.locality;
//     });
//   }

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
//           'Edit post',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.grey[100],
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           height: _hight * 1,
//           width: _width * 1,
//           //color: Colors.amber,
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 height: _hight * 0.13,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     hintStyle: TextStyle(fontSize: 17),
//                     hintText: 'money',
//                     suffixIcon: Icon(Icons.money),
//                     //border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   onChanged: (value) {
//                     this.money = value;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               InkWell(
//                 onTap: () {
//                   _pickedDate();
//                 },
//                 child: Container(
//                     padding: EdgeInsets.all(20),
//                     height: _hight * 0.13,
//                     width: _width * 1,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'Re-Schedule:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Date & Time: ',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w400)),
//                                 Text(
//                                   '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}' +
//                                       ' - ${pickedTime.hour}:${pickedTime.minute}',
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                               ],
//                             ),
//                             Icon(Icons.timer),
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(10),
//                 height: _hight * 0.25,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'location:',
//                             style: TextStyle(
//                                 fontSize: 17, fontWeight: FontWeight.w500),
//                           ),
//                           Text('$latitude,$longitude'),
//                           Text(add2),
//                         ],
//                       ),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.location_searching),
//                             TextButton(
//                                 onPressed: () {
//                                   getCurrentLocation();
//                                   getAddressofLocation();
//                                 },
//                                 child: Text(
//                                   'Get Location',
//                                   style: TextStyle(
//                                       color: Colors.blue[800],
//                                       fontWeight: FontWeight.bold),
//                                 )),
//                           ])
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Center(
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   height: _hight * 0.33,
//                   width: _width * 1,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Column(
//                     children: [
//                       Container(
//                           child: Row(
//                         children: [
//                           Text('Upload images:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500)),
//                         ],
//                       )),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       _profilepic == null
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.cloud_upload_outlined,
//                                       size: 45,
//                                       color: Colors.grey,
//                                     ),
//                                     onPressed: () {
//                                       adImage();
//                                     }),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Text(
//                                     'Let us know your problem by uploading image')
//                               ],
//                             )
//                           : Column(
//                               children: [
//                                 Container(
//                                     height: _hight * 0.20,
//                                     width: _width * 1,
//                                     child: Image.file(_profilepic)),
//                                 Container(
//                                     height: _hight * 0.05,
//                                     width: _width * 1,
//                                     color: Colors.white,
//                                     child: Center(
//                                       child: Center(
//                                         child: TextButton(
//                                             onPressed: () {
//                                               uploadimage();
//                                             },
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(
//                                                     Icons.cloud_upload_outlined,
//                                                     color: Colors.black),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text(
//                                                   'Upload',
//                                                   style: TextStyle(
//                                                       color: Colors.blue[800]),
//                                                 )
//                                               ],
//                                             )),
//                                       ),
//                                     ))
//                               ],
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       // color: Colors.blue[900],
//                       // splashColor: Colors.blue,
//                       // shape: RoundedRectangleBorder(
//                       //     borderRadius:
//                       //         BorderRadius.all(Radius.circular(10.0))),
//                       onPressed: () async {
//                         docid();
//                         print(imageLink);

//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(FirebaseAuth.instance.currentUser.uid)
//                             .collection('adpost')
//                             .doc(value)
//                             .update({
//                           'price': this.money,
//                           'posttime': this.now,
//                           'schedule': this.time,
//                           'userid': uid,
//                           'request': dummy,
//                           'location': location,
//                           'orderid': value,
//                           'media': imageLink,
//                           'location.latitude': latitude,
//                           'location.longitude': longitude,
//                           'location.add1': add3,
//                           'orderstate': null,
//                         });

//                         //data to all orders
//                         FirebaseFirestore.instance
//                             .collection('allads')
//                             .doc(value)
//                             .update({
//                           'price': this.money,
//                           'posttime': this.now,
//                           'scheduledate':
//                               '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
//                           'scheduletime':
//                               '${pickedTime.hour}:${pickedTime.minute}',
//                           'userid': uid,
//                           'request': dummy,
//                           'location': location,
//                           'orderid': docc.id,
//                           'media': imageLink,
//                           'location.latitude': latitude,
//                           'location.longitude': longitude,
//                           'location.add1': add3,
//                           'orderstate': null,
//                         });
//                         dialogTrrigger(context);
//                       })
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //picked date
//   _pickedDate() async {
//     DateTime date = await showDatePicker(
//         context: context,
//         initialDate: pickedDate,
//         firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
//             DateTime.now().day - 0),
//         lastDate: DateTime(DateTime.now().year + 1));
//     if (date != null) {
//       setState(() async {
//         TimeOfDay t = await showTimePicker(
//           context: context,
//           initialTime: pickedTime,
//         );
//         if (t != null) {
//           setState(() {
//             pickedTime = t;
//           });
//         }
//         pickedDate = date;
//       });
//     }
//   }

//   // image pick
//   Future<void> adImage() async {
//     var front = await ImagePicker()
//         .getImage(source: ImageSource.camera, imageQuality: 20);
//     setState(() {
//       _profilepic = File(front.path);
//     });
//   }

// //image upload function
//   Future<void> uploadimage() async {
//     var postImageRef = FirebaseStorage.instance.ref().child('adImages');
//     UploadTask uploadTask = postImageRef
//         .child(DateTime.now().toString() + ".jpg")
//         .putFile(_profilepic);
//     print(uploadTask);
//     var imageUrl = await (await uploadTask).ref.getDownloadURL();
//     imageLink = imageUrl.toString();
//     // print(imageUrl);
//   }
// }

// Future<bool> dialogTrrigger(BuildContext context) async {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Acknowledgement'),
//           content: Text('Post Succussfully Published'),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   // Navigator.of(context).pop();
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => GoogleNavBar()));
//                 },
//                 child: Text('ok'))
//           ],
//         );
//       });
// }
