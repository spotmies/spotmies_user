import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/profile_controllers/settings_controller.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends StateMVC<Setting> {
  SettingsController _settingsController;
  _SettingState() : super(SettingsController()) {
    this._settingsController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _settingsController.scaffoldkey,
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
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
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
                        height: _hight * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: _width * 0.15,
                              width: _width * 0.15,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: ClipOval(
                                  child: Center(
                                    child: document['profilepic'] == null
                                        ? Icon(
                                            Icons.person,
                                            color: Colors.blueGrey,
                                            size: _width * 0.12,
                                          )
                                        : Image.network(
                                            document['profilepic'],
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            _settingsController.profilepic == null
                                ? TextButton(
                                    onPressed: () {
                                      _settingsController.profilePic();
                                    },
                                    child: Text(
                                      'Change',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700]),
                                    ))
                                : TextButton(
                                    onPressed: () async {
                                      await _settingsController.uploadprofile();
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
                              document['email'],
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
                              document['altnum'],
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
                          _settingsController.updatedEmail = value;
                        },
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            //color: Colors.blue[800],
                            onPressed: () {
                              Navigator.of(context).pop();

                              _settingsController.updatePath.update(
                                  {'email': _settingsController.updatedEmail});
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
                          _settingsController.updatedob = value;
                        },
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            //color: Colors.blue[800],
                            onPressed: () {
                              Navigator.of(context).pop();

                              _settingsController.updatePath.update(
                                  {'dob': _settingsController.updatedob});
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
                          _settingsController.updatedNum = value;
                        },
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            //color: Colors.blue[800],
                            onPressed: () {
                              Navigator.of(context).pop();

                              _settingsController.updatePath.update(
                                  {'altNum': _settingsController.updatedNum});
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

                              _settingsController.updatePath.update({
                                'profilepic': _settingsController.updatedtempad
                              });
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
}
