import 'package:flutter/material.dart';
import 'package:spotmies/views/call_ui/components/rounded_button.dart';

import '../constants.dart';
import '../size.config.dart';

class CallingUi extends StatefulWidget {
  CallingUi(
      {@required this.isInComingScreen,
      this.image = "",
      this.name = "unknown",
      this.onAccept,
      this.onHangUp,
      this.onMic,
      this.onReject,
      this.onSpeaker});
  final bool isInComingScreen;
  final String image;
  final String name;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onHangUp;
  final VoidCallback onMic;
  final VoidCallback onSpeaker;

  @override
  _CallingUiState createState() => _CallingUiState();
}

class _CallingUiState extends State<CallingUi> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Uri.parse(widget.image).isAbsolute //need to put url validator
              ? Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/full_image.png",
                  fit: BoxFit.cover,
                ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                  ),
                  VerticalSpacing(of: 10),
                  Text(
                    !widget.isInComingScreen
                        ? "Duration 12:00 ".toUpperCase()
                        : "INCOMING CALL.....",
                    style: TextStyle(color: Colors.white60),
                  ),
                  Spacer(),
                  Visibility(
                    visible: !widget.isInComingScreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                          press: () {
                            widget.onMic();
                          },
                          color: Colors.white,
                          iconColor: Colors.black,
                          iconSrc: "assets/icons/Icon Mic.svg",
                        ),
                        RoundedButton(
                          press: () {
                            widget.onHangUp();
                          },
                          color: kRedColor,
                          iconColor: Colors.white,
                          iconSrc: "assets/icons/call_end.svg",
                        ),
                        RoundedButton(
                          press: () {
                            widget.onSpeaker();
                          },
                          color: Colors.white,
                          iconColor: Colors.black,
                          iconSrc: "assets/icons/Icon Volume.svg",
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.isInComingScreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoundedButton(
                          press: () {
                            widget.onAccept();
                          },
                          color: Colors.green,
                          iconColor: Colors.white,
                          iconSrc: "assets/icons/call_accept.svg",
                        ),
                        RoundedButton(
                          press: () {
                            widget.onReject();
                          },
                          color: Colors.red,
                          iconColor: Colors.white,
                          iconSrc: "assets/icons/call_end.svg",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
