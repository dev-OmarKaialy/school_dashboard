import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/extensions/context_extensions.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    required this.title,
    required this.onTapYes,
  });
  final String title;
  final Function() onTapYes;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
          width: 502.w,
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 25.w),
          decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          // width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              40.verticalSpace,
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge,
              ),
              SizedBox(height: 75.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 7.sp),
                      decoration: BoxDecoration(
                        color: context.scaffoldBackgroundColor,
                        border: Border.all(
                          color: context.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "No",
                          style: context.textTheme.titleLarge!
                              .copyWith(color: context.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onTapYes();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 7.sp),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Yes",
                          style: context.textTheme.titleLarge!
                              .copyWith(color: context.scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          )),
    );
  }
}
