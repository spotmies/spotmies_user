import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';

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
              step == 1 ? SpotmiesTheme.primary : Color(0xFFb2dbe6),
        ),
        CircleAvatar(
          radius: step == 2 ? width * 0.015 : width * 0.01,
          backgroundColor:
              step == 2 ? SpotmiesTheme.primary : Color(0xFFb2dbe6),
        ),
        CircleAvatar(
          radius: step == 3 ? width * 0.015 : width * 0.01,
          backgroundColor:
              step == 3 ? SpotmiesTheme.primary : Color(0xFFb2dbe6),
        ),
        CircleAvatar(
          radius: step == 4 ? width * 0.015 : width * 0.01,
          backgroundColor:
              step == 4 ? SpotmiesTheme.primary : Color(0xFFb2dbe6),
        )
      ],
    ),
  );
}
