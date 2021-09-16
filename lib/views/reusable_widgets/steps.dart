import 'package:flutter/material.dart';

steps(
    int step,
    double width,
  ) {
    return Container(
      width: width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: step == 1 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 1 ? Colors.indigo[900] : Colors.indigo[100],
          ),
          CircleAvatar(
            radius: step == 2 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 2 ? Colors.indigo[900] : Colors.indigo[100],
          ),
          CircleAvatar(
            radius: step == 3 ? width * 0.015 : width * 0.01,
            backgroundColor:
                step == 3 ? Colors.indigo[900] : Colors.indigo[100],
          )
        ],
      ),
    );
  }