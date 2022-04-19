import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotmies/providers/theme_provider.dart';

class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  const CustomWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor:
            SpotmiesTheme.themeMode ? Colors.grey.shade700 : Color(0xFFf8faf8),
        highlightColor:
            SpotmiesTheme.themeMode ? Colors.grey.shade800 : Color(0xFFe0e1e2),
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: SpotmiesTheme.themeMode
                ? Colors.grey.shade700
                : Color(0xFFf8faf8),
            shape: shapeBorder,
          ),
        ),
      );
}
