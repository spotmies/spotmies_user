import 'package:flutter/material.dart';
import 'package:spotmies/views/home/ads/ad.dart';
import 'package:spotmies/views/home/home.dart';
import 'package:spotmies/views/chat/chat_tab.dart';
import 'package:spotmies/views/posts/posts.dart';
import 'package:spotmies/views/profile/profile.dart';

void main() => runApp(GoogleNavBar());

class GoogleNavBar extends StatefulWidget {
  @override
  _GoogleNavBarState createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Home(),
    ),
    Center(
      child: Chat(),
    ),
    Center(
      child: PostList(),
    ),
    Center(
      child: Profile(),
    ),
  ];

  setBottomBarIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.amber,
          width: double.infinity,
          height: double.infinity,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              width: _width,
              height: _hight * 0.116,
              decoration: BoxDecoration(
                // color: Colors.grey[50],
                boxShadow: [
                BoxShadow(
                  
                    color: Colors.grey[100], blurRadius: 10, spreadRadius: 2)
              ]),
              child: Stack(
                // overflow: Overflow.visible,
                children: [
                  CustomPaint(
                    
                    size: Size(_width, _hight * 0.116),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.7,
                    child: FloatingActionButton(
                        heroTag: 'ad',
                        tooltip: 'Post Add',
                        backgroundColor: Colors.blue[900],
                        child: Icon(Icons.engineering),
                        elevation: 0.1,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostAd()));
                        }),
                  ),
                  Container(
                    width: _width,
                    height: _hight * 0.116,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? Colors.blue[900]
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                          },
                          splashColor: Colors.white,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.chat_bubble,
                              color: _selectedIndex == 1
                                  ? Colors.blue[900]
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                            }),
                        Container(
                          width: _width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.home_repair_service,
                              color: _selectedIndex == 2
                                  ? Colors.blue[900]
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(2);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.person,
                              color: _selectedIndex == 3
                                  ? Colors.blue[900]
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setBottomBarIndex(3);
                            }),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
