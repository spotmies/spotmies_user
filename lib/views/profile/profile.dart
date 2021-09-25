import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textFormFieldWidget.dart';
import 'package:spotmies/utilities/uploadFilesToCloud.dart';
// import 'package:spotmies/views/profile/editDetailsBS.dart';
import 'package:spotmies/views/profile/feedBack.dart';
import 'package:spotmies/views/profile/help&supportBS.dart';
import 'package:spotmies/views/profile/orderHistoryBS.dart';
import 'package:spotmies/views/profile/privacyPolicies.dart';
import 'package:spotmies/controllers/profile_controllers/profile_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/views/profile/inviteBS.dart';
import 'package:spotmies/views/profile/profilePic.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/profile/promotionsBS.dart';
import 'package:spotmies/views/profile/settingsBS.dart';
import 'package:spotmies/views/profile/signoutBS.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StateMVC<Profile> {
  ProfileController _profileController;
  UserDetailsProvider profileProvider;

  _ProfileState() : super(ProfileController()) {
    this._profileController = controller;
  }

  var mode = true;

  List tabnames = [
    'Invite a friend',
    'Privacy Policies',
    'Order History',
    'Promotions',
    'Help & Support',
    'FeedBack',
    'Settings',
    'SignOut',
  ];
  List icons = [
    Icons.share,
    Icons.security,
    Icons.history,
    Icons.local_offer,
    Icons.help,
    Icons.feedback,
    Icons.settings,
    Icons.power_settings_new
  ];
  var editpic;

  @override
  void initState() {
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    editpic = profileProvider.getUser['pic'];
    super.initState();
  }

  onClickk() {
    print("onClick");
  }

  Future editDetails(BuildContext context, {details}) {
    final _width = MediaQuery.of(context).size.width;
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    log(details.toString());
    TextEditingController nameController =
        TextEditingController(text: details['name'].toString());
    TextEditingController emailController =
        TextEditingController(text: details['eMail']?.toString() ?? "");
    TextEditingController mobileNoController =
        TextEditingController(text: details['altNum']?.toString() ?? "");
    var nameformkey = GlobalKey<FormState>();
    var emailformkey = GlobalKey<FormState>();
    var mobileformkey = GlobalKey<FormState>();
    Future<void> submitChange() async {
      profileProvider.setLoader(true);
      Navigator.pop(context);
      String profilePicLink =
          await uploadFilesToCloud(editpic, cloudLocation: "userDocs");

      var body = {
        "name": nameController.text,
        "eMail": emailController.text,
        "altNum": mobileNoController.text,
        "pic": profilePicLink
      };
      print(body);

      var resp = await _profileController.updateProfileDetails(body);
      if (resp != false) {
        log(resp.toString());
        profileProvider.setUser(resp);
      }
    }

    pickImage() async {
      print(" profile $editpic");
      final pickedFile = await ImagePicker().getImage(
          source: ImageSource.camera,
          imageQuality: 10,
          preferredCameraDevice: CameraDevice.rear);
      editpic = File(pickedFile?.path);
      setState(() {});
      refresh();

      // if (pickedFile.path == null) retrieveLostData();
    }

    return showModalBottomSheet(
        context: context,
        elevation: 22,
        isScrollControlled: true,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            height: _hight * 0.9,
            child: ListView(
              children: [
                Center(
                  child: ProfilePic(
                    profile: editpic,
                    name: details['name'],
                    size: _width * 0.22,
                    onClick: pickImage,
                    onClickLabel: "change profile",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Profile',
                    style:
                        fonts(_width * 0.05, FontWeight.w600, Colors.grey[900]),
                  ),
                ),
                Container(
                    height: _hight * 0.55,
                    padding: EdgeInsets.only(top: 20),
                    child: ListView(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          child: Form(
                              key: nameformkey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: TextFieldWidget(
                                      controller: nameController,
                                      hint: 'Enter your name Here',
                                      label: "Name",
                                      enableBorderColor: Colors.grey,
                                      focusBorderColor: Colors.indigo[900],
                                      enableBorderRadius: 15,
                                      focusBorderRadius: 15,
                                      errorBorderRadius: 15,
                                      focusErrorRadius: 15,
                                      validateMsg: 'Enter Valid Name',
                                      maxLines: 1,
                                      postIcon: Icon(Icons.edit),
                                      postIconColor: Colors.indigo[900],
                                    ),
                                  ),
                                ],
                              ))),
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          child: Form(
                              key: emailformkey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: TextFieldWidget(
                                      controller: emailController,
                                      hint: 'Enter your Email Here',
                                      label: "Email",
                                      enableBorderColor: Colors.grey,
                                      focusBorderColor: Colors.indigo[900],
                                      enableBorderRadius: 15,
                                      focusBorderRadius: 15,
                                      errorBorderRadius: 15,
                                      focusErrorRadius: 15,
                                      validateMsg: 'Enter Valid Name',
                                      maxLines: 1,
                                      postIcon: Icon(Icons.email_rounded),
                                      postIconColor: Colors.indigo[900],
                                    ),
                                  ),
                                ],
                              ))),
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          child: Form(
                              key: mobileformkey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: TextFieldWidget(
                                      maxLength: 10,
                                      formatter: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      controller: mobileNoController,
                                      hint: 'Alternative',
                                      enableBorderColor: Colors.grey,
                                      focusBorderColor: Colors.indigo[900],
                                      enableBorderRadius: 15,
                                      focusBorderRadius: 15,
                                      errorBorderRadius: 15,
                                      focusErrorRadius: 15,
                                      validateMsg: 'Enter Valid Number',
                                      maxLines: 1,
                                      label: "Alternative Number",
                                      postIcon: Icon(Icons.phone),
                                      postIconColor: Colors.indigo[900],
                                    ),
                                  ),
                                ],
                              ))),
                    ])),
                Container(
                  padding: EdgeInsets.all(5),
                  child: ElevatedButtonWidget(
                    bgColor: Colors.indigo[900],
                    minWidth: _width,
                    height: _hight * 0.06,
                    textColor: Colors.grey[50],
                    buttonName: 'Save',
                    textSize: _width * 0.05,
                    textStyle: FontWeight.w600,
                    borderRadius: 5.0,
                    borderSideColor: Colors.indigo[900],
                    onClick: submitChange,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    log("============ Render Profile ==============");
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _profileController.scaffoldkey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile',
            style: GoogleFonts.josefinSans(
                color: Colors.grey[900], fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                radius: _width * 0.046,
                backgroundColor: Colors.indigo[100],
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        mode = !mode;
                      });
                    },
                    icon: Icon(
                      !mode ? Icons.light_mode : Icons.dark_mode,
                      size: _width * 0.05,
                      color: mode ? Colors.grey[800] : Colors.white,
                    ))),
          )
        ],
      ),
      body: Container(
        child: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          var u = data.getUser;

          if (data.getLoader || u == null)
            return Center(child: profileShimmer(context));
          // return TextButton(
          //     onPressed: () {
          //       signOut(context);
          //     },
          //     child: Text("logout"));
          return ListView(
            children: [
              profilePic(context, u['pic'], u['name'], onClick: () {
                editDetails(context, details: u);
              }),
              Container(
                height: _hight * 0.08,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      u['name'] ?? 'Spotmies User',
                      style: fonts(
                          _width * 0.05, FontWeight.w600, Colors.grey[900]),
                    ),
                    Text(
                      u['eMail'] ?? u['phNum'],
                      style: fonts(
                          _width * 0.03, FontWeight.w500, Colors.grey[900]),
                    )
                  ],
                ),
              ),
              Container(
                height: _hight * 0.08,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: _width * 0.4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ' + '1234',
                              style: fonts(_width * 0.04, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                            Text(
                              'Total Savings',
                              style: fonts(_width * 0.02, FontWeight.w500,
                                  Colors.grey[900]),
                            ),
                          ]),
                    ),
                    Container(
                      width: _width * 0.002,
                      height: _hight * 0.04,
                      color: Colors.grey[500],
                    ),
                    Container(
                      width: _width * 0.4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              u['orders'].length.toString(),
                              style: fonts(_width * 0.04, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                            Text('Total orders',
                                style: fonts(_width * 0.02, FontWeight.w500,
                                    Colors.grey[900])),
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                height: _hight * 0.6,
                child: ListView.builder(
                    itemCount: tabnames.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: index == tabnames.length - 1
                                  ? _hight * 0.09
                                  : 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ]),
                            child: ListTile(
                              onTap: () {
                                if (index == 0) {
                                  invites(context, _hight, _width);
                                }
                                if (index == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PrivacyPolicyWebView()));
                                }
                                if (index == 2) {
                                  history(context, _hight, _width);
                                }
                                if (index == 3) {
                                  promotions(context, _hight, _width);
                                }
                                if (index == 4) {
                                  helpAndSupport(context, _hight, _width);
                                }
                                if (index == 5) {
                                  rating(context, _hight, _width);
                                }
                                if (index == 6) {
                                  settings(context, _hight, _width);
                                }
                                if (index == 7) {
                                  signOut(context);
                                }
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(icons[index], size: _width * 0.04),
                                ],
                              ),
                              title: Text(tabnames[index],
                                  style: fonts(_width * 0.04, FontWeight.w500,
                                      Colors.blueGrey[900])),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: _width * 0.04,
                              ),
                            ),
                          ));
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}






//  Container(
//                 height: _hight * 1,
//                 width: _width * 1,
//                 child: Column(
//                   children: [
//                     Container(
//                         height: _hight * 0.38,
//                         width: _width * 1,
//                         color: Colors.white,
//                         // padding: EdgeInsets.only(left: 10,right: 10),
//                         child: Center(
//                           child: GridView.builder(
//                               itemCount: 6,
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 15,
//                                       mainAxisSpacing: 15),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     // grid[index]();
//                                     if (index == 0) {
//                                       _profileController.share();
//                                     }
//                                     if (index == 1) {
//                                       _profileController.privacy();
//                                     }
//                                     if (index == 3) {
//                                       _profileController.editProfile();
//                                     }
//                                     if (index == 4) {
//                                       _profileController.help();
//                                     }
//                                     if (index == 5) {
//                                       _profileController.signout();
//                                     }
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: _profileController.shadow,
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(15),
//                                             bottomRight: Radius.circular(15))),
//                                     child: Stack(
//                                       children: [
//                                         Center(
//                                             child: Text(
//                                           _profileController.tabnames[index],
//                                           style: TextStyle(
//                                               color: Colors.grey[700],
//                                               fontWeight: FontWeight.w500),
//                                         )),
//                                         Positioned(
//                                           right: _width * 0.01,
//                                           top: _width * 0.01,
//                                           child: CircleAvatar(
//                                             radius: _width * 0.04,
//                                             backgroundColor: Colors.blue[900],
//                                             child: Icon(
//                                               _profileController.icons[index],
//                                               color: Colors.white,
//                                               size: _width * 0.04,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         )),
//                   ],
//                 ),
//               ),

// Container(
//                       color: Colors.white,
//                       height: _hight * 0.1,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: _hight * 0.001,
//                             color: Colors.grey[400],
//                             width: _width * 0.35,
//                           ),
//                           Container(
//                             // color: Colors.amber,
//                             width: _width * 0.3,
//                             child: Center(
//                                 child: Text(
//                               'More',
//                               style: TextStyle(
//                                   color: Colors.grey[500],
//                                   fontWeight: FontWeight.w700),
//                             )),
//                           ),
//                           Container(
//                             height: _hight * 0.001,
//                             color: Colors.grey[400],
//                             width: _width * 0.35,
//                           )
//                         ],
//                       ),
//                     ),

//  Stack(alignment: Alignment.topRight, children: [
                      
//                       Positioned(
//                         right: _width * 0.03,
//                         top: _width * 0.03,
//                         child: IconButton(
//                             icon: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 child: Icon(
//                                   Icons.edit,
//                                   color: Colors.indigo,
//                                 )),
//                             onPressed: () {
//                               _profileController.editProfile();
//                             }),
//                       )
//                     ]),


// Container(
//                         height: _hight * 0.4,
//                         width: _width * 0.9,
//                         decoration: BoxDecoration(
//                             gradient: _profileController.color,
//                             borderRadius: BorderRadius.circular(50),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey[300],
//                                   blurRadius: 2,
//                                   spreadRadius: 2,
//                                   offset: Offset(4, 4)),
//                             ]),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CircleAvatar(
//                               child: ClipOval(
//                                 child: Center(
//                                   child: u['pic'] == null
//                                       ? Icon(
//                                           Icons.person,
//                                           color: Colors.white,
//                                           size: _width * 0.2,
//                                         )
//                                       : Image.network(
//                                           u['pic'],
//                                           fit: BoxFit.cover,
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                         ),
//                                 ),
//                               ),
//                               radius: _width * 0.13,
//                               backgroundColor: Colors.blue[800],
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   u['name'] == null ? 'New User' : u['name'],
//                                   style: TextStyle(
//                                       fontSize: 25, color: Colors.white),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       u['eMail'] == null
//                                           ? 'not found'
//                                           : u['eMail'],
//                                       style: TextStyle(
//                                           color: Colors.grey[100],
//                                           fontSize: _width * 0.03,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     SizedBox(
//                                       width: _width * 0.05,
//                                     ),
//                                     Text(
//                                       u['phNum'] == null
//                                           ? 'not found'
//                                           : '+91 ' + u['phNum'].toString(),
//                                       style: TextStyle(
//                                           color: Colors.grey[100],
//                                           fontSize: _width * 0.03,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.white10,
//                                   indent: _width * 0.15,
//                                   endIndent: _width * 0.15,
//                                 ),
//                                 Container(
//                                   height: _hight * 0.1,
//                                   // color: Colors.white,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Container(
//                                         width: _width * 0.4,
//                                         // color: Colors.amber,
//                                         child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 '₹ ' + '1234',
//                                                 style: TextStyle(
//                                                     color: Colors.grey[100],
//                                                     fontSize: _width * 0.07,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               Text(
//                                                 'Total Savings',
//                                                 style: TextStyle(
//                                                     color: Colors.grey[100],
//                                                     fontSize: _width * 0.02,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                             ]),
//                                       ),
//                                       Container(
//                                         width: _width * 0.002,
//                                         color: Colors.white10,
//                                       ),
//                                       Container(
//                                         // color: Colors.amber,
//                                         width: _width * 0.4,
//                                         child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 u['orders'].length.toString(),
//                                                 style: TextStyle(
//                                                     color: Colors.grey[100],
//                                                     fontSize: _width * 0.07,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               Text(
//                                                 'Total orders',
//                                                 style: TextStyle(
//                                                     color: Colors.grey[100],
//                                                     fontSize: _width * 0.02,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                             ]),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Divider(
//                                   color: Colors.white10,
//                                   indent: _width * 0.15,
//                                   endIndent: _width * 0.15,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),