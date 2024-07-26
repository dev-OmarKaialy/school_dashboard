import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/widgets/main_text_field.dart';
import 'package:school_daashboard/features/section/data/models/section_model.dart';
import 'package:school_daashboard/features/section/presentation/bloc/section_bloc.dart';

import '../../../../core/widgets/main_button.dart';

class AddSectionDialog extends StatefulWidget {
  const AddSectionDialog({
    super.key,
    this.section,
  });
  final SectionModel? section;
  @override
  State<AddSectionDialog> createState() => _AddSectionDialogState();
}

class _AddSectionDialogState extends State<AddSectionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void didChangeDependencies() {
    if (widget.section != null) {
      nameController.text = widget.section!.name!;
      descriptionController.text = widget.section!.description!;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SectionBloc, SectionState>(
      listener: (context, state) {
        if (state.deleteStatus == CubitStatus.success) {
          Navigator.pop(context);
        }
      },
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: context.isDesktop ? .5.sh : .7.sh,
          width: context.isDesktop ? .5.sw : .8.sw,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: context.scaffoldBackgroundColor),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.section == null ? 'إضافة شعبة جديدة' : 'تعديل الشعبة',
                  style: context.textTheme.titleLarge,
                ),
                MainTextField(
                  controller: nameController,
                  hint: 'عنوان الشعبة',
                  text: 'العنوان:',
                  validator: (value) {
                    if (value != null &&
                        value.length > 4 &&
                        value.contains(
                            RegExp(r'[\u0621-\u064A\u0660-\u0669]'))) {
                      return null;
                    } else {
                      return 'الرجاء إدخال اسم مقبول';
                    }
                  },
                ),
                MainTextField(
                  controller: descriptionController,
                  hint: 'وصف الشعبة',
                  text: 'الوصف:',
                  maxLines: 5,
                  validator: (value) {
                    if (value != null &&
                        value.length > 10 &&
                        value.contains(
                            RegExp(r'[\u0621-\u064A\u0660-\u0669]'))) {
                      return null;
                    } else {
                      return 'الرجاء ادخال وصف مقبول';
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainButton(
                        text: widget.section == null ? 'إضافة' : 'تعديل',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SectionBloc>().add(
                                  widget.section == null
                                      ? AddSectionEvent(body: {
                                          'name': nameController.text,
                                          'description':
                                              descriptionController.text
                                        })
                                      : UpdateSectionEvent(
                                          body: {
                                            'name': nameController.text,
                                            'description':
                                                descriptionController.text,
                                          },
                                          id: widget.section!.id!,
                                        ),
                                );
                          }
                        }),
                    MainButton(
                        text: 'إلغاء',
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
      ),
    );
  }
}
