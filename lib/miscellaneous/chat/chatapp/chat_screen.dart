import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String value;
  ChatScreen({required this.value});

  @override
  _ChatScreenState createState() => _ChatScreenState(value);
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String? textInput;
  String value;
  //images
  List<File> _profilepic = [];
  bool uploading = false;
  double val = 0;

  List imageLink = [];

//scrolling
  // bool _needsScroll = false;

  // _scrollToEnd() async {
  //   _scrollController.animateTo(_scrollController.offset,
  //       duration: Duration(milliseconds: 200), curve: Curves.slowMiddle);
  // }

  _ChatScreenState(this.value);
  @override
  Widget build(BuildContext context) {
    // if (_needsScroll) {
    //   _scrollToEnd();
    //   _needsScroll = false;
    // }
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    Timer(
        Duration(milliseconds: 300),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
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
                return Text(document?['pname'] == null
                    ? 'technician'
                    : document?['pname']);
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
                    () => _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent));
              }
              // if () {
              //   Timer(
              //       Duration(milliseconds: 300),
              //       () => _scrollController
              //           .jumpTo(_scrollController.position.maxScrollExtent));
              // }

              // Map<String, dynamic> litems = document['body'];
              return ListView(
                children: [
                  // Divider(
                  //   //thickness: 2,
                  //   color: Colors.grey,
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  if (document?['orderstate'] == 0)
                    Container(
                      height: _hight * 0.08,
                      width: _width * 1,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: _width * 0.45,
                            child: ElevatedButton(
                                //color: Colors.blue[800],
                                onPressed: () {},
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.white))),
                          ),
                          Container(
                            width: _width * 0.45,
                            child: ElevatedButton(
                                // color: Colors.blue[800],
                                onPressed: () {
                                  print(document?['partnerid']);
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('adpost')
                                      .doc(document?['orderid'])
                                      .update({'orderstate': 2});
                                  FirebaseFirestore.instance
                                      .collection('allads')
                                      .doc(document?['orderid'])
                                      .update({'orderstate': 2});
                                  FirebaseFirestore.instance
                                      .collection('messaging')
                                      .doc(document?['partnerid'] +
                                          document?['orderid'])
                                      .update({'orderstate': 2});

                                  FirebaseFirestore.instance
                                      .collection('partner')
                                      .doc(document?['partnerid'])
                                      .collection('orders')
                                      .doc(document?['orderid'])
                                      .update({'orderstate': 2});
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
                        ? _hight * 0.8
                        : _hight * 0.9,
                    width: _width * 1,
                    child: ListView.builder(

                        //reverse: true,
                        controller: _scrollController,
                        itemCount: msgs.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          // Timer(
                          //     Duration(milliseconds: 500),
                          //     () => _scrollController.jumpTo(
                          //         _scrollController.position.maxScrollExtent));
                          if (msgs[index].endsWith('u')) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      //height: _hight * 0.11,
                                      //width: _width * 0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            // height: _hight * 0.08,
                                            width: _width * 0.7,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomLeft:
                                                        Radius.circular(30))),
                                            child: Center(
                                              child: Text(msgs[index].substring(
                                                  0, msgs[index].length - 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            );
                          }
                          if (msgs[index].endsWith('p')) {
                            // Timer(
                            //     Duration(milliseconds: 500),
                            //     () => _scrollController.jumpTo(_scrollController
                            //         .position.maxScrollExtent));
                            return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      //height: _hight * 0.09,
                                      //width: _width * 0.4,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            // height: _hight * 0.08,
                                            width: _width * 0.7,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomRight:
                                                        Radius.circular(30))),
                                            child: Center(
                                              child: Text(msgs[index].substring(
                                                  0, msgs[index].length - 1)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            );
                          }
                          if (msgs[index].endsWith('ui')) {
                            return Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        // height: _hight * 0.3,
                                        width: _width * 0.5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              // bottomLeft: Radius.circular(30)
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
                                              msgs[index].substring(
                                                  0, msgs[index].length - 1),
                                            ),
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
                            );
                          }
                          if (msgs[index].endsWith('pi')) {
                            return Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        // height: _hight * 0.3,
                                        width: _width * 0.5,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              //bottomRight: Radius.circular(15)
                                            )),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'From ' + document?['pname'],
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
                                              msgs[index].substring(
                                                  0, msgs[index].length - 1),
                                            ),
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
                            );
                          } else {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue[800],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                alignment: Alignment.center,
                                height: _hight * 0.09,
                                width: _width * 0.4,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        msgs[index].substring(
                                            0, msgs[index].length - 1),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ));
                          }
                        }),
                    color: Colors.white,
                  ),
                  Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            // constraints: BoxConstraints(
                            //   minHeight: _hight * 0.1,
                            //   maxHeight: _hight * 0.15,
                            // ),
                            height: _hight * 0.1,
                            width: _width * 0.85,
                            child: TextField(
                              maxLines: 4,
                              controller: _controller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
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
                              // onTap: () {},
                              onChanged: (value) {
                                this.textInput = value;
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
                              bottomappbar();
                            }),
                        Container(
                          height: _hight * 0.1,
                          width: _width * 0.14,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue[900]),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Timer(
                                    //     Duration(milliseconds: 500),
                                    //     () => _scrollController.jumpTo(
                                    //         _scrollController
                                    //             .position.maxScrollExtent));
                                    // _needsScroll = true;
                                    // _scrollController.jumpTo(_scrollController
                                    //     .position.maxScrollExtent);
                                    _controller.clear();
                                    var msgData = ['$textInput' + 'u'];
                                    final snackBar = SnackBar(
                                      content: Text('Yay! A SnackBar!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );
                                    //print('$msgData');
                                    msgData == null
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar)
                                        : FirebaseFirestore.instance
                                            .collection('messaging')
                                            .doc(value)
                                            .update({
                                            'createdAt': DateTime.now(),
                                            'body':
                                                FieldValue.arrayUnion(msgData)
                                          });
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
                () => _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent));
          },
          child: Icon(
            Icons.arrow_downward,
            color: Colors.blue[900],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop);
  }

  //images

  chooseImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profilepic.add(File(pickedFile.path));
      }
    });
    if (pickedFile?.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await ImagePicker().getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _profilepic.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

//image upload function
  Future<void> uploadimage() async {
    int i = 1;

    for (var img in _profilepic) {
      setState(() {
        val = i / _profilepic.length;
      });
      var postImageRef = FirebaseStorage.instance.ref().child('adImages');
      UploadTask uploadTask =
          postImageRef.child(DateTime.now().toString() + ".jpg").putFile(img);
      await (await uploadTask)
          .ref
          .getDownloadURL()
          .then((value) => imageLink.add(value + 'ui'.toString()));
      i++;
    }
  }

  bottomappbar() {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
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
            height: _hight * 0.50,
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
                _profilepic == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.cloud_upload_outlined,
                                size: 45,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             AddImage()));
                                // adImage();
                              }),
                          SizedBox(
                            height: 7,
                          ),
                          Text('Let us know your problem by uploading image')
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: _hight * 0.34,
                            width: _width * 1,
                            child: GridView.builder(
                                itemCount: _profilepic.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5),
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? Center(
                                          child: IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () => !uploading
                                                  ? chooseImage()
                                                  : null),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      _profilepic[index - 1]),
                                                  fit: BoxFit.cover)),
                                        );
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await uploadimage();
                                  await FirebaseFirestore.instance
                                      .collection('messaging')
                                      .doc(value)
                                      .update({
                                    'createdAt': DateTime.now(),
                                    'body': FieldValue.arrayUnion(imageLink)
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  height: _hight * 0.07,
                                  //width: _width * 0.1,
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
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ],
            ),
          );
        });
  }
}
