import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:spotmies/views/home/ads/ad.dart';
import 'package:spotmies/views/home/ads/adfromHome.dart';
import 'package:spotmies/views/home/notification.dart';
import 'package:spotmies/controllers/home_controllers/home_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  HomeController _stepperPersonalInfo;
  _HomeState() : super(HomeController()) {
    this._stepperPersonalInfo = controller;
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
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue[900],
              size: 15,
            ),
            SizedBox(
              width: 3,
            ),
            TextButton(
              onPressed: () async {
                await _stepperPersonalInfo.getAddressofLocation();
              },
              child: Text(
                _stepperPersonalInfo.add2 == null
                    ? 'seethammadhara'
                    : _stepperPersonalInfo.add2,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.blue[900],
              ),
              onPressed: () async {
                await _stepperPersonalInfo.firebaseMessaging
                    .subscribeToTopic('sendmeNotification');
                //_shownotification();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications()));
              }),
          SizedBox(
            width: 5,
          ),
        ],
      ),

      body: Center(
        child: Container(
          width: _width * 0.95,
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 4,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '9',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.electrical_services),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Electrician', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '10',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.carpenter),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Carpentor', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '11',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.plumbing_sharp),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Plumber', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '0',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.miscellaneous_services),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text(
                      'AC Service',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '1',
                              )));
                  //idy2702603
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.laptop_mac),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Computer', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '2',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.developer_mode),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Development', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '3',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.tv),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('TV', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '4',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person_search),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Tutor', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '5',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.face),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Beauty', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '6',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.camera_enhance),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Camera', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '7',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.car_rental),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Drivers', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostAdFromHome(
                                value: '8',
                              )));
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.event),
                    ),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Text('Events', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //floating action button
      floatingActionButton: FloatingActionButton(
        tooltip: 'Post Add',
        backgroundColor: Colors.white,
        onPressed: () {},
        child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue[900],
            ),
            onPressed: () {
              
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PostAd()));
            }),
      ),
    );
  }
}
