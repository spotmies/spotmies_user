import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/home/category_view.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class Categories extends StatefulWidget {
  final List? color;
  const Categories({Key? key, this.color}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  UniversalProvider? up;
  @override
  void initState() {
    super.initState();

    up = Provider.of<UniversalProvider>(context, listen: false);
    up?.setCurrentConstants("serviceRequest");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: width(context) * 0.075),
          alignment: Alignment.centerLeft,
          // color: Colors.amber,
          height: height(context) * 0.07,
          width: width(context),
          child: TextWid(
            text: 'Categories',
            size: width(context) * 0.06,
            weight: FontWeight.w600,
          ),
        ),
        Container(
          height: height(context) * 0.25,
          child: ListView.builder(
              padding: EdgeInsets.only(left: width(context) * 0.04),
              itemCount: up?.getCategoryMainList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                dynamic serve = up?.getCategoryMainList().toList();
                // log(serve[index].toString());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: width(context) * 0.03),
                      decoration: BoxDecoration(
                          // color: Colors.grey,
                          ),
                      child: InkWell(
                        onTap: () {
                          // DefaultTabController.of(context)
                          //     ?.animateTo(index + 1);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatelogOverView(
                                      service: serve[index],
                                      index: index,
                                      color: widget.color![index + 1])));
                        },
                        child: Container(
                            height: height(context) * 0.2,
                            width: width(context) * 0.33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: widget.color![index + 1],
                            ),
                            padding: EdgeInsets.only(top: 15, left: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWid(
                                  text: serve[index]['nameOfService'],
                                  size: width(context) * 0.04,
                                  weight: FontWeight.w500,
                                  align: TextAlign.justify,
                                  // flow: TextOverflow.visible,
                                  color: SpotmiesTheme.onBackground,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    height: height(context) * 0.12,
                                    // width: width * 0.23,
                                    child: SvgPicture.asset(serve[index]
                                            ['userAppIcon']
                                        .toString())),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextWid(
                                        text: 'Explore',
                                        size: width(context) * 0.03,
                                        weight: FontWeight.w700,
                                        color: SpotmiesTheme.onBackground,
                                      ),
                                      Icon(
                                        Icons.double_arrow,
                                        size: width(context) * 0.04,
                                        color: SpotmiesTheme.onBackground,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                );
              }),
        ),
        SizedBox(
          height: height(context) * 0.03,
        )
      ],
    );
  }
}
