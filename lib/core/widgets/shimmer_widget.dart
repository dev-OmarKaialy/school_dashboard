import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../config/extensions/context_extensions.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.shapeBorder});

  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.circlar({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r)));

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      //this is background color
      baseColor: context.primaryColor,
      //this is foreground color
      highlightColor: Colors.grey[500]!,
      // the duration that loading animation take
      period: const Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        // shape of loading
        decoration: ShapeDecoration(
          color: context.theme.cardColor,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
