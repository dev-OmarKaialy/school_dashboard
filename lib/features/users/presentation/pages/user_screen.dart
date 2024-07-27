import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/features/users/presentation/bloc/users_bloc.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/resources/cubit_status.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/flutter_switch.dart';
import '../../../../core/widgets/main_error_widget.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    context.read<UsersBloc>().add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الطلاب'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.failed => MainErrorWidget(onPressed: () {
                context.read<UsersBloc>().add(GetUsersEvent());
              }),
            CubitStatus.success => Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  for (int index = 0; index < state.users.length; index++)
                    Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              LightThemeColors.linearThirdColor,
                              LightThemeColors.linearSecondColor,
                              LightThemeColors.linearFirstColor,
                            ]),
                            borderRadius: BorderRadius.circular(15)),
                        width: context.isPhone
                            ? .9.sw
                            : context.isTablet
                                ? .45.sw
                                : .48.sw,
                        child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                              expansionTileTheme: const ExpansionTileThemeData(
                                backgroundColor: Colors.transparent,
                                collapsedBackgroundColor: Colors.transparent,
                              ),
                            ),
                            child: ExpansionTile(
                                childrenPadding: const EdgeInsets.all(20),
                                collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.r)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.r)),
                                title: Text(
                                  state.users[index].className!,
                                  style: context.textTheme.titleLarge
                                      ?.copyWith(fontSize: FontSize.s20),
                                ),
                                children: [
                                  Row(
                                    children: [
                                      const Text('الحالة: '),
                                      FlutterSwitch(
                                        value: state.users[index].block == 0,
                                        activeColor: Colors.green,
                                        inactiveColor: Colors.red,
                                        onToggle: (v) {
                                          context.read<UsersBloc>().add(
                                              ToggleBlockUserEvent(
                                                  id: state.users[index].id!));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('الصورة: '),
                                      Container(
                                        width: 80.w,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            color: LightThemeColors
                                                .linearSecondColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Image.network(
                                            state.users[index].image!),
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('رقم الهاتف: '),
                                      Text(state.users[index].phone!),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('العنوان: '),
                                      Text(state.users[index].address
                                          .toString()),
                                    ],
                                  ),
                                ])))
                ],
              ),
            CubitStatus.loading => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isDesktop
                        ? 4
                        : context.isTablet
                            ? 3
                            : 1,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ShimmerWidget.rectangular(
                    height: 20,
                    borderRadius: 25,
                  );
                }),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
