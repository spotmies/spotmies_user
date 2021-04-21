import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          height: _hight * 1,
          width: _width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          // borderRadius: BorderRadius.circular(20)),
          child: ListView(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.person_search,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //         Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.car_repair,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                  InkWell(
                      onTap: () => {
                            //          Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => Publish()))
                          },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 50,
                              width: 200,
                              child: Text(
                                'notifications_active',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[600],
                                )),
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
