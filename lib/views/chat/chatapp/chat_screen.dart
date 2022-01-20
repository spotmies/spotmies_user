import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/controllers/chat_controllers/chatScreen_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/chat/chatapp/partnerprofile.dart';

class ChatScreen extends StatefulWidget {
  final String value;
  ChatScreen({required this.value});

  @override
  _ChatScreenState createState() => _ChatScreenState(value);
}

class _ChatScreenState extends StateMVC<ChatScreen> {
  late String value;
  late ChatScreenController _chatScreenController;
  _ChatScreenState(this.value) : super(ChatScreenController()) {
    this._chatScreenController = controller as ChatScreenController;
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 300),
        () => _chatScreenController.scrollController.animateTo(
            _chatScreenController.scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut));
    return Scaffold(
        key: _chatScreenController.scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                String doc = value;
                _chatScreenController.uread(doc);
                Navigator.of(context).pop();
              }),
          title: StreamBuilder<DocumentSnapshot>(
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
                return InkWell(
                  onTap: () {
                    var msgid = document?['id'];
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PartnerDetails(
                        value: msgid,
                      ),
                    ));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: AspectRatio(
                          aspectRatio: 400 / 400,
                          child: ClipOval(
                            child: document?['ppic'] == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                : Image.network(
                                    document!['ppic'].toString(),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                          ),
                        ),
                        backgroundColor: Colors.grey[50],
                      ),
                      SizedBox(
                        width: width(context) * 0.03,
                      ),
                      Container(
                        // padding: EdgeInsets.only(top: 10),
                        child: Text(
                          document?['pname'] == null
                              ? 'Costumer'
                              : document!['pname'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width(context) * 0.055),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        body: StreamBuilder<DocumentSnapshot>(
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
              List<String> msgs = List.from(document?['body']);
              int msglength = msgs.length;
              if (msglength == msgs.length) {
                Timer(
                    Duration(milliseconds: 200),
                    () => _chatScreenController.scrollController.jumpTo(
                        _chatScreenController
                            .scrollController.position.maxScrollExtent));
              }

              return ListView(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  if (document?['orderstate'] == 0)
                    Container(
                      height: height(context) * 0.08,
                      width: width(context) * 1,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width(context) * 0.45,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.white))),
                          ),
                          Container(
                            width: width(context) * 0.45,
                            child: ElevatedButton(
                                onPressed: () {
                                  //print(document['partnerid']);
                                  String id = document?['orderid'];
                                  String pid = document?['partnerid'];
                                  _chatScreenController.confirmOrder(id, pid);
                                },
                                child: Text('Confirm',
                                    style: TextStyle(color: Colors.white))),
                          )
                        ],
                      ),
                    ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: document?['orderstate'] == 0
                        ? height(context) * 0.78
                        : height(context) * 0.86,
                    width: width(context) * 1,
                    child: ListView.builder(
                        controller: _chatScreenController.scrollController,
                        itemCount: msgs.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          String msgData = msgs[index];
                          var data = jsonDecode(msgData);
                          var date2 = index - 1 == -1 ? index : index - 1;
                          if ((data['sender'] == 'u') &&
                              (data['type'] == 'text')) {
                            return Column(
                              children: [
                                if (_chatScreenController.date(
                                        msgData, msgs[date2]) !=
                                    '')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: height(context) * 0.04,
                                        width: width(context) * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          _chatScreenController.date(
                                              msgData, msgs[date2]),
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    left: 15,
                                                    right: 15),
                                                width: width(context) * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                    )),
                                                child: Text(data['msg']),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 2, right: 15),
                                                width: width(context) * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(30),

                                                      // bottomLeft:Radius.circular(30)
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(DateFormat.jm().format(
                                                        DateTime.fromMillisecondsSinceEpoch(
                                                            (int.parse(data[
                                                                    'timestamp']
                                                                .toString()))))),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                // Text("date")
                              ],
                            );
                          }
                          if ((data['sender'] == 'p') &&
                              (data['type'] == 'text')) {
                            return Column(
                              children: [
                                if (_chatScreenController.date(
                                        msgData, msgs[date2]) !=
                                    '')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: height(context) * 0.04,
                                        width: width(context) * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          _chatScreenController.date(
                                              msgData, msgs[date2]),
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    right: 15,
                                                    left: 15),
                                                width: width(context) * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                      // bottomRight:
                                                      //     Radius.circular(30)
                                                    )),
                                                child: Text(data['msg']),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 2, left: 15),
                                                width: width(context) * 0.55,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(30),

                                                      // bottomLeft:Radius.circular(30)
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(DateFormat.jm().format(
                                                        (DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                (int.parse(data[
                                                                    'timestamp'])))))),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // Text(date(msgData, msgs[date2])),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          if ((data['type'] == 'media') &&
                              (data['sender'] == 'u')) {
                            return Column(
                              children: [
                                if (_chatScreenController.date(
                                        msgData, msgs[date2]) !=
                                    '')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: height(context) * 0.04,
                                        width: width(context) * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          _chatScreenController.date(
                                              msgData, msgs[date2]),
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            // height: height(context) * 0.3,
                                            width: width(context) * 0.5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                )),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'You ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                                Image.network(
                                                  data['msg'],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 2, left: 15),
                                            width: width(context) * 0.55,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),

                                                  // bottomLeft:Radius.circular(30)
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(DateFormat.jm().format((DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        (int.parse(data[
                                                                'timestamp']
                                                            .toString())))))),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            );
                          }
                          if ((data['type'] == 'media') &&
                              (data['sender'] == 'p')) {
                            return Column(
                              children: [
                                if (_chatScreenController.date(
                                        msgData, msgs[date2]) !=
                                    '')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height: height(context) * 0.04,
                                        width: width(context) * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey[800],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          _chatScreenController.date(
                                              msgData, msgs[date2]),
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            // height: height(context) * 0.3,
                                            width: width(context) * 0.5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                )),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      document?['pname'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                                Image.network(
                                                  data['msg'],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: 2, left: 15),
                                            width: width(context) * 0.5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),

                                                  // bottomLeft:Radius.circular(30)
                                                )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(DateFormat.jm().format((DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        (int.parse(data[
                                                                'timestamp']
                                                            .toString())))))),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Text('Undefined');
                          }
                        }),
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(right: 20),
                          height: height(context) * 0.035,
                          child: Row(
                            children: [
                              Icon(
                                Icons.done_all,
                                color: document?['uread'] == 1
                                    ? Colors.greenAccent
                                    : Colors.grey,
                              ),
                              Text(document?['uread'] == 1 ? 'Seen' : 'Unseen'),
                            ],
                          )),
                    ],
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: height(context) * 0.1,
                            width: width(context) * 0.85,
                            child: TextField(
                              maxLines: 4,
                              controller: _chatScreenController.controller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                hintStyle: TextStyle(fontSize: 17),
                                hintText: 'Type Message......',
                                contentPadding: EdgeInsets.all(20),
                              ),
                              onChanged: (value) {
                                this._chatScreenController.textInput = value;
                              },
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.photo_camera,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              var msgcount = document?['pmsgcount'];
                              var pread = document?['pread'];
                              bottomappbar(msgcount, pread);
                            }),
                        Container(
                          height: height(context) * 0.1,
                          width: width(context) * 0.14,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue[900]),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    int msgcount = document?['umsgcount'] + 1;
                                    _chatScreenController.controller.clear();

                                    var msgData = {
                                      'msg': _chatScreenController.textInput,
                                      'timestamp':
                                          _chatScreenController.timestamp,
                                      'sender': 'u',
                                      'type': 'text'
                                    };
                                    String temp = jsonEncode(msgData);
                                    _chatScreenController.textInput == null
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                _chatScreenController.snackbar)
                                        : FirebaseFirestore.instance
                                            .collection('messaging')
                                            .doc(value)
                                            .update({
                                            if (document?['createdAt'] == null)
                                              'createdAt': _chatScreenController
                                                  .timestamp,
                                            'body':
                                                FieldValue.arrayUnion([temp]),
                                            'pmsgcount': document?['pread'] == 0
                                                ? msgcount
                                                : 0,
                                          });
                                    Timer(
                                        Duration(milliseconds: 300),
                                        () => _chatScreenController
                                            .scrollController
                                            .jumpTo(_chatScreenController
                                                .scrollController
                                                .position
                                                .maxScrollExtent));
                                  })),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Timer(
                Duration(milliseconds: 300),
                () => _chatScreenController.scrollController.jumpTo(
                    _chatScreenController
                        .scrollController.position.maxScrollExtent));
          },
          child: Icon(
            Icons.arrow_downward,
            color: Colors.blue[900],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop);
  }

  //images

  bottomappbar(int msgcount, int pread) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        elevation: 2,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(15),
            height: height(context) * 0.50,
            child: Column(
              children: [
                Container(
                    child: Row(
                  children: [
                    Text('Upload images:',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                _chatScreenController.profilepic == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.cloud_upload_outlined,
                                size: 45,
                                color: Colors.grey,
                              ),
                              onPressed: () {}),
                          SizedBox(
                            height: 7,
                          ),
                          Text('Let us know your problem by uploading image')
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: height(context) * 0.34,
                            width: width(context) * 1,
                            child: GridView.builder(
                                itemCount:
                                    (_chatScreenController.profilepic?.length)! + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5),
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? Center(
                                          child: IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () async {
                                                if (!_chatScreenController
                                                    .uploading) {
                                                  _chatScreenController
                                                      .chooseImage();
                                                }
                                                refresh();
                                              }),
                                        )
                                      : Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                              Container(
                                                margin: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                            _chatScreenController
                                                                    .profilepic![
                                                                index - 1]),
                                                        fit: BoxFit.cover)),
                                              ),
                                              Positioned(
                                                left: 37.0,
                                                bottom: 37.0,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color:
                                                          Colors.redAccent[200],
                                                    ),
                                                    onPressed: () async {
                                                      _chatScreenController
                                                          .profilepic
                                                          ?.removeAt(0);

                                                      refresh();
                                                    }),
                                              ),
                                            ]);
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await _chatScreenController.uploadimage();
                                  _chatScreenController.controller.clear();
                                  int len =
                                      _chatScreenController.imageLink.length;
                                  for (int i = 0; i <= len; i++) {
                                    var imageData = {
                                      'msg': _chatScreenController.imageLink[i],
                                      'timestamp':
                                          _chatScreenController.timestamp,
                                      'sender': 'u',
                                      'type': 'media'
                                    };
                                    String temp = jsonEncode(imageData);
                                    await FirebaseFirestore.instance
                                        .collection('messaging')
                                        .doc(value)
                                        .update({
                                      'createdAt': DateTime.now(),
                                      'body': FieldValue.arrayUnion([temp]),
                                      'pmsgcount':
                                          pread == 0 ? msgcount + 1 : 0,
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.all(12),
                                    height: height(context) * 0.07,
                                    //             //width: width(context) * 0.1,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(
                                              -2.0,
                                              -1,
                                            ),
                                            color: Colors.grey.shade50,
                                            spreadRadius: 1.0),
                                        BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(
                                              2.0,
                                              1,
                                            ),
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1.0)
                                      ],
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blue[900],
                                    )),
                              )
                            ],
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     InkWell(
                          //         onTap: () async {
                          //           await _chatScreenController.uploadimage();

                          //           int len =
                          //               _chatScreenController.imageLink.length;

                          //           for (int i = 0; i <= len; i++) {
                          //             var imageData = {
                          //               'msg': _chatScreenController.imageLink[i],
                          //               'timestamp':
                          //                   _chatScreenController.timestamp,
                          //               'sender': 'u',
                          //               'type': 'media'
                          //             };
                          //             String temp = jsonEncode(imageData);
                          //             await FirebaseFirestore.instance
                          //                 .collection('messaging')
                          //                 .doc(value)
                          //                 .update({
                          //               'createdAt': DateTime.now(),
                          //               'body': FieldValue.arrayUnion([temp]),
                          //               'pmsgcount': pread == 0 ? msgcount + 1 : 0,
                          //             });

                          //             Navigator.pop(context);
                          //         },
                          //         child: Container(
                          //             padding: EdgeInsets.all(12),
                          //             height: height(context) * 0.07,
                          //             //width: width(context) * 0.1,
                          //             decoration: BoxDecoration(
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                       blurRadius: 2,
                          //                       offset: Offset(
                          //                         -2.0,
                          //                         -1,
                          //                       ),
                          //                       color: Colors.grey[50],
                          //                       spreadRadius: 1.0),
                          //                   BoxShadow(
                          //                       blurRadius: 2,
                          //                       offset: Offset(
                          //                         2.0,
                          //                         1,
                          //                       ),
                          //                       color: Colors.grey[300],
                          //                       spreadRadius: 1.0)
                          //                 ],
                          //                 color: Colors.white,
                          //                 shape: BoxShape.circle),
                          //             child: Icon(
                          //               Icons.send,
                          //               color: Colors.blue[900],
                          //             )))
                          //   ],
                          // )
                        ],
                      ),
              ],
            ),
          );
        });
  }
}
