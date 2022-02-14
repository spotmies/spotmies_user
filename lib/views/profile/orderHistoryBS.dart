
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/posts/post_overview.dart';
import 'package:spotmies/views/reusable_widgets/date_formates%20copy.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

Future history(BuildContext context, GetOrdersProvider? ordersProvider,
    UniversalProvider? up) {
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
            height: height(context) * 0.95,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: ListView(children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  height: height(context) * 0.22,
                  child: SvgPicture.asset('assets/history.svg')),
              Container(
                padding:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                child: TextWid(
                  text: 'Spotmies Journey',
                  weight: FontWeight.w600,
                  color: SpotmiesTheme.secondaryVariant,
                  size: width(context) * 0.05,
                ),
              ),
              Consumer<GetOrdersProvider>(builder: (context, data, child) {
                dynamic ol = data.getOrdersList;
                // log(ol.toString());
                return Container(
                  height: height(context) * 3 + 220,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ol.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<String> images = List.from(ol[index]['media']);
                        return Container(
                          height: height(context) * 0.15,
                          width: width(context),
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: SpotmiesTheme.surfaceVariant2,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: width(context) * 0.08,
                                child: (images.length == 0)
                                    ? Icon(
                                        Icons.engineering,
                                        color: Colors.grey[900],
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          images.first,
                                          fit: BoxFit.fill,
                                        )),
                              ),
                              Container(
                                width: width(context) * 0.52,
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWid(
                                      text: up?.getServiceNameById(
                                          ol[index]['job']),
                                      size: width(context) * 0.04,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(
                                      height: height(context) * 0.02,
                                    ),
                                    TextWid(
                                        text: ol[index]['problem'].toString(),
                                        flow: TextOverflow.ellipsis,
                                        size: width(context) * 0.04),
                                    SizedBox(
                                      height: height(context) * 0.01,
                                    ),
                                    TextWid(
                                      text: getDate(ol[index]['schedule']) +
                                          ' - ' +
                                          getTime(ol[index]['schedule']),
                                      color: Colors.grey[600]!,
                                      size: width(context) * 0.02,
                                      weight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => PostOverView(
                                            ordId:
                                                ol[index]['ordId'].toString(),
                                          ),
                                        ));
                                      },
                                      child: TextWid(
                                        text: 'More',
                                        size: width(context) * 0.04,
                                        weight: FontWeight.w500,
                                        color: Colors.grey[500],
                                      )))
                            ],
                          ),
                        );
                      }),
                );
              })
            ]));
      });
}
