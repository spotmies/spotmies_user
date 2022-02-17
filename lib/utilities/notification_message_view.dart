import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/views/home/navBar.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class NotificationMessage extends StatefulWidget {
  final RemoteNotification? message;
  const NotificationMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  _NotificationMessageState createState() => _NotificationMessageState();
}

class _NotificationMessageState extends State<NotificationMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height(context) * 0.08,
            ),
            Container(
              child: TextWid(
                text: 'Hello!, You got message',
                size: width(context) * 0.07,
                weight: FontWeight.w600,
                flow: TextOverflow.visible,
              ),
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: height(context) * 0.6,
              width: width(context) * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 5,
                        spreadRadius: 5)
                  ]),
              child: Column(
                children: [
                  SizedBox(
                    height: height(context) * 0.04,
                  ),
                  TextWid(
                    text: widget.message!.title.toString(),
                    size: width(context) * 0.05,
                    weight: FontWeight.w600,
                    flow: TextOverflow.visible,
                  ),
                  Divider(
                    indent: width(context) * 0.1,
                    endIndent: width(context) * 0.1,
                    color: Colors.grey[300],
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: height(context) * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWid(
                      text: widget.message!.body.toString(),
                      size: width(context) * 0.05,
                      weight: FontWeight.w500,
                      flow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.1,
            ),
            ElevatedButtonWidget(
              buttonName: 'Home',
              height: height(context) * 0.047,
              minWidth: width(context) * 0.38,
              bgColor: Colors.white,
              textColor: Colors.grey[900]!,
              // allRadius: true,
              textSize: width(context) * 0.04,
              leadingIcon: Icon(
                Icons.arrow_back,
                color: Colors.grey[900],
                size: width(context) * 0.05,
              ),
              borderRadius: 15.0,
              borderSideColor: Colors.grey[900]!,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleNavBar(),
                  ),
                );
              },
            ),

            // Text(widget.message!.body.toString()),
          ],
        ),
      ),
    );
  }
}
