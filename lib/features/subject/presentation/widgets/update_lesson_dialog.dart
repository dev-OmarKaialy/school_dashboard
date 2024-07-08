import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/subject/data/models/lessons_model.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/lessons_bloc.dart';

import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';

class UpdateLessonDialog extends StatefulWidget {
  const UpdateLessonDialog({
    super.key,
    required this.lesson,
  });
  final LessonModel lesson;
  @override
  State<UpdateLessonDialog> createState() => _UpdateLessonDialogState();
}

class _UpdateLessonDialogState extends State<UpdateLessonDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final activityController = TextEditingController();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<Uint8List?> image = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  void initState() {
    titleController.text = widget.lesson.name!;
    descriptionController.text = widget.lesson.description!;
    textController.text = widget.lesson.text!;
    activityController.text = widget.lesson.activity!;
    () async {
      isLoading.value = true;
      final result = await NetworkAssetBundle(Uri.parse(widget.lesson.image!))
          .load(widget.lesson.image!);
      image.value = result.buffer.asUint8List();
      isLoading.value = false;
    }.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRaduis.r19)),
      child: BlocListener<LessonsBloc, LessonsState>(
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add New Lesson',
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
                          return 'Enter Valid Lesson Title';
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
                    30.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MainTextField(
                            controller: activityController,
                            text: 'Activity:',
                            hint: 'Enter Activity',
                            validator: (value) {
                              if (value != null && value.length > 4) {
                                return null;
                              } else {
                                return 'Enter Valid Activity Title';
                              }
                            },
                          ),
                        ),
                        40.horizontalSpace,
                        Expanded(
                          child: MainTextField(
                            controller: textController,
                            text: 'Text:',
                            hint: 'Enter Text',
                            validator: (value) {
                              if (value != null && value.length > 10) {
                                return null;
                              } else {
                                return 'Enter Valid Text For Lesson';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lesson Image:',
                          style: context.textTheme.titleMedium,
                        ),
                        10.verticalSpace,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: ValueListenableBuilder(
                              valueListenable: image,
                              builder: (context, value, _) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final result = await pickFile();
                                        print(result);
                                        image.value = result;
                                      },
                                      child: Container(
                                        width: 150.sp,
                                        height: 150.sp,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: value != null
                                              ? Image.memory(value)
                                              : ValueListenableBuilder(
                                                  valueListenable: isLoading,
                                                  builder: (context, value, _) {
                                                    return value
                                                        ? const CircularProgressIndicator()
                                                        : const Icon(
                                                            Icons.image);
                                                  }),
                                        ),
                                      ),
                                    ),
                                    if (value != null)
                                      Positioned(
                                          top: -4,
                                          right: -4,
                                          child: GestureDetector(
                                            onTap: () {
                                              image.value = null;
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: context.primaryColor,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 20.sp,
                                                color: context.theme.colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                          ))
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                      text: 'Add',
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            image.value != null) {
                          context.read<LessonsBloc>().add(
                                AddLessonEvent(
                                    activity: activityController.text,
                                    description: descriptionController.text,
                                    image: base64Encode(image.value!),
                                    name: titleController.text,
                                    subjectId: widget.lesson.subjectId!,
                                    text: textController.text),
                              );
                        } else if (image.value == null) {
                          Toaster.showToast('Please Add Image First');
                        } else {
                          Toaster.showToast('Please Add Review All Fields');
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

  Future<Uint8List?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowedExtensions: ['png', 'jpg'],
          allowMultiple: false,
          type: FileType.image,
          dialogTitle: 'Select Lesson Image');
      print(result?.count);
      return (await result!.files.first.xFile.readAsBytes());
      // return result.files.first.bytes!;
    } on PlatformException catch (e) {
      print('Unsupported operation$e');
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
