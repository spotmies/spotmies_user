import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/views/chat/chatapp/chat_screen.dart';
import 'package:spotmies/controllers/chat_controllers/chatPage_controller.dart';

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends StateMVC<ChatHome> {
  ChatPageController _chatPageController;
  _ChatHomeState() : super(ChatPageController()) {
    this._chatPageController = controller;
  }
  String value;
  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _chatPageController.scaffoldkey,
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Conversations',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
          height: _hight * 1,
          width: _width * 1,
          child: Column(
            children: [
              StreamBuilder(
                  stream: _chatPageController.chatPageStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(15),
                        children: snapshot.data.docs.map((document) {
                          var msgid = document['id'];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print('$msgid');
                                  FirebaseFirestore.instance
                                      .collection('messaging')
                                      .doc(msgid)
                                      .update({'ustatus': 1});
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      value: msgid,
                                    ),
                                  ));
                                },
                                child: Container(
                                  height: _hight * 0.1,
                                  width: _width * 0.95,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: kElevationToShadow[0]),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: ClipOval(
                                          child: Center(
                                            child: document['ppic'] == null
                                                ? Center(
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.blueGrey,
                                                      size: 40,
                                                    ),
                                                  )
                                                : Image.network(
                                                    document['ppic'],
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                          ),
                                        ),
                                        backgroundColor: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(document['pname'] == null
                                          ? 'technician'
                                          : document['pname'])
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
