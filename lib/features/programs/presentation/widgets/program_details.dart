import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/config/theme/light_theme.dart';
import 'package:school_daashboard/features/programs/data/models/index_programs_datasource.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/lessons_bloc.dart';

class ProgramDetails extends StatefulWidget {
  const ProgramDetails({
    super.key,
    required this.program,
  });
  final ProgramModel program;
  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: .6.sw,
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('اسم البرنامج: \t\t',
                      style: context.textTheme.titleLarge),
                  Text(widget.program.name!),
                ],
              ),
              Row(
                children: [
                  Text('وصف البرنامج: \t\t',
                      style: context.textTheme.titleLarge),
                  Text(widget.program.description!),
                ],
              ),
              Row(
                children: [
                  Text('الدروس: ', style: context.textTheme.titleLarge),
                ],
              ),
              SizedBox(
                height: .5.sh,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8, childAspectRatio: 3),
                  children: [
                    for (int i = 0;
                        i < widget.program.programLesson!.length;
                        i++)
                      Card(
                        color: LightThemeColors.linearSecondColor,
                        child: Center(
                          child: Text(context
                                  .read<LessonsBloc>()
                                  .state
                                  .tlessons
                                  .where((e) {
                                    return e.id ==
                                        widget
                                            .program.programLesson![i].lessonId;
                                  })
                                  .firstOrNull
                                  ?.name ??
                              ''),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
