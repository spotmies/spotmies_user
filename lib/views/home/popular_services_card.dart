
import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/home/ads/adpost.dart';
import 'package:spotmies/views/home/searchJobs/search.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class PopularServices extends StatelessWidget {
  final List? icons;
  final List? serviceNames;
  const PopularServices({Key? key, this.icons, this.serviceNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      height: height(context) * 0.43,
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
                itemCount: icons?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (serviceNames![index]['id'] == 'more') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilterLocalListPage()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PostAd(sid: serviceNames![index]['id'])));
                      }
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => PostAd(id: serviceNames![index]['id'])));
                    },
                    child: Container(
                      height: height(context) * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            icons![index],
                            color: SpotmiesTheme.onBackground,
                          ),
                          TextWid(
                            text: serviceNames![index]['ser'],
                            align: TextAlign.center,
                            color: SpotmiesTheme.onBackground,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
