import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';

import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../bloc/subject_bloc.dart';

class AddSubjectDialog extends StatefulWidget {
  const AddSubjectDialog({
    super.key,
  });

  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
          width: context.isDesktop ? .5.sw : .9.sw,
          height: .7.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add New Subject',
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
                      text: 'Add',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SubjectBloc>().add(AddSubjectsEvent(
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
