import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/config/extensions/widget_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/core/widgets/main_menu_button.dart';
import 'package:school_daashboard/features/subject/presentation/bloc/lessons_bloc.dart';

import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../bloc/subject_bloc.dart';

class AddLessonDialog extends StatefulWidget {
  const AddLessonDialog({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<AddLessonDialog> createState() => _AddLessonDialogState();
}

class _AddLessonDialogState extends State<AddLessonDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final activityController = TextEditingController();
  final textController = TextEditingController();
  final fileController = TextEditingController();
  final videoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<Uint8List?> image = ValueNotifier(null);
  ValueNotifier<Uint8List?> file = ValueNotifier(null);
  ValueNotifier<Uint8List?> video = ValueNotifier(null);
  var valueNotifier = ValueNotifier<int?>(null);

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
                'إضافة درس جديد',
                style: context.textTheme.titleLarge
                    ?.copyWith(fontSize: FontSize.s22),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MainTextField(
                      controller: titleController,
                      text: 'العنوان:',
                      hint: 'أدخل العنوان',
                      validator: (value) {
                        if (value != null &&
                            value.length > 4 &&
                            value.contains(
                                RegExp(r'[\u0621-\u064A\u0660-\u0669]'))) {
                          return null;
                        } else {
                          return 'أدخل عنوان درس مقبول';
                        }
                      },
                    ),
                    30.verticalSpace,
                    MainTextField(
                      controller: descriptionController,
                      text: 'الوصف:',
                      hint: 'أدخل وصف الدرس',
                      maxLines: 4,
                      validator: (value) {
                        if (value != null &&
                            value.length > 12 &&
                            value.contains(
                                RegExp(r'[\u0621-\u064A\u0660-\u0669]'))) {
                          return null;
                        } else {
                          return 'أدخل وصفا مناسبا للدرس';
                        }
                      },
                    ),
                    30.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: BlocBuilder<SubjectBloc, SubjectState>(
                                builder: (context, state) {
                                  return DropDownWidget(
                                    listenableValue: valueNotifier,
                                    items: state.subjects.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name!),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            20.horizontalSpace,
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'صورة الدرس:',
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
                                                  final result = await pickFile(
                                                      ['png', 'jpg'],
                                                      FileType.image);
                                                  print(result);
                                                  image.value = result;
                                                },
                                                child: Container(
                                                  width: 150.sp,
                                                  height: 150.sp,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Center(
                                                    child: value != null
                                                        ? Image.memory(value)
                                                        : const Icon(
                                                            Icons.image),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: context
                                                              .primaryColor,
                                                        ),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 20.sp,
                                                          color: context
                                                              .theme
                                                              .colorScheme
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
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MainTextField(
                                controller: fileController,
                                enabled: false,
                                hint: 'Select File',
                                prefixIcon: const Icon(Icons.clear).onTap(() {
                                  file.value = null;
                                  fileController.text = '';
                                }),
                              ).onTap(() async {
                                final result =
                                    await pickFile(['pdf'], FileType.custom);
                                if (result != null) {
                                  file.value = result;
                                  fileController.text = 'Selected';
                                }
                              }),
                            ),
                            Expanded(
                              child: MainTextField(
                                controller: videoController,
                                enabled: false,
                                hint: 'Select Video',
                                prefixIcon: const Icon(Icons.clear).onTap(() {
                                  video.value = null;
                                  videoController.text = '';
                                }),
                              ).onTap(() async {
                                final result = await pickFile(
                                    ['mp4', '3gp'], FileType.video);
                                if (result != null) {
                                  video.value = result;
                                  videoController.text = 'Selected';
                                }
                              }),
                            ),
                          ],
                        )
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
                      text: 'إضافة',
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            image.value != null) {
                          context.read<LessonsBloc>().add(
                                AddLessonEvent(
                                  description: descriptionController.text,
                                  image: base64Encode(image.value!),
                                  video: base64Encode(video.value!),
                                  file: base64Encode(file.value!),
                                  name: titleController.text,
                                  subjectId: widget.id,
                                ),
                              );
                        } else if (image.value == null ||
                            valueNotifier.value == null) {
                          if (image.value == null) {
                            Toaster.showToast('الرجاء اختيار صورة أولاً');
                          } else if (valueNotifier.value == null) {
                            Toaster.showToast('الرجاء اختيار الصف أولاً');
                          }
                        } else {
                          Toaster.showToast('الرجاء التحقق من جميع الحقول');
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
    );
  }

  Future<Uint8List?> pickFile(List<String> types, FileType fileType) async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowedExtensions: types,
          allowMultiple: false,
          type: fileType,
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
