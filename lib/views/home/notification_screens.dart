import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class NotifyHome extends StatefulWidget {
  const NotifyHome({Key? key}) : super(key: key);

  @override
  State<NotifyHome> createState() => _NotifyHomeState();
}

class _NotifyHomeState extends State<NotifyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpotmiesTheme.light1,
      body: Container(
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: height(context) * 0.37,
                width: width(context) * 0.5,
                // color: Colors.amber,
                child: SvgPicture.asset("assets/catImages/notifications.svg")),
            TextWid(
              text: "You didn't have any notifications",
              color: SpotmiesTheme.onBackground,
            )
          ],
        ),
      ),
    );
  }
}
