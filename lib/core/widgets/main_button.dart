import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../config/extensions/context_extensions.dart';
import '../config/extensions/widget_extensions.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.shadowColor,
    this.icon,
    this.color,
    this.borderColor,
    required this.onPressed,
    this.textColor,
  });

  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final Color? borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRaduis.r8),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(color ?? context.primaryColor),
        fixedSize: WidgetStateProperty.all(
          Size(
            width ?? .2.sw,
            height ?? 48.h,
          ),
        ),
      ),
      onPressed: (onPressed != null)
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed!();
            }
          : null,
      child: FittedBox(
          fit: BoxFit.cover,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: icon!.withWidth(16.r)),
              10.horizontalSpace,
              Text(
                text,
                maxLines: 1,
                style: context.textTheme.titleLarge?.copyWith(
                    color: textColor ?? LightThemeColors.buttonTextColor,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    fontSize: fontSize ?? FontSize.s18),
              )
            ],
          ).paddingSymmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p8)),
    );
  }
}
