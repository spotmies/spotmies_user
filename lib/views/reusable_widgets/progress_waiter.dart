import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/utilities/appConfig.dart';
import 'package:spotmies/views/reusable_widgets/text_wid.dart';

class ProgressWaiter extends StatelessWidget {
  ProgressWaiter(
      {required this.contextt,
      required this.loaderState,
      this.loadingName = "Verifying Please Wait..."});

  final BuildContext contextt;
  final bool loaderState;
  final String loadingName;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaderState,
      child: Positioned.fill(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: AbsorbPointer(
          absorbing: loaderState,
          child: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  // strokeWidth: 6.0,
                  // backgroundColor: Colors.white,
                  color: SpotmiesTheme.themeMode
                      ? SpotmiesTheme.primaryVariant
                      : SpotmiesTheme.primary,
                      
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextWid(
                    text: loadingName,
                    color: SpotmiesTheme.themeMode
                        ? SpotmiesTheme.primaryVariant
                        : SpotmiesTheme.primary,
                    weight: FontWeight.bold,
                    size: width(context) * 0.06,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({
    Key? key,
    required double height,
    required double width,
    required String title,
  })  : _height = height,
        _width = width,
        title = title,
        super(key: key);

  final double _height;
  final double _width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
          height: _height * 0.8,
          width: _width,
          alignment: Alignment.center,
          child: TextWid(
            maxlines: 5,
            text: title,
            color: SpotmiesTheme.onBackground,
            size: 18,
          )),
    );
  }
}
