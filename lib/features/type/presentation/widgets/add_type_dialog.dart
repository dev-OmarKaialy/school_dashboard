import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';

import '../../../../core/resources/cubit_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../bloc/type_bloc.dart';

class AddTypeDialog extends StatefulWidget {
  const AddTypeDialog({
    super.key,
  });

  @override
  State<AddTypeDialog> createState() => _AddTypeDialogState();
}

class _AddTypeDialogState extends State<AddTypeDialog> {
  Timer? _timer;
  final x = ValueNotifier(20000);
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TypeBloc, TypeState>(
      listener: (context, state) {
        if (state.addStatus == CubitStatus.loading) {
          Toaster.showLoading();
        } else {
          if (state.addStatus == CubitStatus.success) {
            Navigator.pop(context);
          }
          Toaster.closeLoading();
        }
      },
      child: Dialog(
        child: Container(
          width: context.isPhone
              ? .9.sw
              : context.isTablet
                  ? .7.sw
                  : .5.sw,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('إضافة صف', style: context.textTheme.titleLarge),
              MainTextField(
                text: 'الاسم',
                controller: nameController,
              ),
              20.verticalSpace,
              MainTextField(
                text: 'الوصف',
                controller: descriptionController,
              ),
              20.verticalSpace,
              ValueListenableBuilder(
                  valueListenable: x,
                  builder: (context, value, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('القيمة الكلية'),
                        const Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                                onLongPressStart: (detail) {
                                  if (x.value > 10000) {
                                    _timer = Timer.periodic(Durations.short3,
                                        (time) {
                                      x.value -= 5000;
                                    });
                                  }
                                },
                                onLongPressEnd: (s) {
                                  _timer?.cancel();
                                },
                                onTap: () {
                                  if (x.value > 10000) {
                                    x.value -= 5000;
                                  }
                                },
                                child: const Icon(Icons.arrow_drop_up)),
                            GestureDetector(
                                onLongPressStart: (detail) {
                                  if (x.value < 1000000) {
                                    _timer = Timer.periodic(Durations.short3,
                                        (time) {
                                      x.value += 5000;
                                    });
                                  }
                                },
                                onLongPressEnd: (s) {
                                  _timer?.cancel();
                                },
                                onTap: () {
                                  if (x.value < 1000000) {
                                    x.value += 5000;
                                  }
                                },
                                child: const Icon(Icons.arrow_drop_down)),
                          ],
                        ),
                        ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(
                              scrollbars: false,
                              physics: const NeverScrollableScrollPhysics()),
                          child: NumberPicker(
                            minValue: 10000,
                            maxValue: 1000000,
                            itemHeight: 20,
                            step: 5000,
                            textStyle: context.textTheme.bodySmall
                                ?.copyWith(color: context.theme.highlightColor),
                            selectedTextStyle:
                                context.textTheme.labelLarge?.copyWith(
                              color: context.primaryColor,
                            ),
                            onChanged: (i) {},
                            value: value,
                          ),
                        ),
                      ],
                    );
                  }),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainButton(
                      text: 'إضافة',
                      onPressed: () {
                        context.read<TypeBloc>().add(AddTypeEvent(
                            description: descriptionController.text,
                            name: nameController.text,
                            totalAmount: x.value));
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
}
