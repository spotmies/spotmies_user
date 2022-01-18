import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:spotmies/controllers/home_controllers/ad_controll.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/elevatedButtonWidget.dart';
import 'package:spotmies/utilities/textWidget.dart';
import 'package:spotmies/views/reusable_widgets/steps.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Widget page1(double hight, double width, BuildContext context,
    AdController adController, UniversalProvider up) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: hight * 0.05,
        ),
        width: width * 1,
        child: Container(
          height: hight * 1,
          width: width,
          padding: EdgeInsets.only(top: hight * 0.03),
          child: Form(
            key: adController.formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: width * 0.05,
                  ),
                  height: hight * 0.1,
                  width: width * 0.8,
                  child: Center(
                    child: steps(1, width),
                  ),
                ),
                Container(
                  height: hight * 0.7,
                  width: width * 0.87,
                  child: ListView(
                    children: [
                      Container(
                          height: hight * 0.15,
                          child: SvgPicture.asset('assets/like.svg')),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.00),
                        height: hight * 0.12,
                        width: width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Category:',
                              color: Colors.grey[900],
                              size: width * 0.05,
                              weight: FontWeight.w600,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: width * 0.03, right: width * 0.03),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 3,
                                          spreadRadius: 1)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: adController.dropDownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    size: width * 0.06,
                                    color: Colors.indigo[900],
                                  ),
                                  items: up.servicesList.map((services) {
                                    return DropdownMenuItem(
                                      child: TextWid(
                                        text: services['nameOfService'],
                                        color: Colors.grey[900],
                                        size: width * 0.04,
                                        weight: FontWeight.w500,
                                      ),
                                      value: services['serviceId'],
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    log(newVal.toString());
                                    adController.dropDownValue = newVal;
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 3,
                                  spreadRadius: 1)
                            ],
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15)),
                        height: hight * 0.087,
                        width: width * 0.8,
                        child: TextFormField(
                          controller: adController.problem,
                          validator: (value) {
                            if (value.isEmpty) {
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
                                    width: 1, color: Colors.indigo[50])),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey[200])),
                            hintStyle: fonts(width * 0.05, FontWeight.w400,
                                Colors.grey[500]),
                            hintText: 'Problem',
                            suffixIcon: Icon(
                              Icons.error_outline_rounded,
                              color: Colors.indigo[900],
                            ),
                            contentPadding: EdgeInsets.only(
                                left: hight * 0.03, top: hight * 0.06),
                          ),
                          onChanged: (value) {
                            adController.title = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Colors.grey[300],
                      //             blurRadius: 3,
                      //             spreadRadius: 1)
                      //       ],
                      //       color: Colors.grey[50],
                      //       borderRadius: BorderRadius.circular(15)),
                      //   height: hight * 0.087,
                      //   width: width * 0.8,
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.number,
                      //     inputFormatters: <TextInputFormatter>[
                      //       FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      //     ],
                      //     // validator: (value) {
                      //     //   if (value.isEmpty) {
                      //     //     return 'Please assumed money';
                      //     //   }
                      //     //   return null;
                      //     // },0
                      //     decoration: InputDecoration(
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(15)),
                      //           borderSide: BorderSide(
                      //               width: 1, color: Colors.indigo[900])),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(15)),
                      //           borderSide: BorderSide(
                      //               width: 1, color: Colors.grey[200])),
                      //       hintStyle: fonts(width * 0.05, FontWeight.w400,
                      //           Colors.grey[500]),
                      //       hintText: 'Money',
                      //       suffixIcon: Icon(
                      //         Icons.account_balance_wallet,
                      //         color: Colors.indigo[900],
                      //       ),
                      //       //border: InputBorder.none,
                      //       contentPadding: EdgeInsets.only(
                      //           left: hight * 0.03, top: hight * 0.06),
                      //     ),
                      //     onChanged: (value) {
                      //       adController.money = value;
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: hight * 0.022,
                      ),
                      InkWell(
                        onTap: () async {
                          await adController.pickDate(context);
                          await adController.picktime(context);
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                right: width * 0.03,
                                top: width * 0.03),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 3,
                                      spreadRadius: 1)
                                ],
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(15)),
                            // height: hight * 0.12,
                            width: width * 0.8,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Schedule:',
                                      color: Colors.grey[900],
                                      size: width * 0.05,
                                      weight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: hight * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextWidget(
                                        text: 'Date:  ' +
                                            DateFormat('dd MMM yyyy').format(
                                                (DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        (adController.pickedDate
                                                            .millisecondsSinceEpoch)))),
                                        color: Colors.grey[900],
                                        size: width * 0.04,
                                        weight: FontWeight.w500,
                                      ),
                                      TextWidget(
                                        text:
                                            'Time:${adController.pickedTime.format(context)}',
                                        color: Colors.grey[900],
                                        size: width * 0.04,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: hight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButtonWidget(
                        onClick: () async {
                          await adController.step1();
                        },
                        buttonName: 'Next',
                        bgColor: Colors.indigo[900],
                        textColor: Colors.white,
                        height: hight * 0.05,
                        minWidth: width * 0.60,
                        textSize: hight * 0.02,
                        trailingIcon: Icon(
                          Icons.arrow_forward_ios,
                          size: hight * 0.015,
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
