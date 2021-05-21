import 'package:flutter/material.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StateMVC<Profile> {
  ProfileController _profileController;
  _ProfileState() : super(ProfileController()) {
    this._profileController = controller;
  }

  List list = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  //static final String path = "lib/src/pages/settings/settings3.dart";

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _profileController.scaffoldkey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.grey[800]),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: StreamBuilder(
              stream: _profileController.profileSteam,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                var document = snapshot.data;
                return Container(
                  // padding: EdgeInsets.only(top: _hight * 0.08),
                  height: _hight * 1,
                  width: _width * 1,
                  child: Column(
                    children: [
                      Stack(alignment: Alignment.topRight, children: [
                        Container(
                          height: _hight * 0.4,
                          width: _width * 0.9,
                          decoration: BoxDecoration(
                              gradient: _profileController.color,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                    offset: Offset(4, 4)),
                              ]
                              // boxShadow: kElevationToShadow[1]
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                child: ClipOval(
                                  child: Center(
                                    child: document['profilepic'] == null
                                        ? Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: _width * 0.2,
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
                                radius: _width * 0.13,
                                backgroundColor: Colors.blue[800],
                              ),
                              Column(
                                children: [
                                  Text(
                                    document['name'] == null
                                        ? 'New User'
                                        : document['name'],
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['email'] == null
                                            ? 'not found'
                                            : document['email'],
                                        style: TextStyle(
                                            color: Colors.grey[100],
                                            fontSize: _width * 0.03,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      Text(
                                        document['num'] == null
                                            ? 'not found'
                                            : document['num'],
                                        style: TextStyle(
                                            color: Colors.grey[100],
                                            fontSize: _width * 0.03,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.white10,
                                    indent: _width * 0.15,
                                    endIndent: _width * 0.15,
                                  ),
                                  Container(
                                    height: _hight * 0.1,
                                    // color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: _width * 0.4,
                                          // color: Colors.amber,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '₹ ' + '1234',
                                                  style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: _width * 0.07,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'Total Savings',
                                                  style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: _width * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          width: _width * 0.002,
                                          color: Colors.white10,
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width: _width * 0.4,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '12',
                                                  style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: _width * 0.07,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'Total orders',
                                                  style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: _width * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white10,
                                    indent: _width * 0.15,
                                    endIndent: _width * 0.15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: _width * 0.03,
                          top: _width * 0.03,
                          child: IconButton(
                              icon: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                  )),
                              onPressed: () {}),
                        )
                      ]),
                      Container(
                        color: Colors.white,
                        height: _hight * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: _hight * 0.001,
                              color: Colors.grey[400],
                              width: _width * 0.35,
                            ),
                            Container(
                              // color: Colors.amber,
                              width: _width * 0.3,
                              child: Center(
                                  child: Text(
                                'More',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w700),
                              )),
                            ),
                            Container(
                              height: _hight * 0.001,
                              color: Colors.grey[400],
                              width: _width * 0.35,
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: _hight * 0.38,
                          width: _width * 1,
                          color: Colors.white,
                          child: Center(
                            child: GridView.builder(
                                itemCount: 6,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (index == 0) {
                                        _profileController.share();
                                      }
                                      if (index == 1) {
                                        _profileController.privacy();
                                      }
                                      if (index == 3) {
                                        _profileController.settings();
                                      }
                                      if (index == 4) {
                                        _profileController.help();
                                      }
                                      if (index == 5) {
                                        _profileController.signout();
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: _profileController.shadow,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Stack(
                                        children: [
                                          Center(
                                              child: Text(
                                            _profileController.tabnames[index],
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500),
                                          )),
                                          Positioned(
                                            right: _width * 0.01,
                                            top: _width * 0.01,
                                            child: CircleAvatar(
                                              radius: _width * 0.04,
                                              backgroundColor: Colors.blue[900],
                                              child: Icon(
                                                _profileController.icons[index],
                                                color: Colors.white,
                                                size: _width * 0.04,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )),
                    ],
                  ),
                );
              }),
        ));
  }
}
