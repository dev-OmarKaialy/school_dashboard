import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/subject/data/models/subject_model.dart';

import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../bloc/subject_bloc.dart';

class UpdateSubjectDialog extends StatefulWidget {
  const UpdateSubjectDialog({
    super.key,
    required this.subjectModel,
  });
  final SubjectModel subjectModel;
  @override
  State<UpdateSubjectDialog> createState() => _UpdateSubjectDialogState();
}

class _UpdateSubjectDialogState extends State<UpdateSubjectDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    titleController.text = widget.subjectModel.name!;
    descriptionController.text = widget.subjectModel.description!;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRaduis.r19)),
      child: BlocListener<SubjectBloc, SubjectState>(
        listener: (context, state) {
          if (state.addStatus == CubitStatus.loading) {
            Toaster.showLoading();
          } else {
            Toaster.closeLoading();
            if (state.addStatus == CubitStatus.success) {
              Navigator.pop(context);
            }
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 20.sp),
          width: 1.sw >= 800 ? .5.sw : .9.sw,
          height: .7.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Update New Subject',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontSize: FontSize.s22),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MainTextField(
                      controller: titleController,
                      text: 'Title:',
                      hint: 'Enter Title',
                      validator: (value) {
                        if (value != null && value.length > 4) {
                          return null;
                        } else {
                          return 'Enter Valid Subject Name';
                        }
                      },
                    ),
                    30.verticalSpace,
                    MainTextField(
                      controller: descriptionController,
                      text: 'Description:',
                      hint: 'Enter Subject Description',
                      maxLines: 4,
                      validator: (value) {
                        if (value != null && value.length > 12) {
                          return null;
                        } else {
                          return 'Enter Valid Subject Name';
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                      text: 'Update',
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            (titleController.text != widget.subjectModel.name ||
                                descriptionController.text !=
                                    widget.subjectModel.description)) {
                          context.read<SubjectBloc>().add(UpdateSubjectsEvent(
                              id: widget.subjectModel.id!,
                              title: titleController.text,
                              description: descriptionController.text));
                        }
                      }),
                  MainButton(
                      text: 'Cancel',
                      color: context.scaffoldBackgroundColor,
                      borderColor: context.primaryColor,
                      textColor: context.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
