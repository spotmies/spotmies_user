import 'package:flutter/material.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

bottomOptionsMenu(context,
    {menuTitle = "Menu",
    List<dynamic> options,
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
        color: Colors.white,
        height: height(context) * 0.18,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWid(
                  text: menuTitle,
                  color: Colors.grey[800],
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
                    itemCount: options.length,
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

                              break;
                            default:
                          }
                          // Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  options.length == 2 || options.length == 3
                                      ? width(context) * 0.03
                                      : 5),
                          child: CircleAvatar(
                            radius: width(context) * 0.099,
                            backgroundColor: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  options[index]['icon'],
                                  color: Colors.grey[700],
                                ),
                                SizedBox(
                                  height: height(context) * 0.01,
                                ),
                                TextWid(
                                  text: options[index]['name'],
                                  color: Colors.grey[800],
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
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
