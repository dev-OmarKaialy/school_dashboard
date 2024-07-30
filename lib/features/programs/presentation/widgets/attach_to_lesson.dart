import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/config/extensions/widget_extensions.dart';
import 'package:school_daashboard/core/widgets/main_button.dart';
import 'package:school_daashboard/core/widgets/main_menu_button.dart';
import 'package:school_daashboard/core/widgets/main_text_field.dart';
import 'package:school_daashboard/features/programs/presentation/bloc/programs_bloc.dart';

import '../../../subject/presentation/bloc/lessons_bloc.dart';
import '../../../teacher/presentation/bloc/teacher_bloc.dart';

class AttachToLesson extends StatefulWidget {
  const AttachToLesson({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<AttachToLesson> createState() => _AttachToLessonState();
}

class _AttachToLessonState extends State<AttachToLesson> {
  var valueNotifier = ValueNotifier<int?>(null);
  var valueNotifierq = ValueNotifier<int?>(null);
  var time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: .6.sw,
        padding: EdgeInsets.all(18.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'أضافة درس',
              style: context.textTheme.titleLarge,
            ),
            35.verticalSpace,
            const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text('اختر الدرس')),
            BlocBuilder<LessonsBloc, LessonsState>(
              builder: (context, state) {
                return DropDownWidget(
                  listenableValue: valueNotifierq,
                  items: state.tlessons.map((e) {
                    return DropdownMenuItem(
                      value: e.id!,
                      child: Text(e.name!),
                    );
                  }).toList(),
                );
              },
            ),
            20.verticalSpace,
            const Align(
                alignment: AlignmentDirectional.topStart,
                child: Text('اختر المدرس')),
            BlocBuilder<TeacherBloc, TeacherState>(
              builder: (context, state) {
                return DropDownWidget(
                  listenableValue: valueNotifier,
                  items: state.teachers.map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name!),
                    );
                  }).toList(),
                );
              },
            ),
            20.verticalSpace,
            MainTextField(
              enabled: false,
              controller: time,
            ).onTap(() {
              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((value) {
                if (value != null) {
                  time.text = DateFormat('HH:mm')
                      .format(DateTime(0, 1, 1, value.hour, value.minute));
                }
              });
            }),
            20.verticalSpace,
            Row(
              children: [
                MainButton(
                    text: 'إضافة',
                    onPressed: () {
                      context.read<ProgramsBloc>().add(AttachToLessonEvent(
                          programId: widget.id,
                          teacherId: valueNotifier.value!,
                          lessonId: valueNotifierq.value!,
                          time: time.text));
                      Navigator.pop(context);
                    }),
                MainButton(
                    text: 'الغاء',
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
