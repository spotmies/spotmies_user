import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Help & Support'),
          backgroundColor: Colors.blue[900],
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      height: _hight * 0.3,
                      width: _width * 1,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              size: 37,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Make Call',
                              style: TextStyle(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 3,
                              spreadRadius: 4,
                              offset: Offset(1, 1),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade50,
                              blurRadius: 3,
                              spreadRadius: 0.1,
                              offset: Offset(-1, -1),
                            )
                          ])),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      height: _hight * 0.3,
                      width: _width * 1,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.email,
                              size: 37,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Send Email',
                              style: TextStyle(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 3,
                              spreadRadius: 4,
                              offset: Offset(1, 1),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade50,
                              blurRadius: 3,
                              spreadRadius: 0.1,
                              offset: Offset(-1, -1),
                            )
                          ])),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      height: _hight * 0.3,
                      width: _width * 1,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call_received,
                              size: 37,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Request To Call',
                              style: TextStyle(fontSize: 35),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 3,
                              spreadRadius: 4,
                              offset: Offset(1, 1),
                            ),
                            BoxShadow(
                              color: Colors.grey.shade50,
                              blurRadius: 3,
                              spreadRadius: 0.1,
                              offset: Offset(-1, -1),
                            )
                          ])),
                ),
              ],
            )));
  }
}
