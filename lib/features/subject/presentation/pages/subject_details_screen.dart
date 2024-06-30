import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/subject_bloc.dart';

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
      listener: (context, state) {},
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
                CubitStatus.success => Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      for (int i = 0; i < state.subject!.lessons!.length; i++)
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
                              expansionTileTheme: const ExpansionTileThemeData(
                                backgroundColor: Colors.transparent,
                                collapsedBackgroundColor: Colors.transparent,
                              ),
                            ),
                            child: ExpansionTile(
                                expansionAnimationStyle: AnimationStyle(
                                    curve: Curves.easeInCirc,
                                    duration: Durations.long2),
                                visualDensity: VisualDensity.comfortable,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(15)),
                                collapsedShape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.cyan),
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text(state.subject!.lessons![i].name!),
                                childrenPadding: const EdgeInsets.all(25),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Text:       '),
                                        Expanded(
                                          child: Text(
                                            state.subject!.lessons![i].text!,
                                          ),
                                        ),
                                      ]),
                                  20.verticalSpace,
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Activity:       '),
                                        Expanded(
                                          child: Text(
                                            state
                                                .subject!.lessons![i].activity!,
                                          ),
                                        ),
                                      ]),
                                  20.verticalSpace,
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Description:       '),
                                        Expanded(
                                          child: Text(
                                            state.subject!.lessons![i]
                                                .description!,
                                          ),
                                        ),
                                      ]),
                                  20.verticalSpace,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Lesson Image:'),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          state.subject!.lessons![i].image!,
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
                  ),
                _ => const SizedBox(),
              }),
        );
      },
    );
  }
}
