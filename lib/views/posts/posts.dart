import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/views/home/ads/adedit.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/controllers/posts_controllers/posts_controller.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends StateMVC<PostList> {
  PostsController _postsController;
  _PostListState() : super(PostsController()) {
    this._postsController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _postsController.scaffoldkey,
        // backgroundColor: Colors.blue[900],
        appBar: AppBar(
          title: Text('My posts'),
          backgroundColor: Colors.blue[900],
          toolbarHeight: 48,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: _postsController.postStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Container(
              height: _hight * 1,
              width: _width * 1,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(15),
                children: snapshot.data.docs.map((document) {
                  List<String> images = List.from(document['media']);
                  return Column(children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PostOverView(value: document['orderid']),
                        ));
                      },
                      child: Container(
                          height: _hight * 0.30,
                          width: _width * 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: kElevationToShadow[0]),
                          child: Column(
                            children: [
                              Container(
                                height: _hight * 0.040,
                                width: _width * 1,
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(15),
                                      topRight: const Radius.circular(15),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      (() {
                                        if (document['job'] == 0) {
                                          return 'AC Service';
                                        }
                                        if (document['job'] == 1) {
                                          return 'Computer';
                                        }
                                        if (document['job'] == 2) {
                                          return 'TV Repair';
                                        }
                                        if (document['job'] == 3) {
                                          return 'Development';
                                        }
                                        if (document['job'] == 4) {
                                          return 'Tutor';
                                        }
                                        if (document['job'] == 5) {
                                          return 'Beauty';
                                        }
                                        if (document['job'] == 6) {
                                          return 'Photography';
                                        }
                                        if (document['job'] == 7) {
                                          return 'Drivers';
                                        }
                                        if (document['job'] == 8) {
                                          return 'Events';
                                        }
                                      }())
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.only(bottom: 15),
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) =>
                                                  CupertinoActionSheet(
                                                    actions: [
                                                      CupertinoActionSheetAction(
                                                          isDefaultAction: true,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PostAdEdit(
                                                                      value: document[
                                                                          'orderid']),
                                                            ));
                                                          },
                                                          child: Text('Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black))),
                                                      CupertinoActionSheetAction(
                                                          isDefaultAction: true,
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(document[
                                                                    'orderid'])
                                                                .update({
                                                              'delete': true,
                                                            });
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid)
                                                                .collection(
                                                                    'adpost')
                                                                .doc(document[
                                                                    'orderid'])
                                                                .delete();
                                                          },
                                                          child: Text('Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)))
                                                    ],
                                                    cancelButton:
                                                        CupertinoActionSheetAction(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                  ));
                                        })
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(images.first),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: _hight * 0.055,
                                        width: _width * 0.7,
                                        child: Column(
                                          children: [
                                            Text(
                                              document['problem'].toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 120,
                                            width: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_red_eye,
                                                      size: 20,
                                                    ),
                                                    Text(' Money:' +
                                                        document['money']
                                                            .toString()),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person_pin_circle,
                                                      size: 20,
                                                    ),
                                                    Text(' Distance:' +
                                                        document['money']
                                                            .toString())
                                                  ],
                                                ),
                                                TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'View your post',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.blue[900]),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            height: 120,
                                            width: 120,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.attach_money,
                                                      size: 20,
                                                    ),
                                                    Text('Money:' +
                                                        document['money']
                                                            .toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      size: 20,
                                                    ),
                                                    // Text('$DateTime'),
                                                  ],
                                                ),
                                                Container(
                                                    height: 25,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: Text(
                                                        'Active',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ]);
                }).toList(),
              ),
            );
          },
        ));
  }
}
