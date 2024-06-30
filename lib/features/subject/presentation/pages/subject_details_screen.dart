import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/resources/font_manager.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/subject_bloc.dart';

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
            backgroundColor: Colors.cyan.withOpacity(.3),
            title: Text(
                'Subject ${state.showStatus == CubitStatus.success ? state.subject?.name : ''}'),
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
                          width: .48.sw,
                        )
                    ],
                  ),
                CubitStatus.success => BlocBuilder<LessonsBloc, LessonsState>(
                    builder: (context, lessonState) {
                      return Wrap(
                        runSpacing: 20,
                        spacing: 20,
                        children: [
                          for (int i = 0; i < lessonState.lessons.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff2AD4FF),
                                    Color(0xff8080FF),
                                  ]),
                                  borderRadius: BorderRadius.circular(15)),
                              width: 1.sw > 800 ? .48.sw : .9.sw,
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
                                    visualDensity: VisualDensity.comfortable,
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
                                              color: Colors.white,
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
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.edit_note_rounded,
                                                size: 30.sp,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                context.read<LessonsBloc>().add(
                                                    DeleteLessonEvent(
                                                        id: lessonState
                                                            .lessons[i].id!));
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
                                              'Text:       ',
                                              style: context
                                                  .textTheme.titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: FontSize.s16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  lessonState.lessons[i].text!,
                                                  style: context
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ]),
                                      20.verticalSpace,
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Activity:       ',
                                              style: context
                                                  .textTheme.titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: FontSize.s16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  lessonState
                                                      .lessons[i].activity!,
                                                  style: context
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ]),
                                      20.verticalSpace,
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Description:       ',
                                                style: context
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontSize:
                                                            FontSize.s18)),
                                            Expanded(
                                              child: Text(
                                                  lessonState
                                                      .lessons[i].description!,
                                                  style: context
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                    color: Colors.white,
                                                  )),
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
                                            'Lesson Image:',
                                            style: context.textTheme.titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
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
                  ),
                _ => const SizedBox(),
              }),
        );
      },
    );
  }
}
