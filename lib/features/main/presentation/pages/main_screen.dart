import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_daashboard/core/global_functions.dart';
import 'package:school_daashboard/features/splash/presentation/pages/splash_screen.dart';

import '../../../../core/config/extensions/context_extensions.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../cubit/main_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: CollapsibleSidebar(
                showTitle: false,
                screenPadding: 0,
                backgroundColor: context.scaffoldBackgroundColor,
                selectedTextColor: context.primaryColor,
                unselectedTextColor: Colors.grey[700]!,
                selectedIconColor: context.primaryColor,
                toggleTitle: 'تصغير',
                selectedIconBox: context.scaffoldBackgroundColor,
                sidebarBoxShadow: [
                  BoxShadow(
                      color: context.primaryColor,
                      blurRadius: 7,
                      offset: const Offset(-5, 0)),
                ],
                items: [
                  CollapsibleItem(
                    text: 'الرئيسية',
                    icon: Icons.home,
                    onPressed: () {
                      context.read<MainCubit>().changeIndex(0);
                    },
                    isSelected: state.index == 0,
                    onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("الرئيسية"))),
                  ),
                  CollapsibleItem(
                    text: 'تسجيل الخروج',
                    icon: Icons.logout_rounded,
                    onPressed: () async {
                      print('pressed');
                      await GlobalFunctions().clearUserInfo();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SplashScreen();
                          },
                        ),
                        (route) {
                          return true;
                        },
                      );
                    },
                    isSelected: state.index == 1000,
                    onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تسجيل الخروج"))),
                  ),
                ],
                body: IndexedStack(
                  index: state.index,
                  children: const [
                    HomeScreen(),
                  ],
                )),
          );
        },
      ),
    );
  }
}
