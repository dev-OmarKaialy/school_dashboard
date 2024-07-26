import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/config/theme/light_theme.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/widgets/flutter_switch.dart';
import 'package:school_daashboard/core/widgets/main_error_widget.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/features/teacher/presentation/bloc/teacher_bloc.dart';

import '../../../../core/resources/font_manager.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => TeachersScreenState();
}

class TeachersScreenState extends State<TeachersScreen> {
  @override
  void initState() {
    context.read<TeacherBloc>().add(IndexTeachersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Teachers Screen'),
      ),
      body: BlocBuilder<TeacherBloc, TeacherState>(
        builder: (context, state) {
          return switch (state.indexStatus) {
            CubitStatus.failed => MainErrorWidget(onPressed: () {
                context.read<TeacherBloc>().add(IndexTeachersEvent());
              }),
            CubitStatus.success => Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  for (int index = 0; index < state.teachers.length; index++)
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
                                  state.teachers[index].name!,
                                  style: context.textTheme.titleLarge
                                      ?.copyWith(fontSize: FontSize.s20),
                                ),
                                children: [
                                  Row(
                                    children: [
                                      const Text('Status: '),
                                      FlutterSwitch(
                                        value: state.teachers[index].block == 0,
                                        activeColor: Colors.green,
                                        inactiveColor: Colors.red,
                                        onToggle: (v) {
                                          context.read<TeacherBloc>().add(
                                              BlockTeachersEvent(
                                                  id: state
                                                      .teachers[index].id!));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Image: '),
                                      Container(
                                        width: 80.w,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            color: LightThemeColors
                                                .linearSecondColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Image.network(
                                            state.teachers[index].image!),
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Email: '),
                                      Text(state.teachers[index].email!),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Specility: '),
                                      Text(state.teachers[index].specilty!),
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
