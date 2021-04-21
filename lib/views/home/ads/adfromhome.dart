import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';

class PostAdFromHome extends StatefulWidget {
  final String value;
  PostAdFromHome({this.value});
  @override
  _PostAdFromHomeState createState() => _PostAdFromHomeState(value);
}

class _PostAdFromHomeState extends StateMVC<PostAdFromHome> {
  String value;
  //_PostAdFromHomeState(this.value);

  AdController _adController;
  _PostAdFromHomeState(this.value) : super(AdController()) {
    this._adController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _adController.scaffoldkey,
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
          child: Form(
            key: _adController.formkey,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: _hight * 0.1,
                  width: _width * 1,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[50],
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
                    // onSaved: (item) => _adController.adModel.title,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'title',
                      suffixIcon: Icon(Icons.report_problem),
                      //border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),

                    onChanged: (value) {
                      this._adController.title = value;
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
                          color: Colors.grey[50],
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'money',
                      suffixIcon: Icon(Icons.attach_money),
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
                      padding: EdgeInsets.all(10),
                      height: _hight * 0.18,
                      width: _width * 1,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[50],
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
                                  'Date:  ${_adController.pickedDate.day}/${_adController.pickedDate.month}/${_adController.pickedDate.year}',
                                  style: TextStyle(fontSize: 15)),
                              Text(
                                  'Time:  ${_adController.pickedTime.hour}:${_adController.pickedTime.minute}',
                                  style: TextStyle(fontSize: 15))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: () {
                    _adController.getCurrentLocation();
                    _adController.getAddressofLocation();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: _hight * 0.25,
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
                                                          !_adController
                                                                  .uploading
                                                              ? _adController
                                                                  .chooseImage()
                                                              : null),
                                                )
                                              : Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(6),
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[900]),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          _adController.buttonFromHome();
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
