import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/utilities/snackbar.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/profile_pic.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetails extends StatefulWidget {
  final Map profileDetails;
  final bool isProfileRevealed;
  final Function onTapPhone;
  final Function revealMyProfile;
  final isMyProfileRevealed;
  PartnerDetails(
      {@required this.profileDetails,
      this.isProfileRevealed = true,
      this.onTapPhone,
      this.revealMyProfile,
      this.isMyProfileRevealed = false});
  @override
  _PartnerDetailsState createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  bool isSwitch;
  @override
  void initState() {
    log("details ${widget.profileDetails} ");
    setState(() {
      isSwitch = widget.isMyProfileRevealed;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        // backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: Text('Customer Details'),
        //   backgroundColor: Colors.blue[900],
        // ),
        body: CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
          expandedHeight: _hight * 0.4,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            // titlePadding: EdgeInsets.only(left: _width*0.15,bottom: _width*0.04),
            title: TextWid(
              text: toBeginningOfSentenceCase(widget.profileDetails['name']),
              size: _width * 0.06,
              color: Colors.grey[900],
              weight: FontWeight.w600,
            ),
            centerTitle: false,
            background: Container(
              width: _width * 1,
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
                        textSize: _width * 0.25,
                        size: _width * 0.25,
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
                // height: _hight * 0.27,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            left: _width * 0.03,
                            top: _width * 0.03,
                            bottom: _width * 0.03),
                        alignment: Alignment.bottomLeft,
                        child: TextWid(
                          text: 'About and phone number',
                          size: _width * 0.055,
                          weight: FontWeight.w600,
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(
                          left: _width * 0.03,
                          top: _width * 0.03,
                        ),
                        child: TextWid(
                          text: 'Spotmies Using From',
                          size: _width * 0.05,
                          color: Colors.grey[700],
                          weight: FontWeight.w600,
                        )),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(
                          left: _width * 0.03,
                          top: _width * 0.01,
                        ),
                        child: TextWid(
                          text:
                              getDate(widget.profileDetails['join'].toString()),
                          size: _width * 0.035,
                          color: Colors.grey[700],
                          weight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: _hight * 0.01,
                    ),
                    Divider(
                      indent: _width * 0.04,
                      endIndent: _width * 0.04,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                      height: _hight * 0.10,
                      padding: EdgeInsets.only(left: _width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWid(
                            text: 'Contact',
                            size: _width * 0.05,
                            color: Colors.grey[700],
                            weight: FontWeight.w600,
                            align: TextAlign.start,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: _width * 0.45,
                                  padding: EdgeInsets.only(
                                    left: _width * 0.03,
                                    top: _width * 0.01,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          child: TextWid(
                                            text: widget.isProfileRevealed
                                                ? widget.profileDetails['phNum']
                                                    .toString()
                                                : widget.profileDetails['phNum']
                                                        .toString()
                                                        .substring(0, 5) +
                                                    "*****",
                                            size: _width * 0.04,
                                            color: Colors.grey[800],
                                            weight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: _width * 0.45,
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
                  left: _width * 0.07,
                ),
                height: _hight * 0.1,
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
                          width: _width * 0.07,
                        ),
                        TextWid(
                          text: 'Reveal My Profile',
                          size: _width * 0.05,
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
                            widget.revealMyProfile(value);
                            setState(() {
                              isSwitch = value;
                            });
                          }),
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
                  left: _width * 0.07,
                ),
                height: _hight * 0.1,
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.grey[900],
                    ),
                    SizedBox(
                      width: _width * 0.07,
                    ),
                    TextWid(
                      text: 'Available to Recieve Calls',
                      size: _width * 0.05,
                      color: Colors.grey[800],
                      weight: FontWeight.w600,
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
                  left: _width * 0.07,
                ),
                height: _hight * 0.1,
                child: Row(
                  children: [
                    Icon(
                      Icons.block,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: _width * 0.07,
                    ),
                    TextWid(
                      text: 'Block ' +
                          toBeginningOfSentenceCase(
                              widget.profileDetails['name']),
                      size: _width * 0.05,
                      color: Colors.redAccent,
                      weight: FontWeight.w600,
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
                  left: _width * 0.07,
                ),
                height: _hight * 0.1,
                child: Row(
                  children: [
                    Icon(
                      Icons.report_problem,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: _width * 0.07,
                    ),
                    TextWid(
                      text: 'Report on ' +
                          toBeginningOfSentenceCase(
                              widget.profileDetails['name']),
                      size: _width * 0.05,
                      color: Colors.redAccent,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 10,
                color: Colors.grey[200],
              ),
              Container(
                height: 250.0,
                child: Center(
                    child: Container(
                        height: _hight * 0.15,
                        child: SvgPicture.asset('assets/like.svg'))),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
