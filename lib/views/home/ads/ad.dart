import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';

//path for adding post data

class PostAd extends StatefulWidget {
  @override
  _PostAdState createState() => _PostAdState();
}

class _PostAdState extends StateMVC<PostAd> {
  AdController _adController;
  _PostAdState() : super(AdController()) {
    this._adController = controller;
  }

  var latitude = "";
  var longitude = "";
  String add1 = "";
  String add2 = "";
  String add3 = "";

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _adController.scaffoldkey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[700]),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: callmethod(_adController.wid, _hight, _width),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: _hight * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_adController.wid >= 2)
              FloatingActionButton.extended(
                heroTag: 'back',
                backgroundColor: Colors.white,
                onPressed: () {
                  _adController.widDec();
                },
                label: Text(
                  '    Back    ',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            FloatingActionButton.extended(
              heroTag: 'next',
              backgroundColor: Colors.white,
              onPressed: () {
                _adController.wid == 1
                    ? _adController.step1()
                    : _adController.wid == 2
                        ? _adController.step2()
                        : _adController.step3();
              },
              label: Text(
                _adController.wid != 3 ? '    Next    ' : 'Get Service',
                style: TextStyle(color: Colors.blue[900]),
              ),
            )
          ],
        ),
      ),
    );
  }

  callmethod(int wid, double _hight, double _width) {
    return Container(
      child: wid == 1
          ? ad1(_hight, _width)
          : wid == 2
              ? ad2(_hight, _width)
              : wid == 3
                  ? ad3(_hight, _width)
                  : Center(child: CircularProgressIndicator()),
    );
  }

  Widget ad2(double hight, double width) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: hight * 0.05,
          ),
          width: width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(3, 6)),
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(-3, -3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                height: hight * 0.6,
                width: width * 0.9,
                padding: EdgeInsets.only(top: hight * 0.03),
                child: Form(
                  key: _adController.formkey,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              bottom: width * 0.05,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            height: hight * 0.1,
                            width: width * 0.8,
                            child: Center(
                              child: Text('Step 2/3'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.03, right: width * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            height: hight * 0.12,
                            width: width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Category:',
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500)),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: width * 0.03,
                                        right: width * 0.03),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[300],
                                              blurRadius: 2,
                                              spreadRadius: 2)
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: DropdownButton(
                                      underline: SizedBox(),
                                      value: _adController.dropDownValue,
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                        size: width * 0.06,
                                        color: Colors.blue[900],
                                      ),
                                      items: <int>[
                                        0,
                                        1,
                                        2,
                                        3,
                                        4,
                                        5,
                                        6,
                                        7,
                                        8,
                                        9,
                                        10,
                                        11,
                                      ].map<DropdownMenuItem<int>>((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(_adController.jobs
                                              .elementAt(value)),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          _adController.dropDownValue = newVal;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: hight * 0.01,
                            color: Colors.white,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                right: width * 0.03,
                                top: width * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            height: hight * 0.12,
                            width: width * 0.8,
                            child: TextFormField(
                              controller: _adController.problem,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please discribe your problem';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey[100])),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey[100])),
                                hintStyle: TextStyle(fontSize: 17),
                                hintText: 'Problem',
                                suffixIcon: Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.blue[900],
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: hight * 0.03, top: hight * 0.06),
                              ),
                              onChanged: (value) {
                                this._adController.title = value;
                              },
                            ),
                          ),
                          Divider(
                            thickness: hight * 0.01,
                            color: Colors.white,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                right: width * 0.03,
                                top: width * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            height: hight * 0.12,
                            width: width * 0.8,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey[100])),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey[100])),
                                hintStyle: TextStyle(fontSize: 17),
                                hintText: 'Money',
                                suffixIcon: Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.blue[900],
                                ),
                                //border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: hight * 0.03, top: hight * 0.06),
                              ),
                              onChanged: (value) {
                                this._adController.money = value;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ad1(double hight, double width) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: hight * 0.05,
          ),
          width: width * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(3, 6)),
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(-3, -3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                height: hight * 0.6,
                width: width * 0.9,
                padding: EdgeInsets.only(top: hight * 0.03),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: width * 0.05,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          height: hight * 0.1,
                          width: width * 0.8,
                          child: Center(
                            child: Text('Step 1/3'),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await _adController.pickDate(context);
                            await _adController.picktime(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  top: width * 0.03),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(15)),
                              height: hight * 0.12,
                              width: width * 0.8,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Set Schedule:',
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: hight * 0.07,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            'Date:  ' +
                                                DateFormat('dd MMM yyyy')
                                                    .format((DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            (_adController
                                                                .pickedDate
                                                                .millisecondsSinceEpoch)))),
                                            //'Date:  ${_adController.pickedDate.millisecondsSinceEpoch}',
                                            style: TextStyle(fontSize: 15)),
                                        Text(
                                            'Time:${_adController.pickedTime.format(context)}',
                                            style: TextStyle(fontSize: 15))
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Divider(
                          thickness: 10,
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            _adController.getCurrentLocation();
                            _adController.getAddressofLocation();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                right: width * 0.03,
                                top: width * 0.03),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15)),
                            height: hight * 0.25,
                            width: width * 0.8,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Location:',
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Text(_adController.latitude),
                                          Text(_adController.longitude),
                                        ],
                                      ),
                                      Text(
                                        _adController.add2,
                                      ),
                                      // SizedBox(height: hight * 0.015),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          _adController.getCurrentLocation();
                                          _adController.getAddressofLocation();
                                        },
                                        icon: Icon(
                                          Icons.gps_fixed,
                                          color: Colors.blue[900],
                                        ),
                                        label: Text(
                                          'Get Location',
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey[100]),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ad3(double hight, double width) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: hight * 0.05,
        ),
        width: width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(3, 6)),
                BoxShadow(
                    color: Colors.grey[100],
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(-3, -3))
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
              height: hight * 0.6,
              width: width * 0.9,
              padding: EdgeInsets.only(top: hight * 0.03),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: width * 0.05,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        height: hight * 0.08,
                        width: width * 0.8,
                        child: Center(
                          child: Text('Step 3/3'),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: width * 0.03,
                              right: width * 0.03,
                              top: width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15)),
                          height: hight * 0.47,
                          width: width * 0.8,
                          child: Column(
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Text(
                                    'Upload images/Video/Voice:',
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              _adController.profilepic == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        Text(
                                            'Let us know your problem by uploading image')
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: hight * 0.22,
                                          width: width * 1,
                                          child: GridView.builder(
                                              itemCount: _adController
                                                      .profilepic.length +
                                                  1,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5),
                                              itemBuilder: (context, index) {
                                                return index == 0
                                                    ? Center(
                                                        child: IconButton(
                                                            icon:
                                                                Icon(Icons.add),
                                                            onPressed: () =>
                                                                !_adController
                                                                        .uploading
                                                                    ? _adController
                                                                        .chooseImage()
                                                                    : null),
                                                      )
                                                    : Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(6),
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: FileImage(_adController
                                                                              .profilepic[
                                                                          index -
                                                                              1]),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            ),
                                                            Positioned(
                                                              left: 37.0,
                                                              bottom: 37.0,
                                                              child: IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Colors
                                                                            .redAccent[
                                                                        200],
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    _adController
                                                                        .profilepic
                                                                        .removeAt(
                                                                            0);

                                                                    refresh();
                                                                  }),
                                                            ),
                                                          ]);
                                              }),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           height: _hight * 1,
//           width: _width * 1,
//           //color: Colors.amber,
//           child: ListView(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 10, right: 5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         //offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Select Technician:',
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w500)),
//                     // SizedBox(
//                     //   width: 10,
//                     // ),
//                     Container(
//                       width: _width * 0.4,
//                       child: DropdownButton(
//                         underline: SizedBox(),
//                         value: _adController.dropDownValue,
//                         hint: Text(
//                           '$_adController.dropDownValue',
//                           style: TextStyle(fontSize: _width * 0.015),
//                         ),
//                         icon: Icon(
//                           Icons.arrow_downward_outlined,
//                           size: _width * 0.06,
//                         ),
//                         items: [
//                           DropdownMenuItem(
//                             value: 0,
//                             child: Text('AC Service'),
//                           ),
//                           DropdownMenuItem(
//                             value: 1,
//                             child: Text('Computer'),
//                           ),
//                           DropdownMenuItem(
//                             value: 2,
//                             child: Text('TV Repair'),
//                           ),
//                           DropdownMenuItem(
//                             value: 3,
//                             child: Text('development'),
//                           ),
//                           DropdownMenuItem(
//                             value: 4,
//                             child: Text('tutor'),
//                           ),
//                           DropdownMenuItem(
//                             value: 5,
//                             child: Text('beauty'),
//                           ),
//                           DropdownMenuItem(
//                             value: 6,
//                             child: Text('photography'),
//                           ),
//                           DropdownMenuItem(
//                             value: 7,
//                             child: Text('drivers'),
//                           ),
//                           DropdownMenuItem(
//                             value: 8,
//                             child: Text('events'),
//                           ),
//                         ],
//                         onChanged: (newVal) {
//                           //print(dropDownValue);
//                           setState(() {
//                             _adController.dropDownValue = newVal;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         //offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     hintStyle: TextStyle(fontSize: 17),
//                     hintText: 'title',
//                     suffixIcon: Icon(Icons.report_problem),
//                     //border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   onChanged: (value) {
//                     this._adController.title = value;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: _hight * 0.1,
//                 width: _width * 1,
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey[50],
//                         spreadRadius: 3,
//                         // offset: Offset.infinite,
//                         blurRadius: 1,
//                       )
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                         borderSide: BorderSide(width: 1, color: Colors.white)),
//                     hintStyle: TextStyle(fontSize: 17),
//                     hintText: 'money',
//                     suffixIcon: Icon(Icons.attach_money),
//                     //border: InputBorder.none,
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   onChanged: (value) {
//                     this._adController.money = value;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               InkWell(
//                 onTap: () {
//                   _adController.pickDate();
//                 },
//                 child: Container(
//                     padding: EdgeInsets.all(5),
//                     height: _hight * 0.18,
//                     width: _width * 1,
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[50],
//                             spreadRadius: 3,
//                             // offset: Offset.infinite,
//                             blurRadius: 1,
//                           )
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15)),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'Set Schedule:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: _hight * 0.04,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                                 'Date:  ${_adController.pickedDate.day}/${_adController.pickedDate.month}/${_adController.pickedDate.year}',
//                                 style: TextStyle(fontSize: 15)),
//                             Text(
//                                 'Time:  ${_adController.pickedTime.hour}:${_adController.pickedTime.minute}',
//                                 style: TextStyle(fontSize: 15))
//                           ],
//                         ),
//                       ],
//                     )),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               InkWell(
//                 onTap: () {
//                   print(_adController.longitude + '512');
//                   _adController.getCurrentLocation();
//                   _adController.getAddressofLocation();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   height: _hight * 0.25,
//                   width: _width * 1,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[50],
//                           spreadRadius: 3,
//                           blurRadius: 1,
//                         )
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Location:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500),
//                             ),
//                             Row(
//                               children: [
//                                 Text(_adController.latitude),
//                                 Text(_adController.longitude),
//                               ],
//                             ),
//                             Text(_adController.add2),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Center(
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   height: _hight * 0.35,
//                   width: _width * 1,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[50],
//                           spreadRadius: 3,
//                           blurRadius: 1,
//                         )
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Column(
//                     children: [
//                       Container(
//                           child: Row(
//                         children: [
//                           Text('Upload images:',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.w500)),
//                         ],
//                       )),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       _adController.profilepic == null
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.cloud_upload_outlined,
//                                       size: 45,
//                                       color: Colors.grey,
//                                     ),
//                                     onPressed: () {}),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Text(
//                                     'Let us know your problem by uploading image')
//                               ],
//                             )
//                           : Column(
//                               children: [
//                                 Container(
//                                   height: _hight * 0.22,
//                                   width: _width * 1,
//                                   child: GridView.builder(
//                                       itemCount:
//                                           _adController.profilepic.length + 1,
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount: 5),
//                                       itemBuilder: (context, index) {
//                                         return index == 0
//                                             ? Center(
//                                                 child: IconButton(
//                                                     icon: Icon(Icons.add),
//                                                     onPressed: () =>
//                                                         !_adController.uploading
//                                                             ? _adController
//                                                                 .chooseImage()
//                                                             : null),
//                                               )
//                                             : Stack(
//                                                 alignment: Alignment.topRight,
//                                                 children: [
//                                                     Container(
//                                                       margin: EdgeInsets.all(6),
//                                                       decoration: BoxDecoration(
//                                                           image: DecorationImage(
//                                                               image: FileImage(
//                                                                   _adController
//                                                                           .profilepic[
//                                                                       index -
//                                                                           1]),
//                                                               fit: BoxFit
//                                                                   .cover)),
//                                                     ),
//                                                     Positioned(
//                                                       left: 37.0,
//                                                       bottom: 37.0,
//                                                       child: IconButton(
//                                                           icon: Icon(
//                                                             Icons.remove_circle,
//                                                             color: Colors
//                                                                 .redAccent[200],
//                                                           ),
//                                                           onPressed: () async {
//                                                             _adController
//                                                                 .profilepic
//                                                                 .removeAt(0);

//                                                             refresh();
//                                                           }),
//                                                     ),
//                                                   ]);
//                                       }),
//                                 ),
//                               ],
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.blue[900]),
//                       ),
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         // _adController.adbutton();
//                         FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(FirebaseAuth.instance.currentUser.uid)
//                             .collection('adpost')
//                             .doc(_adController.docc.id)
//                             .set({'dummy': 'dsgdfga'});
//                         print(_adController.docc.id);
//                       })
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
