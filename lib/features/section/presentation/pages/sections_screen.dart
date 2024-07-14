import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/widgets/main_button.dart';
import 'package:school_daashboard/features/section/presentation/bloc/section_bloc.dart';
import 'package:school_daashboard/features/section/presentation/widgets/add_section.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/resources/cubit_status.dart';
import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/main_error_widget.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../../../core/widgets/yes_no_dialog.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  void didChangeDependencies() {
    context.read<SectionBloc>().add(IndexSectionsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightThemeColors.linearThirdColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        title: const Text('Sections Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MainButton(
              text: ' Add',
              width: .1.sw,
              onPressed: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (c) {
                      return const AddSectionDialog();
                    });
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: BlocConsumer<SectionBloc, SectionState>(
          listener: (context, state) {
            if (state.deleteStatus == CubitStatus.loading) {
              Toaster.showLoading();
            } else {
              Toaster.closeLoading();
            }
          },
          builder: (context, state) {
            return switch (state.indexStatus) {
              CubitStatus.success => switch (state.sections.length) {
                  0 => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(),
                        Image.asset(
                          'assets/noresults.png',
                        ),
                        Text(
                          'There Is No Types Yet',
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontSize: FontSize.s24),
                        ),
                      ],
                    ),
                  _ => GridView.builder(
                      itemCount: state.sections.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          childAspectRatio: 6,
                          crossAxisCount: context.isPhone
                              ? 1
                              : context.isTablet
                                  ? 2
                                  : 3),
                      itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppRaduis.r19),
                              gradient: const LinearGradient(colors: [
                                LightThemeColors.linearFirstColor,
                                LightThemeColors.linearSecondColor,
                                LightThemeColors.linearThirdColor,
                              ]),
                            ),
                            child: Stack(
                              children: [
                                ListTile(
                                  title: Text(
                                    state.sections[index].name!,
                                    style: context.textTheme.titleLarge,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  child: PopupMenuButton(
                                    iconColor: context.scaffoldBackgroundColor,
                                    color: context.scaffoldBackgroundColor,
                                    icon: Icon(
                                      Icons.more_horiz_outlined,
                                      color: context.primaryColor,
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: const Text('Edit'),
                                          onTap: () {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (c) =>
                                                    AddSectionDialog(
                                                      section:
                                                          state.sections[index],
                                                    ));
                                          },
                                        ),
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: const Text('View'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            showAdaptiveDialog(
                                              context: context,
                                              builder: (context) => YesNoDialog(
                                                  title: 'Are You Sure?',
                                                  onTapYes: () {}),
                                            );
                                          },
                                          child: const Text('Delete'),
                                        )
                                      ];
                                    },
                                  ),
                                )
                              ],
                            ),
                          ))
                },
              CubitStatus.loading => GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isPhone
                          ? 1
                          : context.isTablet
                              ? 2
                              : 3,
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      childAspectRatio: 6),
                  itemBuilder: (context, index) {
                    return ShimmerWidget.rectangular(
                      height: 40,
                      width: 40,
                    );
                  }),
              CubitStatus.failed => MainErrorWidget(
                  onPressed: () {
                    context.read<SectionBloc>().add(IndexSectionsEvent());
                  },
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
