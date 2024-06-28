import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFunctions {
  //
  // void showSuccessDialog({
  //   required BuildContext context,
  //   String? text,
  //   Color? color,
  //   double size = 50,
  // }) {
  //   final contextSize = MediaQuery.of(context).size;
  //   const image = AssetImage(
  //     'assets/gif/success.gif',
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         elevation: 5,
  //         child: Container(
  //           padding: EdgeInsets.all(contextSize.width * .05),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Image(
  //                     image: image,
  //                     key: UniqueKey(),
  //                     width: size,
  //                     height: size,
  //                   ),
  //                   Text(
  //                     text ?? serviceLocator<LocalizationClass>().appLocalizations!.yourOrderIsSent,
  //                   ),
  //                 ],
  //               ),
  //               MainButton(
  //                 text: serviceLocator<LocalizationClass>().appLocalizations!.done,
  //                 color: color ?? AppColors.blue,
  //                 textColor: color == null
  //                     ? Colors.white
  //                     : (color.isLight)
  //                         ? Colors.grey.shade700
  //                         : Colors.white,
  //                 height: 20,
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   ).then(
  //     (value) => image.evict(),
  //   );
  // }
  //
  // Future<bool> showPopDialog(BuildContext context) async {
  //   return await showDialog(
  //         context: context,
  //         builder: (_) {
  //           final Size size = MediaQuery.of(context).size;
  //           final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
  //           return Dialog(
  //             backgroundColor: Colors.transparent,
  //             elevation: 5,
  //             child: Container(
  //               padding: EdgeInsets.all(size.width * .05),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     appLocalizations.warning,
  //                     style: AppTextStyles.styleWeight700(
  //                       color: Colors.black,
  //                       fontSize: size.width * .05,
  //                     ),
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       const SizedBox(height: 15),
  //                       Text(appLocalizations.igonreChanges),
  //                       const SizedBox(height: 15),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       MainButton(
  //                         text: appLocalizations.cancel,
  //                         color: AppColors.grey1,
  //                         textColor: Colors.grey.shade700,
  //                         onPressed: () => Navigator.of(_).pop(false),
  //                       ),
  //                       MainButton(
  //                         text: appLocalizations.agree,
  //                         color: AppColors.blue,
  //                         textColor: Colors.white,
  //                         onPressed: () {
  //                           serviceLocator<NavBarBloc>().add(const ToggleNavBarEvent(isHidden: false));
  //                           Navigator.of(_).pop(true);
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ) ??
  //       false;
  // }

  Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('accessToken');
    return token;
  }

  //
  Future<void> setTheme({
    required bool isDarkMode,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('darkTheme', isDarkMode);
  }

  Future<bool> getTheme() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('darkTheme') ?? false;
  }

  Future<void> setUserInfo({
    String? accessToken,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (accessToken != null) sp.setString('accessToken', accessToken);
  }

  // logOut(BuildContext context) async {
  //   BotToast.showCustomLoading(toastBuilder: (_) {
  //     return getLoading(context: context);
  //   });
  //   SharedPreferences _sp = await SharedPreferences.getInstance();
  //   _sp.remove(PrefsKeys.TOKEN);
  //   _sp.remove(PrefsKeys.USERINFO);

  //   BotToast.closeAllLoading();
  //   // RestartWidget.restartApp(context);
  //   exit(0);
  // }
  getLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const CircularProgressIndicator.adaptive());
  }

  clearUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('accessToken');
    sp.remove('userInfo');
  }

  Future<bool> isAuth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey('accessToken');
  }
}
