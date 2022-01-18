import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/profile_controllers/settings_controller.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends StateMVC<Setting> {
  SettingsController _settingsController;
  UniversalProvider up;

  _SettingState() : super(SettingsController()) {
    this._settingsController = controller;
  }

  @override
  void initState() {
    var details = Provider.of<UserDetailsProvider>(context, listen: false);
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("profile");

    details.userDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final height(context) = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     kToolbarHeight;
    // final width(context) = MediaQuery.of(context).size.width;
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
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        if (data.user == null) return Center(child: profileShimmer(context));
        var u = data.user;
        return Center(
            child: Container(
          padding: EdgeInsets.all(15),
          height: double.infinity,
          // width: 350,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: height(context) * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: width(context) * 0.15,
                      width: width(context) * 0.15,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: ClipOval(
                          child: Center(
                            child: u['pic'] == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.blueGrey,
                                    size: width(context) * 0.12,
                                  )
                                : Image.network(
                                    u['pic'],
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
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
                                  fontSize: 18, color: Colors.grey[700]),
                            ))
                        : TextButton(
                            onPressed: () async {
                              await _settingsController.uploadprofile();
                            },
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
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
                      u['eMail'],
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          emailUpdate(context);
                        },
                        child: Text(
                          'Change',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
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
                      u['altNum'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          // altNumUpdate(context);
                        },
                        child: Text(
                          'Change',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
      }),
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
