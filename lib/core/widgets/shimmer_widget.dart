import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../config/extensions/context_extensions.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.shapeBorder});

  final double width;
  final double borderRadius;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.circlar({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 10,
    this.shapeBorder = const CircleBorder(),
  });

  ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    this.borderRadius = double.infinity,
    required this.height,
  }) : shapeBorder = RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.r)));

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
