import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Widget page1(BuildContext context, AdController adController,
    UniversalProvider up, int? sid) {
  return Scaffold(
    backgroundColor: SpotmiesTheme.background,
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: height(context) * 0.05,
        ),
        width: width(context) * 1,
        child: Container(
          height: height(context) * 1,
          width: width(context),
          padding: EdgeInsets.only(top: height(context) * 0.03),
          child: Form(
            key: adController.formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: width(context) * 0.05,
                  ),
                  height: height(context) * 0.1,
                  width: width(context) * 0.8,
                  child: Center(
                    child: steps(1, width(context)),
                  ),
                ),
                Container(
                  height: height(context) * 0.7,
                  width: width(context) * 0.87,
                  child: ListView(
                    children: [
                      Container(
                          height: height(context) * 0.15,
                          child: SvgPicture.asset('assets/like.svg')),
                      SizedBox(
                        height: height(context) * 0.022,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: width(context) * 0.03,
                            right: width(context) * 0.00),
                        height: height(context) * 0.12,
                        width: width(context) * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Category:',
                              color: SpotmiesTheme.secondaryVariant,
                              size: width(context) * 0.05,
                              weight: FontWeight.w600,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: width(context) * 0.03,
                                    right: width(context) * 0.03),
                                decoration: BoxDecoration(
                                    color: SpotmiesTheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(15)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: adController.dropDownValue,
                                  hint: TextWid(
                                    text: 'Choose Category',
                                    color: SpotmiesTheme.secondaryVariant,
                                    size: width(context) * 0.04,
                                    weight: FontWeight.w500,
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    size: width(context) * 0.06,
                                    color: SpotmiesTheme.onBackground,
                                  ),
                                  items:
                                      up.getCategoryMainList().map((services) {
                                    log(adController.dropDownValue.toString());
                                    // if (sid != null) {
                                    //   adController.dropDownValue = sid;
                                    // }
                                    return DropdownMenuItem(
                                        child: TextWid(
                                          text: services['nameOfService'],
                                          color: SpotmiesTheme.secondaryVariant,
                                          size: width(context) * 0.04,
                                          weight: FontWeight.w500,
                                        ),
                                        value: services['serviceId']);
                                  }).toList(),
                                  onChanged: (newVal) {
                                    log(newVal.toString());
                                    adController.dropDownValue = newVal as int;
                                    adController.refresh();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: SpotmiesTheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(15)),
                        height: height(context) * 0.075,
                        width: width(context) * 0.8,
                        child: TextFormField(
                          style: fonts(
                              height(context) * 0.025,
                              FontWeight.normal,
                              SpotmiesTheme.secondaryVariant),
                          controller: adController.problem,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please discribe your problem';
                            } else if (value == null) {
                              return 'Please discribe your problem';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: SpotmiesTheme.surfaceVariant2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    width: 1,
                                    color: SpotmiesTheme.surfaceVariant)),
                            hintStyle: fonts(
                                width(context) * 0.05,
                                FontWeight.w400,
                                SpotmiesTheme.secondaryVariant),
                            hintText: 'Problem',
                            suffixIcon: Icon(
                              Icons.error_outline_rounded,
                              color: SpotmiesTheme.secondaryVariant,
                            ),
                            contentPadding: EdgeInsets.only(
                                left: height(context) * 0.03,
                                top: height(context) * 0.06),
                          ),
                          onChanged: (value) {
                            adController.title = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.025,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: width(context) * 0.03,
                              right: width(context) * 0.03,
                              top: width(context) * 0.02),
                          decoration: BoxDecoration(
                              color: SpotmiesTheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(15)),
                          // height: hight * 0.12,
                          width: width(context) * 0.8,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    text: 'Schedule:',
                                    color: SpotmiesTheme.secondaryVariant,
                                    size: width(context) * 0.03,
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  await adController.pickDate(context);
                                  adController.refresh();
                                  await adController.picktime(context);
                                  adController.datePickColor = 0;
                                  adController.refresh();
                                },
                                child: Container(
                                  height: height(context) * 0.1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: width(context) * 0.45,
                                          // color: Colors.amber[50],
                                          child: Row(
                                            children: [
                                              TextWid(
                                                text: DateFormat('dd').format((DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        (adController.pickedDate
                                                            .millisecondsSinceEpoch)))),
                                                size: width(context) * 0.12,
                                              ),
                                              SizedBox(
                                                width: width(context) * 0.02,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWid(
                                                    text: DateFormat('MMM')
                                                        .format((DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                (adController
                                                                    .pickedDate
                                                                    .millisecondsSinceEpoch)))),
                                                    weight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        width(context) * 0.01,
                                                  ),
                                                  TextWid(
                                                    text: DateFormat('EEEE')
                                                        .format((DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                (adController
                                                                    .pickedDate
                                                                    .millisecondsSinceEpoch)))),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: width(context) * 0.02,
                                              ),
                                              Icon(Icons.calendar_today,
                                                  color: SpotmiesTheme.equal,
                                                  size: width(context) * 0.06)
                                            ],
                                          )),
                                      SizedBox(
                                        width: width(context) * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          adController.pickedDate =
                                              await DateTime.now();
                                          adController.datePickColor = 1;
                                          adController.refresh();
                                        },
                                        child: Container(
                                          height: height(context) * 0.06,
                                          width: width(context) * 0.15,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: adController
                                                              .datePickColor ==
                                                          1
                                                      ? SpotmiesTheme.primary
                                                      : SpotmiesTheme.equal),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextWid(
                                                text: DateFormat('dd MMM')
                                                    .format((DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            (DateTime.now()
                                                                .millisecondsSinceEpoch)))),
                                                weight: FontWeight.w600,
                                                size: width(context) * 0.025,
                                              ),
                                              TextWid(
                                                text: 'Today',
                                                weight: FontWeight.w500,
                                                size: width(context) * 0.025,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width(context) * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          adController.pickedDate =
                                              await DateTime.now()
                                                  .add(Duration(days: 1));
                                          adController.datePickColor = 2;
                                          adController.refresh();
                                        },
                                        child: Container(
                                          height: height(context) * 0.06,
                                          width: width(context) * 0.15,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: adController
                                                              .datePickColor ==
                                                          2
                                                      ? SpotmiesTheme.primary
                                                      : SpotmiesTheme.equal),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextWid(
                                                text: DateFormat('dd MMM')
                                                    .format((DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            (DateTime.now()
                                                                .add(Duration(
                                                                    days: 1))
                                                                .millisecondsSinceEpoch)))),
                                                weight: FontWeight.w600,
                                                size: width(context) * 0.025,
                                              ),
                                              TextWid(
                                                text: 'Tomorrow',
                                                weight: FontWeight.w500,
                                                size: width(context) * 0.025,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      // TextWidget(
                                      //   text: 'Date:  ' +
                                      //       DateFormat('dd MMM yyyy').format(
                                      //           (DateTime
                                      //               .fromMillisecondsSinceEpoch(
                                      //                   (adController.pickedDate
                                      //                       .millisecondsSinceEpoch)))),
                                      //   color: SpotmiesTheme.secondaryVariant,
                                      //   size: width(context) * 0.04,
                                      //   weight: FontWeight.w500,
                                      // ),
                                      // TextWidget(
                                      //   text:
                                      //       'Time:${adController.pickedTime.format(context)}',
                                      //   color: SpotmiesTheme.secondaryVariant,
                                      //   size: width(context) * 0.04,
                                      //   weight: FontWeight.w500,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  height: height(context) * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButtonWidget(
                        onClick: () async {
                          await adController.step1(context);
                        },
                        buttonName: 'Next',
                        bgColor: SpotmiesTheme.primary,
                        borderSideColor: SpotmiesTheme.primary,
                        textColor: Colors.white,
                        height: height(context) * 0.05,
                        minWidth: width(context) * 0.60,
                        textSize: height(context) * 0.02,
                        trailingIcon: Icon(
                          Icons.arrow_forward_ios,
                          size: height(context) * 0.015,
                        ),
                        borderRadius: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}





//
// class Page1 extends StatefulWidget {
//   const Page1({Key? key}) : super(key: key);

//   @override
//   _Page1State createState() => _Page1State();
// }

// class _Page1State extends State<Page1> {
//   AdController? adController = AdController();
//   UniversalProvider? up;
//   @override
//   void initState() {
//     up = Provider.of<UniversalProvider>(context, listen: false);
//     up?.setCurrentConstants("serviceRequest");
//     // adController?.getAddressofLocation();
//     adController?.pickedDate = DateTime.now();
//     adController?.pickedTime = TimeOfDay.now();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: SpotmiesTheme.background,
//       body: SingleChildScrollView(
//         child: Container(
//           // color: Colors.amber,
//           height: height(context) * 1,
//           width: width(context),
//           padding: EdgeInsets.only(top: height(context) * 0.03),
//           child: Form(
//             key: adController?.formkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                     bottom: width(context) * 0.05,
//                   ),
//                   height: height(context) * 0.1,
//                   width: width(context) * 0.8,
//                   child: Center(
//                     child: steps(1, width(context)),
//                   ),
//                 ),
//                 Container(
//                   height: height(context) * 0.7,
//                   width: width(context) * 0.87,
//                   child: ListView(
//                     children: [
//                       Container(
//                           height: height(context) * 0.15,
//                           child: SvgPicture.asset('assets/like.svg')),
//                       SizedBox(
//                         height: height(context) * 0.022,
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: width(context) * 0.03,
//                             right: width(context) * 0.00),
//                         height: height(context) * 0.12,
//                         width: width(context) * 0.8,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             TextWidget(
//                               text: 'Category:',
//                               color: SpotmiesTheme.secondaryVariant,
//                               size: width(context) * 0.05,
//                               weight: FontWeight.w600,
//                             ),
//                             Flexible(
//                               child: Container(
//                                 padding: EdgeInsets.only(
//                                     left: width(context) * 0.03,
//                                     right: width(context) * 0.03),
//                                 decoration: BoxDecoration(
//                                     color: SpotmiesTheme.surfaceVariant,
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: DropdownButton(
//                                   underline: SizedBox(),
//                                   // value: adController?.dropDownValue,
//                                   hint: TextWid(
//                                     text: 'Choose Category',
//                                     color: SpotmiesTheme.secondaryVariant,
//                                     size: width(context) * 0.04,
//                                     weight: FontWeight.w500,
//                                   ),
//                                   icon: Icon(
//                                     Icons.arrow_drop_down_circle,
//                                     size: width(context) * 0.06,
//                                     color: SpotmiesTheme.onBackground,
//                                   ),
//                                   items: up?.servicesList.map((services) {
//                                     return DropdownMenuItem(
//                                       child: TextWid(
//                                         text: services['nameOfService'],
//                                         color: SpotmiesTheme.secondaryVariant,
//                                         size: width(context) * 0.04,
//                                         weight: FontWeight.w500,
//                                       ),
//                                       value: services['serviceId'],
//                                     );
//                                   }).toList(),
//                                   onChanged: (newVal) {
//                                     log(newVal.toString());
//                                     adController?.dropDownValue = newVal as int;
//                                     setState(() {});
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: SpotmiesTheme.surfaceVariant,
//                             borderRadius: BorderRadius.circular(15)),
//                         height: height(context) * 0.075,
//                         width: width(context) * 0.8,
//                         child: TextFormField(
//                           style: fonts(
//                               height(context) * 0.025,
//                               FontWeight.normal,
//                               SpotmiesTheme.secondaryVariant),
//                           controller: adController?.problem,
//                           validator: (value) {
//                             if (value != null && value.isEmpty) {
//                               return 'Please discribe your problem';
//                             } else if (value == null) {
//                               return 'Please discribe your problem';
//                             }
//                             return null;
//                           },
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(15)),
//                                 borderSide: BorderSide(
//                                     width: 1,
//                                     color: SpotmiesTheme.surfaceVariant2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(15)),
//                                 borderSide: BorderSide(
//                                     width: 1,
//                                     color: SpotmiesTheme.surfaceVariant)),
//                             hintStyle: fonts(
//                                 width(context) * 0.05,
//                                 FontWeight.w400,
//                                 SpotmiesTheme.secondaryVariant),
//                             hintText: 'Problem',
//                             suffixIcon: Icon(
//                               Icons.error_outline_rounded,
//                               color: SpotmiesTheme.secondaryVariant,
//                             ),
//                             contentPadding: EdgeInsets.only(
//                                 left: height(context) * 0.03,
//                                 top: height(context) * 0.06),
//                           ),
//                           onChanged: (value) {
//                             adController?.title = value;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: height(context) * 0.025,
//                       ),
//                       // Container(
//                       //   decoration: BoxDecoration(
//                       //       boxShadow: [
//                       //         BoxShadow(
//                       //             color: Colors.grey[300],
//                       //             blurRadius: 3,
//                       //             spreadRadius: 1)
//                       //       ],
//                       //       color: Colors.grey[50],
//                       //       borderRadius: BorderRadius.circular(15)),
//                       //   height: hight * 0.087,
//                       //   width: width * 0.8,
//                       //   child: TextFormField(
//                       //     keyboardType: TextInputType.number,
//                       //     inputFormatters: <TextInputFormatter>[
//                       //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                       //     ],
//                       //     // validator: (value) {
//                       //     //   if (value.isEmpty) {
//                       //     //     return 'Please assumed money';
//                       //     //   }
//                       //     //   return null;
//                       //     // },0
//                       //     decoration: InputDecoration(
//                       //       focusedBorder: OutlineInputBorder(
//                       //           borderRadius:
//                       //               BorderRadius.all(Radius.circular(15)),
//                       //           borderSide: BorderSide(
//                       //               width: 1, color: Colors.indigo[900])),
//                       //       enabledBorder: OutlineInputBorder(
//                       //           borderRadius:
//                       //               BorderRadius.all(Radius.circular(15)),
//                       //           borderSide: BorderSide(
//                       //               width: 1, color: Colors.grey[200])),
//                       //       hintStyle: fonts(width * 0.05, FontWeight.w400,
//                       //           Colors.grey[500]),
//                       //       hintText: 'Money',
//                       //       suffixIcon: Icon(
//                       //         Icons.account_balance_wallet,
//                       //         color: Colors.indigo[900],
//                       //       ),
//                       //       //border: InputBorder.none,
//                       //       contentPadding: EdgeInsets.only(
//                       //           left: hight * 0.03, top: hight * 0.06),
//                       //     ),
//                       //     onChanged: (value) {
//                       //       adController.money = value;
//                       //     },
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: hight * 0.022,
//                       // ),
//                       InkWell(
//                         onTap: () async {
//                           await adController?.pickDate(context);
//                           await adController?.picktime(context);
//                           setState(() {});
//                         },
//                         child: Container(
//                             padding: EdgeInsets.only(
//                                 left: width(context) * 0.03,
//                                 right: width(context) * 0.03,
//                                 top: width(context) * 0.03),
//                             decoration: BoxDecoration(
//                                 color: SpotmiesTheme.surfaceVariant,
//                                 borderRadius: BorderRadius.circular(15)),
//                             // height: hight * 0.12,
//                             width: width(context) * 0.8,
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     TextWidget(
//                                       text: 'Schedule:',
//                                       color: SpotmiesTheme.secondaryVariant,
//                                       size: width(context) * 0.05,
//                                       weight: FontWeight.w600,
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   height: height(context) * 0.07,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       TextWidget(
//                                         text: 'Date:  ' +
//                                             getDate((adController?.pickedDate
//                                                     .millisecondsSinceEpoch)
//                                                 .toString()),
//                                         // DateFormat('dd MMM yyyy').format(
//                                         //     (DateTime
//                                         //         .fromMillisecondsSinceEpoch(
//                                         //             (adController
//                                         //                 ?.pickedDate
//                                         //                 .millisecondsSinceEpoch)!))),
//                                         color: SpotmiesTheme.secondaryVariant,
//                                         size: width(context) * 0.04,
//                                         weight: FontWeight.w500,
//                                       ),
//                                       TextWidget(
//                                         text:
//                                             'Time:${adController?.pickedTime.format(context)}',
//                                         color: SpotmiesTheme.secondaryVariant,
//                                         size: width(context) * 0.04,
//                                         weight: FontWeight.w500,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: height(context) * 0.1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ElevatedButtonWidget(
//                         onClick: () async {
//                           log('message');
//                           await adController!.step1(context);
//                         },
//                         buttonName: 'Next',
//                         bgColor: SpotmiesTheme.primary,
//                         borderSideColor: SpotmiesTheme.primary,
//                         textColor: Colors.white,
//                         height: height(context) * 0.05,
//                         minWidth: width(context) * 0.60,
//                         textSize: height(context) * 0.02,
//                         trailingIcon: Icon(
//                           Icons.arrow_forward_ios,
//                           size: height(context) * 0.015,
//                         ),
//                         borderRadius: 10.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
