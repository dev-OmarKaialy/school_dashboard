import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/resources/font_manager.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/core/widgets/yes_no_dialog.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/subject_bloc.dart';
import 'package:school_daashboard/features/subject/presentation/widgets/add_lesson_dialog.dart';
import 'package:school_daashboard/features/subject/presentation/widgets/update_lesson_dialog.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/widgets/main_button.dart';
import '../bloc/lessons_bloc.dart';

class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({
    super.key,
    required this.subjectId,
  });
  final int subjectId;
  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  @override
  void didChangeDependencies() {
    context.read<SubjectBloc>().add(ShowSubjectEvent(id: widget.subjectId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectBloc, SubjectState>(
      listenWhen: (previous, current) {
        return previous.showStatus != current.showStatus;
      },
      listener: (context, state) {
        if (state.showStatus == CubitStatus.success) {
          context
              .read<LessonsBloc>()
              .add(AddLocalLessons(lessons: state.subject!.lessons!));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: LightThemeColors.linearThirdColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10))),
            title: Text(
                'مادة ${state.showStatus == CubitStatus.success ? state.subject?.name : ''}'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainButton(
                  text: ' إضافة درس',
                  width: .1.sw,
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, _, __) {
                        return AddLessonDialog(
                          id: widget.subjectId,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(15),
              child: switch (state.showStatus) {
                CubitStatus.loading => Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      for (int i = 0; i < 5; i++)
                        ShimmerWidget.rectangular(
                          height: 60,
                          width: !context.isPhone ? .48.sw : .9.sw,
                        )
                    ],
                  ),
                CubitStatus.success => switch (state.subject!.lessons!.length) {
                    0 => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(),
                          Image.asset(
                            'assets/noresults.png',
                          ),
                          Text(
                            'لا يوجد دروس بعد في هذه المادة',
                            style: context.textTheme.titleLarge
                                ?.copyWith(fontSize: FontSize.s24),
                          ),
                        ],
                      ),
                    _ => BlocBuilder<LessonsBloc, LessonsState>(
                        builder: (context, lessonState) {
                          return Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              for (int i = 0;
                                  i < lessonState.lessons.length;
                                  i++)
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
                                      expansionTileTheme:
                                          const ExpansionTileThemeData(
                                        backgroundColor: Colors.transparent,
                                        collapsedBackgroundColor:
                                            Colors.transparent,
                                      ),
                                    ),
                                    child: ExpansionTile(
                                        expansionAnimationStyle: AnimationStyle(
                                            curve: Curves.easeInCirc,
                                            duration: Durations.long2),
                                        visualDensity:
                                            VisualDensity.comfortable,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.cyan),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        collapsedShape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.cyan),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        title: Text(
                                          lessonState.lessons[i].name!,
                                          style: context.textTheme.titleLarge
                                              ?.copyWith(
                                                  fontSize: FontSize.s20),
                                        ),
                                        childrenPadding: const EdgeInsets.only(
                                            bottom: 25, right: 25, left: 25),
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        pageBuilder:
                                                            (context, _, __) {
                                                          return UpdateLessonDialog(
                                                              lesson: lessonState
                                                                  .lessons[i]);
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_note_rounded,
                                                    size: 30.sp,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    showAdaptiveDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return YesNoDialog(
                                                              title:
                                                                  'هل أنت متأكد ؟',
                                                              onTapYes: () {
                                                                context
                                                                    .read<
                                                                        LessonsBloc>()
                                                                    .add(DeleteLessonEvent(
                                                                        id: lessonState
                                                                            .lessons[i]
                                                                            .id!));
                                                              });
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                    size: 30.sp,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'النص:       ',
                                                  style: context
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                          fontSize:
                                                              FontSize.s16),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      lessonState
                                                          .lessons[i].text!,
                                                      style: context
                                                          .textTheme.titleLarge
                                                          ?.copyWith()),
                                                ),
                                              ]),
                                          20.verticalSpace,
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'النشاط:       ',
                                                  style: context
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                          fontSize:
                                                              FontSize.s16),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      lessonState
                                                          .lessons[i].activity!,
                                                      style: context
                                                          .textTheme.titleLarge
                                                          ?.copyWith()),
                                                ),
                                              ]),
                                          20.verticalSpace,
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('الوصف:       ',
                                                    style: context
                                                        .textTheme.titleLarge
                                                        ?.copyWith(
                                                            fontSize:
                                                                FontSize.s18)),
                                                Expanded(
                                                  child: Text(
                                                      lessonState.lessons[i]
                                                          .description!,
                                                      style: context
                                                          .textTheme.titleLarge
                                                          ?.copyWith()),
                                                ),
                                              ]),
                                          20.verticalSpace,
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'الصورة:',
                                                style: context
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                        fontSize: FontSize.s18),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  lessonState.lessons[i].image!,
                                                  width: .3.sw,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                )
                            ],
                          );
                        },
                      )
                  },
                _ => const SizedBox(),
              }),
        );
      },
    );
  }
}
