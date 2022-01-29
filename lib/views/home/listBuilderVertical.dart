import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/fonts.dart';

Widget serviceIndividualBuilder(
  BuildContext context,
  buildName,
  double width,
  double hight,
  List<Map<String, Object>> buildData,
) {
  return Container(
      height: hight * 0.8,
      width: width,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
              height: hight * 0.07,
              padding: EdgeInsets.only(
                left: 15,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$buildName',
                    style: fonts(
                        width * 0.06, FontWeight.w600, SpotmiesTheme.primary),
                  ),
                  TextButton(
                      onPressed: () {
                        DefaultTabController.of(context)?.animateTo(0);
                      },
                      child: Text(
                        'Home',
                        style: fonts(
                            width * 0.035, FontWeight.w600, Colors.grey[600]),
                      ))
                ],
              )),
          Container(
            height: hight * 0.694,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView.builder(
                itemCount: buildData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: hight * 0.1,
                    width: width,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: SpotmiesTheme.surfaceVariant2,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: SpotmiesTheme.surfaceVariant,
                          radius: width * 0.06,
                          child: Icon(
                            buildData[index]['icon'] as IconData?,
                            color: SpotmiesTheme.secondaryVariant,
                            size: width * 0.06,
                          ),
                        ),
                        Container(
                          width: width * 0.52,
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buildData[index]['job'].toString(),
                                style: fonts(width * 0.035, FontWeight.w600,
                                    SpotmiesTheme.secondaryVariant),
                              ),
                              SizedBox(
                                height: hight * 0.008,
                              ),
                              Text(
                                buildData[index]['desc'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: fonts(width * 0.03, FontWeight.w500,
                                    SpotmiesTheme.secondaryVariant),
                              ),
                              SizedBox(
                                height: hight * 0.01,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Book Service',
                                  style: fonts(width * 0.03, FontWeight.w500,
                                      Colors.grey[700]),
                                )))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ));
}
