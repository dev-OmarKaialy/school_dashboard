import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/font_manager.dart';

class Toaster {
  Toaster._();
  static void showToast(String text, {bool isError = true}) {
    BotToast.showCustomText(toastBuilder: (cancelFunc) {
      return Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isError ? Icons.warning_amber_rounded : Icons.done,
                color: isError ? Colors.red : Colors.green, size: 20.sp),
            const SizedBox(width: 10),
            Text(text,
                style: TextStyle(
                    color: isError ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.s12)),
          ],
        ),
      ));
    });
  }

  static void showLoading() {
    BotToast.showCustomLoading(toastBuilder: (cancelFunc) {
      return const Card(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator()));
    });
  }

  static void closeLoading() {
    BotToast.closeAllLoading();
  }

  static void showNotification({
    Widget Function(void Function())? leading,
    Widget Function(void Function())? title,
    Widget Function(void Function())? subtitle,
    Color? backgroundColor,
  }) {
    BotToast.showNotification(
      title: title,
      subtitle: subtitle,
      leading: leading,
      backgroundColor: backgroundColor,
    );
  }
}
