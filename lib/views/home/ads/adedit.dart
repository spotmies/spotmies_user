import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';

class PostAdEdit extends StatefulWidget {
  final String value;
  PostAdEdit({this.value});
  @override
  _PostAdEditState createState() => _PostAdEditState(value);
}

class _PostAdEditState extends StateMVC<PostAdEdit> {
  String value;
  //_PostAdEditState(this.value);

  AdController _adController;
  _PostAdEditState(this.value) : super(AdController()) {
    this._adController = controller;
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
          'Edit post',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: _hight * 1,
          width: _width * 1,
          //color: Colors.amber,
          child: ListView(
            children: [
              SizedBox(
                height: 7,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: _hight * 0.13,
                width: _width * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'money',
                    suffixIcon: Icon(Icons.money),
                    //border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    this._adController.money = value;
                  },
                ),
              ),
              SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  _adController.pickDate();
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    height: _hight * 0.13,
                    width: _width * 1,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Re-Schedule:',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Date & Time: ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  '${_adController.pickedDate.day}/${_adController.pickedDate.month}/${_adController.pickedDate.year}' +
                                      ' - ${_adController.pickedTime.hour}:${_adController.pickedTime.minute}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Icon(Icons.timer),
                          ],
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: _hight * 0.25,
                width: _width * 1,
                decoration: BoxDecoration(
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
                          Text(
                              '$_adController.latitude,$_adController.longitude'),
                          Text(_adController.add2),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_searching),
                            TextButton(
                                onPressed: () {
                                  _adController.getCurrentLocation();
                                  _adController.getAddressofLocation();
                                },
                                child: Text(
                                  'Get Location',
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.bold),
                                )),
                          ])
                    ],
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
                          color: Colors.grey[50],
                          spreadRadius: 3,
                          blurRadius: 1,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
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
                      _adController.profilepic == null
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
                                      itemCount:
                                          _adController.profilepic.length + 1,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5),
                                      itemBuilder: (context, index) {
                                        return index == 0
                                            ? Center(
                                                child: IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () =>
                                                        !_adController.uploading
                                                            ? _adController
                                                                .chooseImage()
                                                            : null),
                                              )
                                            : Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                    Container(
                                                      margin: EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  _adController
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
                                                            Icons.remove_circle,
                                                            color: Colors
                                                                .redAccent[200],
                                                          ),
                                                          onPressed: () async {
                                                            _adController
                                                                .profilepic
                                                                .removeAt(0);

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
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _adController.docid();
                        print(_adController.imageLink);

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('adpost')
                            .doc(value)
                            .update({
                          'price': this._adController.money,
                          'posttime': this._adController.now,
                          'schedule': this._adController.time,
                          'userid': _adController.uid,
                          'request': _adController.dummy,
                          'location': _adController.location,
                          'orderid': value,
                          'media': _adController.imageLink,
                          'location.latitude': _adController.latitude,
                          'location.longitude': _adController.longitude,
                          'location.add1': _adController.add3,
                          'orderstate': null,
                        });

                        //data to all orders
                        FirebaseFirestore.instance
                            .collection('allads')
                            .doc(value)
                            .update({
                          'price': this._adController.money,
                          'posttime': this._adController.now,
                          'scheduledate':
                              '${_adController.pickedDate.day}/${_adController.pickedDate.month}/${_adController.pickedDate.year}',
                          'scheduletime':
                              '${_adController.pickedTime.hour}:${_adController.pickedTime.minute}',
                          'userid': _adController.uid,
                          'request': _adController.dummy,
                          'location': _adController.location,
                          'orderid': _adController.docc.id,
                          'media': _adController.imageLink,
                          'location.latitude': _adController.latitude,
                          'location.longitude': _adController.longitude,
                          'location.add1': _adController.add3,
                          'orderstate': null,
                        });
                        _adController.dialogTrrigger(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
