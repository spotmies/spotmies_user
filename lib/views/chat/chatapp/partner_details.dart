import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/chat_controllers/chat_controller.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PartnerDetails extends StatefulWidget {
  final Map profileDetails;
  final bool isProfileRevealed;
  final Function onTapPhone;
  final Function revealMyProfile;
  final bool isMyProfileRevealed;
  final String msgId;
  final Map chatDetails;
  PartnerDetails(
      {@required this.profileDetails,
      this.isProfileRevealed = true,
      this.onTapPhone,
      this.revealMyProfile,
      this.isMyProfileRevealed = false,
      this.msgId,
      this.chatDetails});
  @override
  _PartnerDetailsState createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends StateMVC<PartnerDetails> {
  ChatController _chatController;
  UniversalProvider up;
  _PartnerDetailsState() : super(ChatController()) {
    this._chatController = controller;
  }
  bool isSwitch;
  @override
  void initState() {
    up = Provider.of<UniversalProvider>(context, listen: false);
    up.setCurrentConstants("chatScreen");
    log("details ${widget.profileDetails} ");
    setState(() {
      isSwitch = widget.isMyProfileRevealed;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _chatController.scaffoldkey,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.grey[100],
              stretch: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[900],
                  )),
              onStretchTrigger: () {
                return Future<void>.value();
              },
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: height(context) * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                // titlePadding: EdgeInsets.only(left: width(context)*0.15,bottom: width(context)*0.04),
                title: TextWid(
                  text:
                      toBeginningOfSentenceCase(widget.profileDetails['name']),
                  size: width(context) * 0.06,
                  color: Colors.grey[900],
                  weight: FontWeight.w600,
                ),
                centerTitle: false,
                background: Container(
                  width: width(context) * 1,
                  color: Colors.white,
                  child: !Uri.parse(
                              widget.profileDetails['partnerPic'].runtimeType ==
                                      String
                                  ? widget.profileDetails['partnerPic']
                                  : "s")
                          .isAbsolute
                      ? Center(
                          child: ProfilePic(
                            name: widget.profileDetails['name'],
                            profile: widget.profileDetails['partnerPic'],
                            status: false,
                            bgColor: Colors.grey[100],
                            textColor: Colors.grey[900],
                            textSize: width(context) * 0.25,
                            size: width(context) * 0.25,
                            badge: false,
                          ),
                        )
                      : Image.network(
                          widget.profileDetails['partnerPic'],
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Divider(
                    thickness: 5,
                    color: Colors.white,
                  ),
                  Container(
                    // height: height(context) * 0.27,
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: width(context) * 0.03,
                                top: width(context) * 0.03,
                                bottom: width(context) * 0.03),
                            alignment: Alignment.bottomLeft,
                            child: TextWid(
                              text: 'About and phone number',
                              size: width(context) * 0.055,
                              weight: FontWeight.w600,
                            )),
                        Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                              left: width(context) * 0.03,
                              top: width(context) * 0.03,
                            ),
                            child: TextWid(
                              text: 'Spotmies Using From',
                              size: width(context) * 0.05,
                              color: Colors.grey[700],
                              weight: FontWeight.w600,
                            )),
                        Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                              left: width(context) * 0.03,
                              top: width(context) * 0.01,
                            ),
                            child: TextWid(
                              text: getDate(
                                  widget.profileDetails['join'].toString()),
                              size: width(context) * 0.035,
                              color: Colors.grey[700],
                              weight: FontWeight.w600,
                            )),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        Divider(
                          indent: width(context) * 0.04,
                          endIndent: width(context) * 0.04,
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                        Container(
                          // height: height(context) * 0.10,
                          padding: EdgeInsets.only(left: width(context) * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWid(
                                text: 'Contact',
                                size: width(context) * 0.05,
                                color: Colors.grey[700],
                                weight: FontWeight.w600,
                                align: TextAlign.start,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: width(context) * 0.45,
                                      padding: EdgeInsets.only(
                                        left: width(context) * 0.03,
                                        top: width(context) * 0.01,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              child: TextWid(
                                                text: widget.isProfileRevealed
                                                    ? widget
                                                        .profileDetails['phNum']
                                                        .toString()
                                                    : widget.profileDetails[
                                                                'phNum']
                                                            .toString()
                                                            .substring(0, 5) +
                                                        "*****",
                                                size: width(context) * 0.04,
                                                color: Colors.grey[800],
                                                weight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width(context) * 0.45,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.message,
                                                color: Colors.indigo[900],
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                          IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                color: Colors.indigo[900],
                                              ),
                                              onPressed: () {
                                                // launch("tel://$num");
                                                if (widget.onTapPhone != null) {
                                                  widget.onTapPhone();
                                                } else {
                                                  snackbar(context,
                                                      "something went wrong");
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 10,
                    color: Colors.grey[200],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: width(context) * 0.07,
                    ),
                    height: height(context) * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: width(context) * 0.07,
                            ),
                            TextWid(
                              text: 'Reveal My Profile',
                              size: width(context) * 0.05,
                              color: Colors.grey[800],
                              weight: FontWeight.w600,
                            )
                          ],
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              trackColor: Colors.grey[300],
                              value: isSwitch,
                              activeColor: Colors.blue[900],
                              onChanged: (value) {
                                // widget.revealMyProfile(value);
                                _chatController.sendMessageHandler(
                                    widget.msgId,
                                    value
                                        ? "user shared the profile"
                                        : "user disabled their profile",
                                    chatDetails: widget.chatDetails,
                                    sender: "bot",
                                    action: value
                                        ? "enableProfile"
                                        : "disableProfile");
                                _chatController.revealProfile(
                                    widget.chatDetails,
                                    revealProfile: value);
                                setState(() {
                                  isSwitch = value;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  actionButton(
                    width(context),
                    height(context),
                    "Available to Recieve Calls",
                    Colors.grey[900],
                    Icons.call,
                  ),
                  actionButton(
                      width(context),
                      height(context),
                      "Block ${toBeginningOfSentenceCase(widget.profileDetails['name'])}",
                      Colors.redAccent,
                      Icons.block, onTap: () {
                    log("block");
                    _chatController.sendMessageHandler(
                        widget.msgId, "User blocked this chat",
                        sender: "bot",
                        chatDetails: widget.chatDetails,
                        action: "blockChat");

                    _chatController.deleteOrBlockThisChat(widget.msgId);
                  }),
                  actionButton(width(context), height(context), "Delete Chat",
                      Colors.redAccent, Icons.delete_sweep_rounded, onTap: () {
                    log("delete");
                    _chatController.sendMessageHandler(
                        widget.msgId, "User deleted this chat",
                        sender: "bot",
                        chatDetails: widget.chatDetails,
                        action: "deleteChat");

                    _chatController.deleteOrBlockThisChat(widget.msgId,
                        isChatDelete: true);
                  }),
                  actionButton(
                      width(context),
                      height(context),
                      'Report on ' +
                          toBeginningOfSentenceCase(
                                  widget.profileDetails['name'])
                              .toString(),
                      Colors.redAccent,
                      Icons.report_problem, onTap: () {
                    log("report");
                  }),
                  Divider(
                    thickness: 10,
                    color: Colors.grey[200],
                  ),
                  Container(
                    height: 250.0,
                    child: Center(
                        child: Container(
                            height: height(context) * 0.15,
                            child: SvgPicture.asset('assets/like.svg'))),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Column actionButton(
      double width, double height, String text, Color color, IconData icon,
      {Callback onTap}) {
    Divider divider = Divider(
      thickness: 10,
      color: Colors.grey[200],
    );
    return Column(
      children: [
        divider,
        Container(
          padding: EdgeInsets.only(left: width * 0.07),
          height: height * 0.1,
          child: InkWell(
            onTap: () {
              if (onTap != null) onTap();
            },
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                SizedBox(
                  width: width * 0.07,
                ),
                TextWid(
                  text: text,
                  // text: 'Block ' +
                  //     toBeginningOfSentenceCase(widget.profileDetails['name']),
                  size: width * 0.05,
                  color: color,
                  weight: FontWeight.w600,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
