import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotmies/utilities/fonts.dart';
import 'package:spotmies/utilities/snackbar.dart';

String chatInput;
TextEditingController inputController = TextEditingController();

Container chatInputField(
    sendCallBack, BuildContext context, double hight, double width) {
  // bool isInput = false;

  // var formkey = GlobalKey<FormState>();

  return Container(
    padding: EdgeInsets.all(10),
    color: Colors.transparent,
    height: 70,
    child: Row(
      children: [
        Expanded(
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 14),
            height: hight * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200], blurRadius: 2, spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style:
                        fonts(width * 0.05, FontWeight.w500, Colors.grey[900]),
                    controller: inputController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      suffixIcon: inputController.text.isEmpty
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey[500],
                                size: width * 0.05,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                inputController.clear();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey[500],
                                size: width * 0.05,
                              ),
                            ),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mic,
                          color: Colors.grey[500],
                          size: width * 0.07,
                        ),
                      ),
                      border: InputBorder.none,
                      hintStyle: fonts(
                          width * 0.05, FontWeight.w400, Colors.grey[400]),
                      hintText: 'Type Message......',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        InkWell(
          onTap: () {
            if (inputController.text == "") {
              snackbar(context, 'Enter Message');
            } else {
              sendCallBack(inputController.text);
              inputController.clear();
            }
            log(inputController.text);
          },
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey[500],
            radius: width * 0.065,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
