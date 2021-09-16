import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:spotmies/controllers/posts_controllers/postOvervire_controller.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/profile/profile_shimmer.dart';
import 'package:spotmies/views/reusable_widgets/bottom_options_menu.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';

class PostOverView extends StatefulWidget {
  final int index;
  PostOverView({this.index});
  @override
  _PostOverViewState createState() => _PostOverViewState();
}

class _PostOverViewState extends StateMVC<PostOverView> {
  PostOverViewController _postOverViewController;
  _PostOverViewState() : super(PostOverViewController()) {
    this._postOverViewController = controller;
  }
  int ordId;
  GetOrdersProvider ordersProvider;
  // _PostOverViewState(this.value);
  // int _currentStep = 0;

  @override
  void initState() {
    ordersProvider = Provider.of<GetOrdersProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Consumer<GetOrdersProvider>(builder: (context, data, child) {
      var d = data.getOrdersList[widget.index];
      if (data.getOrdersList == null)
        return Center(child: profileShimmer(context));

      List<String> images = List.from(d['media']);
      final coordinates = Coordinates(d['loc'][0], d['loc'][1]);

      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: _hight * 0.16,
          // elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[900],
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: _postOverViewController.jobs
                    .elementAt(d['job'])
                    .toString()
                    .toUpperCase(),
                size: _width * 0.04,
                color: Colors.grey[500],
                lSpace: 1.5,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: _hight * 0.007,
              ),
              Row(
                children: [
                  Icon(
                    _postOverViewController.orderStateIcon(d['ordState']),
                    color: Colors.indigo[900],
                    size: _width * 0.045,
                  ),
                  SizedBox(
                    width: _width * 0.01,
                  ),
                  TextWidget(
                      text:
                          _postOverViewController.orderStateText(d['ordState']),
                      color: Colors.grey[700],
                      weight: FontWeight.w700,
                      size: _width * 0.04),
                ],
              )
            ],
          ),
          bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.only(bottom: _width * 0.01),
                height: _hight * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      height: _hight * 0.05,
                      minWidth: _width * 0.4,
                      bgColor: Colors.white,
                      borderSideColor: Colors.grey[200],
                      borderRadius: 10.0,
                      buttonName: 'Cancel',
                      textSize: _width * 0.04,
                      leadingIcon: Icon(
                        Icons.cancel,
                        color: Colors.grey[900],
                        size: _width * 0.045,
                      ),
                    ),
                    ElevatedButtonWidget(
                      height: _hight * 0.05,
                      minWidth: _width * 0.55,
                      bgColor: Colors.indigo[900],
                      borderSideColor: Colors.grey[200],
                      borderRadius: 10.0,
                      buttonName: 'Re-schedule',
                      textColor: Colors.white,
                      textSize: _width * 0.04,
                      trailingIcon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: _width * 0.045,
                      ),
                    )
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(4.0)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.help,
                  color: Colors.grey[700],
                )),
            IconButton(
                onPressed: () {
                  bottomOptionsMenu(context,options: _postOverViewController.options);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey[900],
                )),
          ],
        ),
        body: Container(
          height: _hight,
          width: _width,
          color: Colors.grey[100],
          child: ListView(
            children: [
              Divider(
                color: Colors.white,
              ),
              (d['ordState'] == 'onGoing')
                  ? TextWidget(
                      text: 'Service was started on ' +
                          getDate(d['schedule']) +
                          "-" +
                          getTime(d['schedule']),
                      align: TextAlign.center,
                    )
                  : (d['ordState'] == 'completed')
                      ? TextWidget(
                          text: 'Service was completed on ' +
                              getDate(d['schedule']) +
                              "-" +
                              getTime(d['schedule']),
                          align: TextAlign.center,
                        )
                      : TextWidget(
                          text: 'Service will start soon',
                          align: TextAlign.center,
                        ),
              Divider(
                color: Colors.white,
              ),
              Container(
                height: _hight * 0.45,
                width: _width,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'Service Details :',
                            size: _width * 0.055,
                            weight: FontWeight.w600,
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: Icon(Icons.edit))
                        ],
                      ),
                    ),
                    serviceDetailsListTile(
                      _width,
                      _hight,
                      'Issue/Problem',
                      Icons.settings,
                      d['problem'],
                    ),
                    serviceDetailsListTile(
                      _width,
                      _hight,
                      'Schedule',
                      Icons.schedule,
                      getDate(d['schedule']) + "-" + getTime(d['schedule']),
                    ),
                    serviceDetailsListTile(
                        _width,
                        _hight,
                        'Location',
                        Icons.location_on,
                        '10-134, NH16, Pothinamallayya Palem, Visakhapatnam, Andhra Pradesh 530041'),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              images.isNotEmpty
                  ? mediaView(_hight, _width, images)
                  : TextWidget(
                      text: 'No media files found',
                      align: TextAlign.center,
                    ),
              Divider(
                color: Colors.white,
              ),
              warrentyCard(_hight, _width),
              Divider(
                color: Colors.white,
              ),
              (d['ordState'] == 'onGoing' || d['ordState'] == 'completed')
                  ? Container(
                      height: _hight * 0.3,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: 'Technician Details :',
                                  size: _width * 0.055,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                          partnerDetails(
                              _hight, _width, context, _postOverViewController)
                        ],
                      ))
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  serviceDetailsListTile(
    width,
    hight,
    title,
    icon,
    subtitle,
  ) {
    return ListTile(
        tileColor: Colors.redAccent,
        leading: Icon(
          icon,
          size: width * 0.045,
        ),
        title: TextWidget(
          text: title,
          size: width * 0.045,
          weight: FontWeight.w600,
          color: Colors.grey[900],
          lSpace: 1.5,
        ),
        subtitle: TextWidget(
          text: subtitle,
          size: width * 0.04,
          flow: TextOverflow.visible,
          weight: FontWeight.w600,
          color: Colors.grey[600],
          lSpace: 1,
        ),
        trailing: Container(
          width: width * 0.07,
        ));
  }

  mediaView(hight, width, images) {
    return Container(
      height: hight * 0.22,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Media Files :',
                  size: width * 0.055,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Container(
            height: hight * 0.11,
            child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Container(
                        child: images[index].contains('jpg')
                            ? InkWell(
                                onTap: () {
                                  imageslider(images, hight, width);
                                },
                                child: Container(
                                  width: width * 0.11,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(images[index]))),
                                ),
                              )
                            : images[index].contains('mp4')
                                ? TextWidget(
                                    text: 'Video',
                                  )
                                : TextWidget(text: 'Audio'),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  warrentyCard(hight, width) {
    return Container(
      height: hight * 0.2,
      width: width,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.indigo[900],
          border: Border.all(color: Colors.indigo[900]),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            // alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 15, left: 20, right: 10),
            width: width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Warranty Card',
                  color: Colors.white,
                  size: width * 0.05,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: hight * 0.02,
                ),
                TextWidget(
                  text: 'VALID TILL',
                  color: Colors.indigo[200],
                  size: width * 0.035,
                  weight: FontWeight.w600,
                ),
                TextWidget(
                  text: '09 Oct,2021',
                  color: Colors.white,
                  size: width * 0.04,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: hight * 0.045,
                ),
                TextWidget(
                  text: 'Claim Warranty >>',
                  color: Colors.white,
                  size: width * 0.045,
                  weight: FontWeight.w600,
                )
              ],
            ),
          ),
          Container(
            width: width * 0.3,
            child: SvgPicture.asset('assets/like.svg'),
          )
        ],
      ),
    );
  }

  rating() {
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Icon(
              Icons.rate_review,
              size: 100,
              color: Colors.blue[800],
            ),
            // const FlutterLogo(
            //   size: 100,
            // ), // set your own image/icon widget
            title: "Rate Your Technician!",
            description: "Express Your Experience By Tapping \nOn Stars",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear :)", // optional
            negativeComment: "We're sad to hear :(", // optional
            accentColor: Colors.blue[800], // optional
            onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
            },
          );
        });
  }

  imageslider(List<String> images, double hight, double width) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            actions: [
              Container(
                  height: hight * 0.35,
                  width: width * 1,
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (ctx, index, realIdx) {
                      return Container(
                          child: Image.network(images[index]
                              .substring(0, images[index].length - 1)));
                    },
                    options: CarouselOptions(
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlay: false,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                    ),
                  ))
            ],
          );
        });
  }
}

partnerDetails(hight, width, BuildContext context, controller) {
  return Container(
    height: hight * 0.24,
    child: Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: hight * 0.06,
                  child: ClipOval(
                    child: Image.network(
                        'https://pbs.twimg.com/profile_images/1428936441359323142/rdszNzrj_400x400.jpg',
                        width: width * 0.4,
                        height: width * 0.4,
                        fit: BoxFit.fitHeight),
                  ),
                ),
                SizedBox(
                  width: width * 0.07,
                ),
                Container(
                  height: hight * 0.11,
                  width: width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: toBeginningOfSentenceCase(
                                  'saride Satish Kumar',
                                ),
                                size: width * 0.04,
                                weight: FontWeight.w600,
                                color: Colors.grey[900],
                              )
                            ],
                          ),
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: controller.jobs.elementAt(4) + ' | ',
                                  size: width * 0.025,
                                  weight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                                TextWidget(
                                  // text: pDetails['rate'][0].toString(),
                                  text: '4.5',
                                  size: width * 0.025,
                                  weight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: width * 0.025,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Telugu | ',
                              style: fonts(width * 0.03, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                            Text(
                              'English | ',
                              style: fonts(width * 0.03, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                            Text(
                              'Hindi',
                              style: fonts(width * 0.03, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.45,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: width * 0.03,
                            ),
                            Text(
                              'Vizag',
                              style: fonts(width * 0.03, FontWeight.w600,
                                  Colors.grey[900]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        SizedBox(
          height: hight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => MyCalling(
                //           ordId: responseData['ordId'].toString(),
                //           uId: FirebaseAuth.instance.currentUser.uid
                //               .toString(),
                //           pId: responseData['pId'].toString(),
                //           isIncoming: false,
                //           name: pDetails['name'].toString(),
                //           profile: pDetails['partnerPic'].toString(),
                //         )));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.call,
                      color: Colors.grey[900],
                      size: width * 0.05,
                    ),
                  ),
                  SizedBox(
                    height: hight * 0.01,
                  ),
                  TextWidget(
                    text: 'Call',
                    size: width * 0.04,
                    weight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //  chatWithPatner(responseData);
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.06,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.chat_bubble,
                      color: Colors.grey[900],
                      size: width * 0.05,
                    ),
                  ),
                  SizedBox(
                    height: hight * 0.01,
                  ),
                  TextWidget(
                    text: 'Message',
                    size: width * 0.04,
                    weight: FontWeight.w600,
                    color: Colors.grey[900],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}







// CustomScrollView(
        //   physics: const BouncingScrollPhysics(
        //       parent: AlwaysScrollableScrollPhysics()),
        //   slivers: [
        //     SliverAppBar(
        //         backgroundColor: Colors.blue[900],
        //         stretch: true,
        //         pinned: true,
        //         snap: false,
        //         floating: true,
        //         expandedHeight: _hight * 0.5,
        //         flexibleSpace: FlexibleSpaceBar(
        //             stretchModes: <StretchMode>[
        //               StretchMode.zoomBackground,
        //               StretchMode.fadeTitle,
        //             ],
        //             title: Text(
        //               _postOverViewController.jobs.elementAt(d['job']),
        //             ),
        //             background: Container(
        //               width: _width * 1,
        //               color: Colors.black,
        //               child: GestureDetector(
        //                   onTap: () {
        //                     imageslider(images, _hight, _width);
        //                   },
        //                   child: (images.isEmpty)
        //                       ? Icon(
        //                           Icons.tungsten_rounded,
        //                           color: Colors.amber,
        //                           size: _width * 0.5,
        //                         )
        //                       : Image.network(
        //                           images.first,
        //                           fit: BoxFit.cover,
        //                         )),
        //             ))),
        //     SliverList(
        //         delegate: SliverChildListDelegate([
        //       Container(
        //         padding:
        //             EdgeInsets.only(left: _width * 0.08, top: _width * 0.03),
        //         height: _hight * 0.07,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text('Orderid:',
        //                 style: TextStyle(
        //                     color: Colors.grey[700],
        //                     fontWeight: FontWeight.bold)),
        //             Text(d['ordId'].toString()),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 4,
        //         color: Colors.grey[200],
        //       ),
        //       Container(
        //         padding: EdgeInsets.only(right: 5, left: 5),
        //         height: _hight * 0.032,
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5)),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Icon(
        //               _postOverViewController.orderStateIcon(d['ordState']),
        //               color: Colors.indigo[900],
        //               size: _width * 0.04,
        //             ),
        //             SizedBox(
        //               width: _width * 0.01,
        //             ),
        //             TextWidget(
        //                 text: _postOverViewController
        //                     .orderStateText(d['ordState']),
        //                 color: Colors.indigo[900],
        //                 weight: FontWeight.w600,
        //                 size: _width * 0.03)
        //           ],
        //         ),
        //       ),
        //       Container(
        //         padding:
        //             EdgeInsets.only(left: _width * 0.09, right: _width * 0.02),
        //         height: _hight * 0.1,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               width: _width * 0.7,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('Problem:',
        //                       style: TextStyle(
        //                           color: Colors.grey[700],
        //                           fontWeight: FontWeight.bold)),
        //                   Flexible(
        //                     child: Text(
        //                       d['problem'],
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(color: Colors.grey[800]),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             _postOverViewController.editAttributes(
        //                 'problem',
        //                 ordId.toString(),
        //                 d['job'],
        //                 d['money'],
        //                 d['schedule'],
        //                 coordinates),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 4,
        //         color: Colors.grey[200],
        //       ),
        //       Container(
        //         padding:
        //             EdgeInsets.only(left: _width * 0.09, right: _width * 0.02),
        //         height: _hight * 0.1,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text('Amount quoted:',
        //                     style: TextStyle(
        //                         color: Colors.grey[700],
        //                         fontWeight: FontWeight.bold)),
        //                 Text('₹' + d['money'].toString(),
        //                     style: TextStyle(
        //                       color: Colors.grey[700],
        //                     )),
        //                 // Text(d['ordId']),
        //               ],
        //             ),
        //             _postOverViewController.editAttributes(
        //                 'amount',
        //                 ordId.toString(),
        //                 d['job'],
        //                 d['money'],
        //                 d['schedule'],
        //                 coordinates),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 4,
        //         color: Colors.grey[200],
        //       ),
        //       Container(
        //         padding:
        //             EdgeInsets.only(left: _width * 0.09, right: _width * 0.02),
        //         height: _hight * 0.1,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text('Schedule:',
        //                     style: TextStyle(
        //                         color: Colors.grey[700],
        //                         fontWeight: FontWeight.bold)),
        //                 Text(
        //                     DateFormat('dd/MM/yyyy').format(
        //                         DateTime.fromMillisecondsSinceEpoch(
        //                             d['schedule'])),
        //                     style: TextStyle(
        //                       color: Colors.grey[700],
        //                     ))
        //               ],
        //             ),
        //             _postOverViewController.editAttributes(
        //                 'Schedule',
        //                 ordId.toString(),
        //                 d['job'],
        //                 d['money'],
        //                 d['schedule'],
        //                 coordinates),
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 4,
        //         color: Colors.grey[200],
        //       ),
        //       Container(
        //         padding:
        //             EdgeInsets.only(left: _width * 0.09, right: _width * 0.02),
        //         height: _hight * 0.1,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text('Service location:',
        //                     style: TextStyle(
        //                         color: Colors.grey[700],
        //                         fontWeight: FontWeight.bold)),
        //                 Text(
        //                     d['loc'][0].toString() +
        //                         ',' +
        //                         d['loc'][1].toString(),
        //                     style: TextStyle(
        //                       color: Colors.grey[700],
        //                     ))
        //               ],
        //             ),
        //             _postOverViewController.editAttributes(
        //                 'location',
        //                 ordId.toString(),
        //                 d['job'],
        //                 d['money'],
        //                 d['schedule'],
        //                 coordinates),
        //           ],
        //         ),
        //       ),
        //       d['ordstate'] == 'req'
        //           ? Container(
        //               color: Colors.blue[900],
        //               child: IconButton(
        //                   onPressed: () {
        //                     rating();
        //                   },
        //                   icon: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         'Rate',
        //                         style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: _width * 0.05),
        //                       ),
        //                       Icon(
        //                         Icons.star,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   )),
        //             )
        //           : Container(
        //               color: Colors.blue[900],
        //               child: IconButton(
        //                   icon: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         'Complete',
        //                         style: TextStyle(color: Colors.white),
        //                       ),
        //                       Icon(
        //                         Icons.done,
        //                         color: Colors.white,
        //                       ),
        //                     ],
        //                   ),
        //                   onPressed: () {}),
        //             ),
        //     ])),
        //   ],
        // );
