import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';
import 'package:spotmies/views/home/ads/ad.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  HomeController _homeController;
  _HomeState() : super(HomeController()) {
    this._homeController = controller;
  }

  @override
  Widget build(BuildContext context) {
    //getToken();
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 48,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            width: _width * 0.5,
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue[900],
                  size: 15,
                ),
                TextButton(
                  child: Text(
                      _homeController.add2 == null
                          ? 'seethammadhara'
                          : _homeController.add2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.josefinSans(
                        fontSize: _width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      )),
                  onPressed: () async {
                    await _homeController.getAddressofLocation();
                  },
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.blue[900],
                ),
                onPressed: () async {}),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 15, left: 5, right: 5),
          width: _width * 1,
          child: GridView.builder(
            itemCount: _homeController.jobs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FloatingActionButton(
                        mini: true,
                        heroTag: '$index',
                        backgroundColor: Colors.blue[900],
                        child: Icon(
                          _homeController.icons[index],
                          color: Colors.white,
                          size: _width * 0.05,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostAd( 
                                        jobFromHome: index,
                                      )));
                        }),
                  ),
                  SizedBox(
                    height: _hight * 0.005,
                  ),
                  Text(_homeController.jobs[index],
                      style: GoogleFonts.josefinSans(
                        fontSize: _width * 0.03,
                        color: Colors.black,
                      ))
                ],
              );
            },
          ),
        ));
  }
}
