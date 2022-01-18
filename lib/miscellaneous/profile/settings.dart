import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? updatedEmail;
String? updatedob;
String? updatedNum;
String? updatedtempad;
var updatePath = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.uid);

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(
          color: Colors.grey[900],
        ),
        title: Text(
          'Profile Info',
          style: TextStyle(color: Colors.grey[900]),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                var document = snapshot.data;
                return Center(
                    child: Container(
                  padding: EdgeInsets.all(15),
                  height: double.infinity,
                  // width: 350,
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        // width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          // boxShadow: kElevationToShadow[1]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: ClipOval(
                                child: Center(
                                  child: document?['profilepic'] == null
                                      ? Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 65,
                                        )
                                      : Image.network(
                                          document?['profilepic'],
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                ),
                              ),
                              radius: 50,
                              backgroundColor: Colors.blue[800],
                            ),
                            _profilepic == null
                                ? TextButton(
                                    onPressed: () {
                                      profilePic();
                                    },
                                    child: Text(
                                      'Change',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700]),
                                    ))
                                : TextButton(
                                    onPressed: () {
                                      uploadprofile();
                                    },
                                    child: Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700]),
                                    )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        // width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          // boxShadow: kElevationToShadow[1]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              document?['email'],
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  emailUpdate(context);
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[700]),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        // width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          // boxShadow: kElevationToShadow[1]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              document?['altNum'],
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  altNumUpdate(context);
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[700]),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
              })),
    );
  }

  late File _profilepic;
  String imageLink1 = "";
  Future<void> profilePic() async {
    var profile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 40,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      if (profile != null) {
        _profilepic = File(profile.path);
      }
    });
  }

//image upload function
  Future<void> uploadprofile() async {
    var postImageRef = FirebaseStorage.instance.ref().child('legalDoc');
    UploadTask uploadTask = postImageRef
        .child(DateTime.now().toString() + ".jpg")
        .putFile(_profilepic);
    print('aaa');
    print(uploadTask);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    imageLink1 = imageUrl.toString();
    print(imageUrl);
    FirebaseFirestore.instance
        .collection('partner')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'profilepic': imageLink1});
  }
}

Future<void> emailUpdate(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Enter Email'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.emailAddress,
                      //maxLines: 2,
                      //maxLength: 20,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Enter Email',
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.blue[800],
                        ),
                        //border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        updatedEmail = value;
                      },
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          //color: Colors.blue[800],
                          onPressed: () {
                            Navigator.of(context).pop();

                            updatePath.update({'email': updatedEmail});
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ));
      });
}

Future<void> dobUpdate(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Enter Date of Birth'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.datetime,
                      //maxLines: 2,
                      //maxLength: 20,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Enter DoB',
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue[800],
                        ),
                        //border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        updatedob = value;
                      },
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          //color: Colors.blue[800],
                          onPressed: () {
                            Navigator.of(context).pop();

                            updatePath.update({'dob': updatedob});
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ));
      });
}

Future<void> altNumUpdate(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Enter Number'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.number,
                      //maxLines: 2,
                      //maxLength: 20,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Enter Number',
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Colors.blue[800],
                        ),
                        //border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                      onChanged: (value) {
                        updatedNum = value;
                      },
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          //color: Colors.blue[800],
                          onPressed: () {
                            Navigator.of(context).pop();

                            updatePath.update({'altNum': updatedNum});
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ));
      });
}

Future<void> updatedProfilePic(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Enter Address'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    height: 200,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [CircleAvatar()],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          // color: Colors.blue[800],
                          onPressed: () {
                            Navigator.of(context).pop();

                            updatePath.update({'profilepic': updatedtempad});
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ));
      });
}
