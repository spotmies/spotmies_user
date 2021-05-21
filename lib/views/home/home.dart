import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/views/home/ads/adfromHome.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';

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
        backgroundColor: Colors.grey[50],
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
                // SizedBox(
                //   width: 3,
                // ),
                Expanded(
                  child: TextButton(
                    child: Text(
                      _homeController.add2 == null
                          ? 'seethammadhara'
                          : _homeController.add2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                    onPressed: () async {
                      await _homeController.getAddressofLocation();
                    },
                  ),
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
                onPressed: () async {
                  // await _stepperPersonalInfo.firebaseMessaging
                  //     .subscribeToTopic('sendmeNotification');
                  // //_shownotification();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Notifications()));
                }),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 15),
          width: _width * 1,
          child: GridView.builder(
            itemCount: _homeController.jobs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 1, mainAxisSpacing: 15),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '$index',
                              )));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                         boxShadow:
                                [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                      offset: Offset(3, 3)),
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                      offset: Offset(-3, -3))
                                ]
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        child: Icon(
                          _homeController.icons[index],
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text(_homeController.jobs[index],
                        style: TextStyle(fontSize: _width * 0.03))
                  ],
                ),
              );
            },
          ),
        ));
  }
}
