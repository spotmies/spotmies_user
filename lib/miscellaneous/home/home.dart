// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:spotmies/home/ad/ad.dart';
// import 'package:spotmies/home/adfromHome.dart';
// import 'package:spotmies/home/notification.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
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

//   @override
//   void initState() {
//     super.initState();
//     //notifications();
//     //address
//     getAddressofLocation();
//     //for notifications
//     var androidInitialize = AndroidInitializationSettings('asdf');
//     var initializesettings = InitializationSettings(android: androidInitialize);
//     localNotifications = FlutterLocalNotificationsPlugin();
//     localNotifications.initialize(initializesettings);
//   }

// //get token
//   // void getToken() async {
//   //   print(await firebaseMessaging.getToken());
//   // }

// //address
//   getAddressofLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     final coordinates = Coordinates(position.latitude, position.longitude);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);

//     setState(() {
//       add1 = addresses.first.featureName;
//       add2 = addresses.first.subLocality;
//       add3 = addresses.first.locality;
//     });
//   }

//   FlutterLocalNotificationsPlugin localNotifications;

//   @override
//   Widget build(BuildContext context) {
//     //getToken();
//     final _hight = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         kToolbarHeight;
//     final _width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 48,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             Icon(
//               Icons.location_on,
//               color: Colors.blue[900],
//               size: 15,
//             ),
//             SizedBox(
//               width: 3,
//             ),
//             TextButton(
//               onPressed: () async {
//                 await getAddressofLocation();
//               },
//               child: Text(
//                 add2 == null ? 'seethammadhara' : add2,
//                 textAlign: TextAlign.end,
//                 style: TextStyle(
//                     color: Colors.blue[900],
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14.0),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           // IconButton(
//           //     icon: Icon(
//           //       Icons.search,
//           //       color: Colors.blue[900],
//           //     ),
//           //     onPressed: () {
//           //       // showSearch(context: context, delegate: DataSearch());
//           //     }),
//           IconButton(
//               icon: Icon(
//                 Icons.notifications_active,
//                 color: Colors.blue[900],
//               ),
//               onPressed: () async {
//                 await firebaseMessaging.subscribeToTopic('sendmeNotification');
//                 //_shownotification();
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Notifications()));
//               }),
//           SizedBox(
//             width: 5,
//           ),
//         ],
//       ),

//       body: Center(
//         child: Container(
//           width: _width * 0.95,
//           child: GridView.count(
//             primary: false,
//             padding: const EdgeInsets.all(20),
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 15,
//             crossAxisCount: 4,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '9',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       child: Icon(Icons.electrical_services),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Electrician', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '10',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.carpenter),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Carpentor', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '11',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.plumbing_sharp),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Plumber', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '0',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.miscellaneous_services),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text(
//                       'AC Service',
//                       style: TextStyle(fontSize: 12),
//                     )
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '1',
//                               )));
//                   //idy2702603
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.laptop_mac),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Computer', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '2',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.developer_mode),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Development', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '3',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.tv),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('TV', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '4',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.person_search),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Tutor', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '5',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.face),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Beauty', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '6',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.camera_enhance),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Camera', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '7',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.car_rental),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Drivers', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PostAdFromHome(
//                                 value: '8',
//                               )));
//                 },
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       child: Icon(Icons.event),
//                     ),
//                     SizedBox(
//                       height: _hight * 0.01,
//                     ),
//                     Text('Events', style: TextStyle(fontSize: 12))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       //floating action button
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Post Add',
//         backgroundColor: Colors.white,
//         onPressed: () {},
//         child: IconButton(
//             icon: Icon(
//               Icons.add,
//               color: Colors.blue[900],
//             ),
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => PostAd()));
//             }),
//       ),
//     );
//   }

//   // void initMessaging() {
//   //   var androidinit = AndroidInitializationSettings('asdf');
//   //   var initsettings = InitializationSettings(android: androidinit);
//   //   localNotifications = FlutterLocalNotificationsPlugin();
//   //   localNotifications.initialize(initsettings);

//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     _shownotification();
//   //   });
//   // }

//   // Future _shownotification() async {
//   //   var androidDetails = AndroidNotificationDetails(
//   //       'channelId', 'channelName', 'channelDescription',
//   //       importance: Importance.high);
//   //   var generalNotificationetails =
//   //       NotificationDetails(android: androidDetails);
//   //   await localNotifications.show(0, 'orderState', 'something behind the info',
//   //       generalNotificationetails);
//   // }

//   // void notifications() async {
//   //   NotificationSettings settings = await firebaseMessaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     provisional: false,
//   //     sound: true,
//   //   );
//   // }
// }

// //rentals ui

// // Container(
// //                 height: _hight * 0.35,
// //                 width: _width * 1,
// //                 decoration: BoxDecoration(
// //                   //color: Colors.grey,
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //                 child: ListView(scrollDirection: Axis.horizontal, children: [
// //                   Container(
// //                     height: _hight * 0.35,
// //                     width: _width * 0.9,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(10),
// //                       color: Colors.amber,
// //                     ),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Image.network(
// //                           'https://pngimg.com/uploads/mini/mini_PNG11772.png',
// //                           height: _hight * 0.25,
// //                           width: _width * 0.8,
// //                         ),
// //                         TextButton(
// //                             onPressed: () {},
// //                             child: Text(
// //                               'Book Your First Ride on Spotmies',
// //                               style: TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ))
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 5,
// //                   ),
// //                   Container(
// //                     height: _hight * 0.35,
// //                     width: _width * 0.9,
// //                     decoration: BoxDecoration(
// //                       color: Colors.deepOrange,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Image.network(
// //                           'https://pngimg.com/uploads/harley_davidson/harley_davidson_PNG22.png',
// //                           height: _hight * 0.25,
// //                           width: _width * 0.8,
// //                         ),
// //                         TextButton(
// //                             onPressed: () {},
// //                             child: Text(
// //                               'Book Your First Ride on Spotmies',
// //                               style: TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             )),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 5,
// //                   ),
// //                   Container(
// //                     height: _hight * 0.35,
// //                     width: _width * 0.9,
// //                     decoration: BoxDecoration(
// //                       color: Colors.blueGrey,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Image.network(
// //                           'https://pngimg.com/uploads/photo_camera/photo_camera_PNG7848.png',
// //                           height: _hight * 0.25,
// //                           width: _width * 0.8,
// //                         ),
// //                         TextButton(
// //                             onPressed: () {},
// //                             child: Text(
// //                               'Book Your First Camera on Spotmies',
// //                               style: TextStyle(
// //                                 fontSize: 20,
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             )),
// //                       ],
// //                     ),
// //                   ),
// //                 ]),
// //               ),

// // List<bool> isSelected = List.generate(3, (index) => false);
