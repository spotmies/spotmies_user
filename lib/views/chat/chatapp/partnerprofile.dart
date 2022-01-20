import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetails extends StatefulWidget {
  final String value;
  PartnerDetails({required this.value});
  @override
  _PartnerDetailsState createState() => _PartnerDetailsState(value);
}

class _PartnerDetailsState extends State<PartnerDetails> {
  String value;
  _PartnerDetailsState(this.value);
  // bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            var prodoc = snapshot.data;
            print(prodoc?['name']);
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messaging')
                    .doc(value)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  var document = snapshot.data;
                  var num = document?['pnum'];
                  bool isSwitch = document?['revealprofile'];

                  return document?['ppic'] != null
                      ? CustomScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          slivers: [
                            SliverAppBar(
                              backgroundColor: Colors.blue[900],
                              stretch: true,
                              // onStretchTrigger: () {
                              //   // Function callback for stretch
                              //   return Future<void>.value();
                              // },
                              pinned: true,
                              title: Text(document?['pname']),
                              snap: false,
                              floating: true,
                              expandedHeight: height(context) * 0.5,
                              flexibleSpace: FlexibleSpaceBar(
                                stretchModes: <StretchMode>[
                                  StretchMode.zoomBackground,
                                  StretchMode.fadeTitle,
                                ],
                                background: Container(
                                  width: width(context) * 1,
                                  color: Colors.black,
                                  child: Image.network(
                                    document?['ppic'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Divider(
                                    thickness: 5,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: height(context) * 0.25,
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: width(context) * 0.03,
                                                top: width(context) * 0.03,
                                                bottom: width(context) * 0.03),
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'About and Phone Number',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      width(context) * 0.05),
                                            )),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: EdgeInsets.only(
                                            left: width(context) * 0.03,
                                            top: width(context) * 0.03,
                                          ),
                                          child: Text('Chating From',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      width(context) * 0.05)),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: EdgeInsets.only(
                                            left: width(context) * 0.03,
                                            top: width(context) * 0.01,
                                          ),
                                          child: Text(
                                              DateFormat('dd MMM, yyyy (EEE)')
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          int.parse(document?[
                                                              'createdAt']))),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      width(context) * 0.04)),
                                        ),
                                        Divider(
                                          indent: width(context) * 0.04,
                                          endIndent: width(context) * 0.04,
                                          thickness: 1,
                                          color: Colors.grey[300],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                                flex: 2,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: width(context) * 0.03,
                                                    top: width(context) * 0.01,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(num,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: width(
                                                                        context) *
                                                                    0.05)),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            left:
                                                                width(context) *
                                                                    0.1,
                                                            top:
                                                                width(context) *
                                                                    0.01),
                                                        width: double.infinity,
                                                        child: Text('Mobile',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: width(
                                                                        context) *
                                                                    0.04)),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Flexible(
                                                flex: 2,
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.message,
                                                            color: Colors
                                                                .blue[900],
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.call,
                                                            color: Colors
                                                                .blue[900],
                                                          ),
                                                          onPressed: () {
                                                            launch(
                                                                "tel://$num");
                                                          }),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: width(context) * 0.07,
                                    ),
                                    height: height(context) * 0.1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.important_devices,
                                              color: Colors.blue[900],
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.07,
                                            ),
                                            Text(
                                              'Reveal My Profile',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize:
                                                      width(context) * 0.05,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Transform.scale(
                                          scale: 0.7,
                                          child: CupertinoSwitch(
                                              trackColor: Colors.grey[300],
                                              value: isSwitch,
                                              activeColor: Colors.blue[900],
                                              onChanged: (value) {
                                                FirebaseFirestore.instance
                                                    .collection('messaging')
                                                    .doc(document?['id'])
                                                    .update({
                                                  'revealprofile': value,
                                                });
                                                if (document?['uname'] ==
                                                    null) {
                                                  FirebaseFirestore.instance
                                                      .collection('messaging')
                                                      .doc(document?['id'])
                                                      .update({
                                                    'uname': prodoc?['name'],
                                                    'upic':
                                                        prodoc?['profilepic'],
                                                    'unum': prodoc?['num']
                                                  });
                                                }

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(value == true
                                                      ? 'your profile is shared '
                                                      : 'your profile is not shared '),

                                                  // action: SnackBarAction(
                                                  //   label: 'Undo',
                                                  //   onPressed: () {
                                                  //     // Some code to undo the change.
                                                  //   },
                                                  // ),
                                                ));
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: width(context) * 0.07,
                                    ),
                                    height: height(context) * 0.1,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.contact_support,
                                          color: Colors.blue[900],
                                        ),
                                        SizedBox(
                                          width: width(context) * 0.07,
                                        ),
                                        Text(
                                          'Available on Message',
                                          style: TextStyle(
                                              color: Colors.blue[900],
                                              fontSize: width(context) * 0.05,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        // height: height(context) * 0.2,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: height(context) * 0.05,
                                              // color: Colors.amber,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                left: width(context) * 0.03,
                                                // top: width(context) * 0.03,
                                              ),
                                              child: Text('Business address:',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width(context) *
                                                          0.05)),
                                            ),
                                            Container(
                                                // height: height(context) * 0.15,
                                                padding: EdgeInsets.only(
                                                  left: width(context) * 0.03,
                                                  top: width(context) * 0.03,
                                                  right: width(context) * 0.03,
                                                  bottom: width(context) * 0.03,
                                                ),
                                                child: Text(
                                                    document?['location'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            width(context) *
                                                                0.045)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: width(context) * 0.07,
                                    ),
                                    height: height(context) * 0.1,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.block,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: width(context) * 0.07,
                                        ),
                                        Text(
                                          'Block ' +
                                              (toBeginningOfSentenceCase(
                                                      document?['pname']) ??
                                                  ""),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: width(context) * 0.05,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      report();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: width(context) * 0.07,
                                      ),
                                      height: height(context) * 0.1,
                                      // decoration: BoxDecoration(boxShadow: [
                                      //   BoxShadow(
                                      //       color: Colors.grey[200],
                                      //       spreadRadius: 0,
                                      //       blurRadius: 5)
                                      // ]),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.report_problem,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: width(context) * 0.07,
                                          ),
                                          Text(
                                            'Report on ' +
                                                (toBeginningOfSentenceCase(
                                                        document?['pname']) ??
                                                    ""),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: width(context) * 0.05,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 10,
                                    color: Colors.grey[200],
                                  ),
                                  Container(height: 150.0),
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(child: Text('User not revealed deatils'));
                });
          }),
    );
  }

  report() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Acknowledgement'),
            content: Flexible(
                child: Column(
              children: [
                Text('Improper chatting'),
                Text(''),
              ],
            )),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}
