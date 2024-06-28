import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/global_functions.dart';
import 'package:school_daashboard/features/main/presentation/pages/main_screen.dart';

import '../../../auth/presentation/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 2), () async {
      final result = await GlobalFunctions().isAuth();
      if (result) {
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (contex) => const MainScreen()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (contex) => const LoginScreen()));
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 1.sw,
      height: 1.sh,
      decoration: const BoxDecoration(
        color: Color(0xff4880FF),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/background.png',
          ),
        ),
      ),
      child: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              'assets/app_icon.png',
            )),
      ),
    ));
  }
}
