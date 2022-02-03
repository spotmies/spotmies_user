import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';



 
  

  popularServices(BuildContext context, List icons, List serviceNames) {
  return Container(
    // alignment: Alignment.center,
    height: height(context) * 0.44,
    width: width(context),
    // color: Colors.amber,

    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: width(context) * 0.075),
          alignment: Alignment.centerLeft,
          // color: Colors.amber,
          height: height(context) * 0.07,
          width: width(context),
          child: TextWid(
            text: 'Popular services',
            size: width(context) * 0.06,
            weight: FontWeight.w600,
          ),
        ),
        Container(
          height: height(context) * 0.35,
          // color: Colors.amber,
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: icons.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Container(
                  height: height(context) * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        icons[index],
                        color: SpotmiesTheme.onBackground,
                      ),
                      TextWid(
                        text: serviceNames[index],
                        align: TextAlign.center,
                        color: SpotmiesTheme.onBackground,
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    ),
  );
}


