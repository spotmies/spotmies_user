import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

bottomOptionsMenu(context,
    {menuTitle = "Menu",
    List<dynamic>? options,
    option1Click,
    option2Click,
    option3Click,
    option4Click}) {
  // final width(context) = MediaQuery.of(context).size.width;
  // final height(context) = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    elevation: 22,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(top: 10),
        color: SpotmiesTheme.surfaceVariant,
        height: height(context) * 0.17,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWid(
                  text: menuTitle,
                  color: SpotmiesTheme.secondaryVariant,
                  size: width(context) * 0.04,
                  weight: FontWeight.w300),
              Divider(
                thickness: width(context) * 0.005,
                indent: width(context) * 0.15,
                endIndent: width(context) * 0.15,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: options?.length,
                    // physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          switch (index) {
                            case 0:
                              if (option1Click != null) option1Click();
                              break;
                            case 1:
                              if (option2Click != null) option2Click();
                              break;
                            case 2:
                              if (option3Click != null) option3Click();
                              break;
                            case 3:
                              if (option4Click != null) option4Click();
                              break;
                            default:
                          }
                          // Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                options?[index]['icon'],
                                color: index == 2
                                    ? SpotmiesTheme.themeMode
                                        ? Colors.red.shade300
                                        : Colors.red
                                    : SpotmiesTheme.secondary,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              TextWid(
                                text: options?[index]['name'],
                                color: index == 2
                                    ? SpotmiesTheme.themeMode
                                        ? Colors.red.shade200
                                        : Colors.red
                                    : SpotmiesTheme.secondaryVariant,
                                weight: FontWeight.bold,
                                flow: TextOverflow.visible,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}



//options list must be this form

//   List options = [
//   {
//     "name": "view",
//     "icon": Icons.get_app,
//     "onPress": () {
//       print("view");
//     }
//   },
//   {
//     "name": "view2",
//     "icon": Icons.more,
//     "onPress": () {
//       print("view2");
//     }
//   },
//   {
//     "name": "view3",
//     "icon": Icons.phone,
//     "onPress": () {
//       print("view3");
//     }
//   },
//   {
//     "name": "view4",
//     "icon": Icons.computer,
//     "onPress": () {
//       print("view4");
//     }
//   },
// ];
