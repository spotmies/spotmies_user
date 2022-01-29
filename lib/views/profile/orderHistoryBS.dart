import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/utilities/fonts.dart';

Future history(BuildContext context, double hight, double width) {
  List<Map<String, Object>> data = [
    {
      "service": "teacher",
      "problem": "Need Maths Teacher",
      "pic": Icons.home_repair_service,
      "date": '24th Aug,2021',
      "time": '04:30 PM',
    },
  ];
  return showModalBottomSheet(
      context: context,
      elevation: 22,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: SpotmiesTheme.background,
      builder: (BuildContext context) {
        return Container(
            height: hight * 0.95,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: ListView(children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: hight * 0.22,
                  child: SvgPicture.asset('assets/history.svg')),
              Container(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                child: Text(
                  'Spotmies Journey',
                  textAlign: TextAlign.center,
                  style: fonts(width * 0.05, FontWeight.w600,
                      SpotmiesTheme.secondaryVariant),
                ),
              ),
              Container(
                height: hight * 3 + 220,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: hight * 0.15,
                        width: width,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: SpotmiesTheme.surfaceVariant2,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: width * 0.08,
                              child: Icon(
                                (data[0]['pic'] as IconData?) ?? Icons.photo,
                                color: Colors.grey[500],
                                size: width * 0.1,
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
                                    data[0]['service'].toString(),
                                    style: fonts(width * 0.04, FontWeight.w600,
                                        SpotmiesTheme.secondaryVariant),
                                  ),
                                  SizedBox(
                                    height: hight * 0.02,
                                  ),
                                  Text(
                                    data[0]['problem'].toString(),
                                    style: fonts(width * 0.04, FontWeight.w500,
                                        SpotmiesTheme.secondaryVariant),
                                  ),
                                  SizedBox(
                                    height: hight * 0.01,
                                  ),
                                  Text(
                                    '${data[0]['date']}  ' +
                                        '${data[0]['time']}',
                                    style: fonts(width * 0.02, FontWeight.w500,
                                        SpotmiesTheme.secondaryVariant),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'More',
                                      style: fonts(
                                          width * 0.04,
                                          FontWeight.w500,
                                          SpotmiesTheme.secondary),
                                    )))
                          ],
                        ),
                      );
                    }),
              )
            ]));
      });
}
