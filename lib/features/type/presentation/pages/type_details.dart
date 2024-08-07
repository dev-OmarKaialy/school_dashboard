import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/config/extensions/widget_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/core/widgets/main_menu_button.dart';
import 'package:school_daashboard/core/widgets/main_text_field.dart';
import 'package:school_daashboard/features/section/presentation/bloc/section_bloc.dart';
import 'package:school_daashboard/features/type/data/models/index_type_model.dart';
import 'package:school_daashboard/features/type/presentation/bloc/type_bloc.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../teacher/presentation/bloc/teacher_bloc.dart';

class TypeDetails extends StatefulWidget {
  const TypeDetails({
    super.key,
    required this.type,
  });
  final TypeModel type;
  @override
  State<TypeDetails> createState() => _TypeDetailsState();
}

class _TypeDetailsState extends State<TypeDetails> {
  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الصف'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MainButton(
                text: ' إضافة شعبة',
                width: .1.sw,
                onPressed: () {
                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: context.isDesktop
                                  ? .5.sw
                                  : context.isTablet
                                      ? .6.sw
                                      : .8.sw,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('إضافة شعبة جديدة'),
                                  10.verticalSpace,
                                  10.verticalSpace,
                                  BlocBuilder<SectionBloc, SectionState>(
                                    builder: (context, state) {
                                      if (state.indexStatus !=
                                          CubitStatus.success) {
                                        context
                                            .read<SectionBloc>()
                                            .add(IndexSectionsEvent());
                                      }
                                      return DropDownWidget(
                                        onChanged: (index) {
                                          id = index;
                                        },
                                        listenableValue:
                                            ValueNotifier<int?>(null),
                                        items: state.sections
                                            .map((element) => DropdownMenuItem(
                                                  value: element.id!,
                                                  child: Text(
                                                    element.name!,
                                                  ),
                                                ))
                                            .toList(),
                                      );
                                    },
                                  ),
                                  10.verticalSpace,
                                  10.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MainButton(
                                          text: 'إضافة',
                                          onPressed: () {
                                            if (id != null) {
                                              context.read<TypeBloc>().add(
                                                  AssignTypeToSection(
                                                      id: widget.type.id!,
                                                      sid: id!));
                                              Navigator.pop(context);
                                            } else {
                                              Toaster.showToast(
                                                  'الرجاء اختيار قيمة قبل الإكمال');
                                            }
                                          }),
                                      MainButton(
                                          text: 'إلغاء',
                                          color:
                                              context.scaffoldBackgroundColor,
                                          borderColor: context.primaryColor,
                                          textColor: context.primaryColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                },
                icon: const Icon(
                  Icons.add,
                ),
              ))
        ],
      ),
      body: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          ...widget.type.sections!.map((e) {
            return Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    LightThemeColors.linearThirdColor,
                    LightThemeColors.linearSecondColor,
                    LightThemeColors.linearFirstColor,
                  ]),
                  borderRadius: BorderRadius.circular(15)),
              width: context.isPhone
                  ? .9.sw
                  : context.isTablet
                      ? .45.sw
                      : .48.sw,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  expansionTileTheme: const ExpansionTileThemeData(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                  ),
                ),
                child: ExpansionTile(
                    expansionAnimationStyle: AnimationStyle(
                        curve: Curves.easeInCirc, duration: Durations.long2),
                    visualDensity: VisualDensity.comfortable,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(15)),
                    collapsedShape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(15)),
                    title: Text(
                      e.name!,
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontSize: FontSize.s20),
                    ),
                    childrenPadding:
                        const EdgeInsets.only(bottom: 25, right: 25, left: 25),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('الوصف:       ',
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontSize: FontSize.s18)),
                            Expanded(
                              child: Text(e.description!,
                                  style:
                                      context.textTheme.titleLarge?.copyWith()),
                            ),
                          ]),
                      20.verticalSpace,
                      MainButton(
                          text: 'إضافة واجب',
                          onPressed: () {
                            var teacherId = ValueNotifier<int?>(null);
                            var time = TextEditingController();
                            var title = TextEditingController();

                            showAdaptiveDialog(
                                context: context,
                                builder: (c) {
                                  return Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: .7.sw,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('إضافة واجب'),
                                          20.verticalSpace,
                                          MainTextField(
                                            controller: title,
                                            label: 'عنوان الواجب',
                                          ),
                                          20.verticalSpace,
                                          MainTextField(
                                            enabled: false,
                                            label: 'تاريخ التسليم النهائي',
                                            controller: time,
                                          ).onTap(() {
                                            showDatePicker(
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 15)),
                                              initialDate: DateTime.now(),
                                              context: context,
                                            ).then((value) {
                                              if (value != null) {
                                                time.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(value);
                                              }
                                            });
                                          }),
                                          20.verticalSpace,
                                          BlocBuilder<TeacherBloc,
                                              TeacherState>(
                                            builder: (context, state) {
                                              return DropDownWidget(
                                                listenableValue: teacherId,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MainButton(
                                                  text: 'إضافة',
                                                  onPressed: () {
                                                    context
                                                        .read<TypeBloc>()
                                                        .add(AddHomeWorkEvent(
                                                            text: title.text,
                                                            endDate: time.text,
                                                            teacherId: teacherId
                                                                .value!,
                                                            typeSectionId:
                                                                e.pivot?.id ??
                                                                    1));
                                                    Navigator.pop(context);
                                                  }),
                                              20.horizontalSpace,
                                              MainButton(
                                                  text: 'الغاء',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                      20.verticalSpace,
                      MainButton(
                          text: 'إضافة برنامج',
                          onPressed: () {
                            var teacherId = ValueNotifier<int?>(null);
                            var time = TextEditingController();
                            var title = TextEditingController();

                            showAdaptiveDialog(
                                context: context,
                                builder: (c) {
                                  return Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: .7.sw,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text('إضافة برنامج'),
                                          20.verticalSpace,
                                          MainTextField(
                                            controller: title,
                                            label: 'عنوان برنامج',
                                          ),
                                          20.verticalSpace,
                                          MainTextField(
                                            label: 'وصف البرنامج',
                                            controller: time,
                                          ),
                                          20.verticalSpace,
                                          BlocBuilder<TeacherBloc,
                                              TeacherState>(
                                            builder: (context, state) {
                                              return DropDownWidget(
                                                listenableValue: teacherId,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MainButton(
                                                  text: 'إضافة',
                                                  onPressed: () {
                                                    context
                                                        .read<TypeBloc>()
                                                        .add(AddProgramEvent(
                                                            name: title.text,
                                                            description:
                                                                time.text,
                                                            stId: e.pivot?.id ??
                                                                1));
                                                    Navigator.pop(context);
                                                  }),
                                              20.horizontalSpace,
                                              MainButton(
                                                  text: 'الغاء',
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          })
                    ]),
              ),
            );
          })
        ],
      ),
    );
  }
}
