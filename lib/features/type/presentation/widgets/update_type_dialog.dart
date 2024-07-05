import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/features/type/data/models/index_type_model.dart';

import '../../../../core/resources/cubit_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/main_button.dart';
import '../bloc/type_bloc.dart';

class UpdateTypeDialog extends StatefulWidget {
  const UpdateTypeDialog({
    super.key,
    required this.type,
  });
  final TypeModel type;

  @override
  State<UpdateTypeDialog> createState() => _UpdateTypeDialogState();
}

class _UpdateTypeDialogState extends State<UpdateTypeDialog> {
  final x = ValueNotifier(20);
  Timer? _timer;
  @override
  void didChangeDependencies() {
    x.value = int.parse(widget.type.totalAmount!) + 10000;
    super.didChangeDependencies();
  }

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
              Text(
                'Update ${widget.type.name!}',
                style: context.textTheme.titleLarge,
              ),
              20.verticalSpace,
              ValueListenableBuilder(
                  valueListenable: x,
                  builder: (context, value, _) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Toatl Amount'),
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
                      text: 'Update',
                      onPressed: () {
                        context.read<TypeBloc>().add(
                              UpdateTypeEvent(
                                  totalAmount: x.value, id: widget.type.id!),
                            );
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
