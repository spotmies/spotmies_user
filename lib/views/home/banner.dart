import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/partner_details/partner_list.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

banner(BuildContext context) {
  return Column(
    children: [
      Container(
        height: height(context) * 0.2,
        width: width(context),
        child: Container(
            height: height(context) * 0.18,
            width: width(context) * 0.9,
            padding: EdgeInsets.only(
                left: width(context) * 0.025, right: width(context) * 0.025),
            margin: EdgeInsets.all(width(context) * 0.025),
            decoration: BoxDecoration(
                color: SpotmiesTheme.cyan,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width(context) * 0.45,
                  height: height(context) * 0.16,
                  // color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextWid(
                            text: 'Find partner',
                            // align: TextAlign.end,
                            size: width(context) * 0.06,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: width(context) * 0.02,
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PartnerList()));
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.01,
                      ),
                      TextWid(
                        text: 'Find best technician near to your home',
                        // align: TextAlign.end,
                        size: width(context) * 0.04,
                        flow: TextOverflow.visible,
                        color: Colors.white,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Container(
                    // color: Colors.amber,
                    width: width(context) * 0.35,
                    child: SvgPicture.asset('assets/tradesman.svg')),
              ],
            )),
      ),
      SizedBox(
        height: height(context) * 0.05,
      )
    ],
  );
}
