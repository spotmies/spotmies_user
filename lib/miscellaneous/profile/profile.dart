// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:share/share.dart';
// import 'package:spotmies/views/login/loginpage.dart';
// import 'package:spotmies/profile/settings.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   //static final String path = "lib/src/pages/settings/settings3.dart";
//   final TextStyle headerStyle = TextStyle(
//     color: Colors.grey.shade800,
//     fontWeight: FontWeight.bold,
//     fontSize: 20.0,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[100],
//         leading: IconButton(
//             icon: Icon(
//               Icons.person,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => HomeScreen()));
//             }),
//         title: Text(
//           'Profile',
//           style: TextStyle(color: Colors.black),
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: Colors.grey[100],
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('users')
//               .doc(FirebaseAuth.instance.currentUser.uid)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             var document = snapshot.data;
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 200,
//                     width: 330,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       // boxShadow: kElevationToShadow[1]
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         CircleAvatar(
//                           child: ClipOval(
//                             child: Center(
//                               child: document['profilepic'] == null
//                                   ? Icon(
//                                       Icons.person,
//                                       color: Colors.white,
//                                       size: 65,
//                                     )
//                                   : Image.network(
//                                       document['profilepic'],
//                                       fit: BoxFit.cover,
//                                       width: MediaQuery.of(context).size.width,
//                                     ),
//                             ),
//                           ),
//                           radius: 50,
//                           backgroundColor: Colors.blue[800],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               document['name'] == null
//                                   ? 'New User'
//                                   : document['name'],
//                               style: TextStyle(fontSize: 25),
//                             ),
//                             Text(
//                               document['email'] == null
//                                   ? 'not found'
//                                   : document['email'],
//                               style: TextStyle(fontSize: 15),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                       height: 250,
//                       width: double.infinity,
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           InkWell(
//                               onTap: () => Share.share(
//                                   'https://play.google.com/store/apps/details?id=com.spotmiespartner'),
//                               // print(
//                               //     "Refer & Share"), // handle your onTap here
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.share,
//                                           color: Colors.grey[600],
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(top: 13),
//                                       height: 50,
//                                       width: 200,
//                                       child: Text(
//                                         'Refer & Share',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                     ),
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.arrow_forward,
//                                           color: Colors.grey[600],
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                           InkWell(
//                               onTap: () => print(
//                                   "Privacy Policy"), // handle your onTap here
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.security,
//                                           color: Colors.grey[600],
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(top: 13),
//                                       height: 50,
//                                       width: 200,
//                                       child: Text(
//                                         'Privacy Policy',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                     ),
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.arrow_forward,
//                                           color: Colors.grey[600],
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                           InkWell(
//                               onTap: () =>
//                                   print("Support"), // handle your onTap here
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.chat,
//                                           color: Colors.grey[600],
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(top: 13),
//                                       height: 50,
//                                       width: 200,
//                                       child: Text(
//                                         'Help & Support',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                     ),
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.arrow_forward,
//                                           color: Colors.grey[600],
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                           InkWell(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Setting()));
//                               }, // handle your onTap here
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.settings,
//                                           color: Colors.grey[600],
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(top: 13),
//                                       height: 50,
//                                       width: 200,
//                                       child: Text(
//                                         'Setting',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                     ),
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.arrow_forward,
//                                           color: Colors.grey[600],
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                           InkWell(
//                               onTap: () async {
//                                 await FirebaseAuth.instance
//                                     .signOut()
//                                     .then((action) {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               LoginPageScreen()));
//                                 }).catchError((e) {
//                                   print(e);
//                                 });
//                               }, // handle your onTap here
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.power_settings_new_rounded,
//                                           color: Colors.grey[600],
//                                         )),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.only(top: 13),
//                                       height: 50,
//                                       width: 200,
//                                       child: Text(
//                                         'Logout',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 70,
//                                     ),
//                                     Container(
//                                         height: 50,
//                                         width: 50,
//                                         child: Icon(
//                                           Icons.arrow_forward,
//                                           color: Colors.grey[600],
//                                         )),
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       )),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
