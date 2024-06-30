import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/resources/dimension_manager.dart';
import 'package:school_daashboard/core/resources/font_manager.dart';
import 'package:school_daashboard/core/widgets/main_button.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/features/subject/presentation/pages/subject_details_screen.dart';
import 'package:school_daashboard/features/subject/presentation/widgets/update_subject_dialog.dart';

import '../bloc/subject_bloc.dart';
import '../widgets/add_subject_dialog.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  void didChangeDependencies() {
    context.read<SubjectBloc>().add(GetSubjectsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubjectBloc, SubjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(40.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subjects',
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontSize: FontSize.s22),
                  ),
                  MainButton(
                    text: ' Add',
                    width: .1.sw,
                    onPressed: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return const AddSubjectDialog();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
              30.verticalSpace,
              Expanded(
                child: switch (state.status) {
                  CubitStatus.failed => Center(
                      child: MainButton(
                        text: ' Try Again!',
                        onPressed: () {
                          context.read<SubjectBloc>().add(GetSubjectsEvent());
                        },
                        icon: const Icon(
                          Icons.refresh,
                        ),
                      ),
                    ),
                  CubitStatus.loading => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25),
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return ShimmerWidget.rectangular(
                          height: 40,
                          width: 40,
                        );
                      },
                    ),
                  CubitStatus.success => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25),
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRaduis.r19),
                            gradient: const LinearGradient(colors: [
                              Color(0xff2AD4FF),
                              Color(0xff8080FF),
                            ]),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(
                                  state.subjects[index].name!,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                child: PopupMenuButton(
                                  iconColor: context.scaffoldBackgroundColor,
                                  color: context.scaffoldBackgroundColor,
                                  icon: const Icon(Icons.more_horiz_outlined),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: const Text('Edit'),
                                        onTap: () {
                                          showAdaptiveDialog(
                                              context: context,
                                              builder: (context) {
                                                return UpdateSubjectDialog(
                                                    subjectModel:
                                                        state.subjects[index]);
                                              });
                                        },
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return SubjectDetailsScreen(
                                                  subjectId: state
                                                      .subjects[index].id!);
                                            },
                                          ));
                                        },
                                        child: const Text('View'),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          context.read<SubjectBloc>().add(
                                              DeleteSubjectEvent(
                                                  id: state
                                                      .subjects[index].id!));
                                        },
                                        child: const Text('Delete'),
                                      )
                                    ];
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  _ => const SizedBox(),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
