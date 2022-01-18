import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

//path for adding post data
var docc;
Future<void> docid() async {
  docc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('adpost')
      .doc();
}

class PostAdFromHome extends StatefulWidget {
  final String value;
  PostAdFromHome({required this.value});
  @override
  _PostAdFromHomeState createState() => _PostAdFromHomeState(value);
}

class _PostAdFromHomeState extends State<PostAdFromHome> {
  String value;
  _PostAdFromHomeState(this.value);

  String? service;
  String? title;
  String? upload;
  String? discription;
  String? money;
  String? state;
  String? adtime;
  //image
  List<File> _profilepic = [];
  bool uploading = false;
  double val = 0;

  List imageLink = [];
  //date time picker
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  DateTime now = DateTime.now();

  // drop down menu for service type
  int dropDownValue = 0;
  //dummy data for accept/reject requests condition
  String dummy = 'nothing';
  //user id
  var uid = FirebaseAuth.instance.currentUser?.uid;
  //location
  String location = 'seethammadhara,visakhapatnam';

  // location and place access

  var latitude = "";
  var longitude = "";
  String add1 = "";
  String add2 = "";
  String add3 = "";

  //function for location
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);

    String lat = '${position.latitude}';
    String long = '${position.longitude}';

    print('$lat,$long');

    setState(() {
      latitude = '${position.latitude}';
      longitude = '${position.longitude}';
    });
  }

  @override
  void initState() {
    super.initState();
    getAddressofLocation();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }
  // var myInt = int.tryParse('');

  getAddressofLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      add1 = addresses.first.featureName;
      add2 = addresses.first.addressLine;
      add3 = addresses.first.locality;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Fill details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: _hight * 1,
          width: _width * 1,
          //color: Colors.amber,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                height: _hight * 0.1,
                width: _width * 1,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        spreadRadius: 3,
                        //offset: Offset.infinite,
                        blurRadius: 1,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Technician:',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 10,
                    ),
                    if (value == '0') Text('AC Service'),
                    if (value == '1') Text('Computer'),
                    if (value == '2') Text('TV Repair'),
                    if (value == '3') Text('Development'),
                    if (value == '4') Text('Tutor'),
                    if (value == '5') Text('Beauty'),
                    if (value == '6') Text('Photography'),
                    if (value == '7') Text('Drivers'),
                    if (value == '8') Text('Event Management'),
                    if (value == '9') Text('Electrician'),
                    if (value == '10') Text('Carpentor'),
                    if (value == '11') Text('Plumber'),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: _hight * 0.1,
                width: _width * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'title',
                    suffixIcon: Icon(Icons.report_problem),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    this.title = value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: _hight * 0.1,
                width: _width * 1,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade50,
                        spreadRadius: 3,
                        //offset: Offset.infinite,
                        blurRadius: 1,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(width: 1, color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'money',
                    suffixIcon: Icon(Icons.attach_money),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    this.money = value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  _pickedDate();
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: _hight * 0.18,
                    width: _width * 1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade50,
                            spreadRadius: 3,
                            //offset: Offset.infinite,
                            blurRadius: 1,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Set Schedule:',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _hight * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                'Date:  ${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}',
                                style: TextStyle(fontSize: 15)),
                            Text(
                                'Time:  ${pickedTime?.hour}:${pickedTime?.minute}',
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // TextButton(
                        //     onPressed: () {
                        //       _pickedDate();
                        //     },
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.timer, color: Colors.black),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           'Set Schedule',
                        //           style: TextStyle(color: Colors.blue[800]),
                        //         )
                        //       ],
                        //     ))
                      ],
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  getCurrentLocation();
                  getAddressofLocation();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: _hight * 0.25,
                  width: _width * 1,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade50,
                          spreadRadius: 3,
                          //offset: Offset.infinite,
                          blurRadius: 1,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'location:',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text('$latitude,$longitude'),
                            Text(add2),
                          ],
                        ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //      // Icon(Icons.location_searching),
                        //       // TextButton(
                        //       //     onPressed: () {
                        //       //       getCurrentLocation();
                        //       //       getAddressofLocation();
                        //       //     },
                        //       //     child: Text(
                        //       //       'Get Location',
                        //       //       style: TextStyle(
                        //       //           color: Colors.blue[800],
                        //       //           fontWeight: FontWeight.bold),
                        //       //     )),
                        //     ])
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: _hight * 0.35,
                  width: _width * 1,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade50,
                          spreadRadius: 3,
                          // offset: Offset.infinite,
                          blurRadius: 1,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Upload images:',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
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
                                Text(
                                    'Let us know your problem by uploading image')
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  height: _hight * 0.22,
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
                                                            _profilepic[
                                                                index - 1]),
                                                        fit: BoxFit.cover)),
                                              );
                                      }),
                                ),
                                // Container(
                                //     height: _hight * 0.05,
                                //     width: _width * 1,
                                //     color: Colors.white,
                                //     child: Center(
                                //       child: Center(
                                //         child: TextButton(
                                //             onPressed: () {
                                //               uploadimage();
                                //             },
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.center,
                                //               children: [
                                //                 Icon(
                                //                     Icons.cloud_upload_outlined,
                                //                     color: Colors.black),
                                //                 SizedBox(
                                //                   width: 10,
                                //                 ),
                                //                 Text(
                                //                   'Upload',
                                //                   style: TextStyle(
                                //                       color: Colors.blue[800]),
                                //                 )
                                //               ],
                                //             )),
                                //       ),
                                //     ))
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[900]),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      // color: Colors.blue[900],
                      // splashColor: Colors.blue,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(10.0))),
                      onPressed: () async {
                        docid();
                        await uploadimage();
                        var orderid = await docc.id;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('adpost')
                            .doc(orderid)
                            .set({
                          'job': this.dropDownValue,
                          'problem': this.title,
                          'money': this.money,
                          'posttime': this.now,
                          'scheduledate':
                              '${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}',
                          'scheduletime':
                              '${pickedTime?.hour}:${pickedTime?.minute}',
                          'userid': uid,
                          'request': dummy,
                          'orderid': orderid,
                          'media': FieldValue.arrayUnion(imageLink),
                          'location': {
                            'latitude': latitude,
                            'longitude': longitude,
                            'add1': add3,
                          },
                          'orderstate': 0,
                        });

                        await FirebaseFirestore.instance
                            .collection('allads')
                            .doc(orderid)
                            .set({
                          'job': this.dropDownValue,
                          'problem': this.title,
                          'money': this.money,
                          'posttime': this.now,
                          'scheduledate':
                              '${pickedDate?.day}/${pickedDate?.month}/${pickedDate?.year}',
                          'scheduletime':
                              '${pickedTime?.hour}:${pickedTime?.minute}',
                          'userid': uid,
                          'request': dummy,
                          'orderid': orderid,
                          'media': FieldValue.arrayUnion(imageLink),
                          'location': {
                            'latitude': latitude,
                            'longitude': longitude,
                            'add1': add3,
                          },
                          'orderstate': 0,
                        });
                        Navigator.pop(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _pickedDate() async {
    if (pickedDate != null) {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: pickedDate!,
          firstDate: DateTime(DateTime.now().year - 0, DateTime.now().month - 0,
              DateTime.now().day - 0),
          lastDate: DateTime(DateTime.now().year + 1));
      if (date != null) {
        setState(() async {
          if (pickedTime != null) {
            TimeOfDay? t = await showTimePicker(
              context: context,
              initialTime: pickedTime!,
            );
            if (t != null) {
              setState(() {
                pickedTime = t;
              });
            }
            pickedDate = date;
          }
        });
      }
    }
  }

  // _pickedTime() async {

  // }

  // image pick
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
          .then((value) => imageLink.add(value.toString()));
      i++;
    }
  }
}

// Future<bool> dialogTrrigger(BuildContext context) async {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Acknowledgement'),
//           content: Text('Post Succussfully Published'),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   // Navigator.of(context).pop();
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => GoogleNavBar()));
//                 },
//                 child: Text('ok'))
//           ],
//         );
//       });
// }

// class CrudMethods {
//   bool isLoggedIn() {
//     if (FirebaseAuth.instance.currentUser != null) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<void> userdata(postData) async {
//     if (isLoggedIn()) {
//       docc.set(postData).catchError((e) {
//         print(e);
//       });
//     } else {
//       print('You need to login');
//     }
//   }

//   Future<void> allorders(postData) async {
//     if (isLoggedIn()) {
//       FirebaseFirestore.instance
//           .collection('allads')
//           .doc(docc.id)
//           .set(postData)
//           .catchError((e) {
//         print(e);
//       });
//     } else {
//       print('You need to login');
//     }
//   }
// }
