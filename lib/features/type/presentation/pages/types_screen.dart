import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/core/widgets/shimmer_widget.dart';
import 'package:school_daashboard/core/widgets/yes_no_dialog.dart';
import 'package:school_daashboard/features/type/presentation/bloc/type_bloc.dart';

import '../../../../core/config/theme/light_theme.dart';
import '../../../../core/resources/dimension_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_error_widget.dart';
import '../widgets/add_type_dialog.dart';
import '../widgets/update_type_dialog.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  @override
  void didChangeDependencies() {
    context.read<TypeBloc>().add(IndexTypesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightThemeColors.linearThirdColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        title: const Text('Types Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MainButton(
              text: ' Add',
              width: .1.sw,
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return const AddTypeDialog();
                  },
                );
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
        child: BlocConsumer<TypeBloc, TypeState>(
          listener: (context, state) {
            if (state.deleteStatus == CubitStatus.loading) {
              Toaster.showLoading();
            } else {
              Toaster.closeLoading();
            }
          },
          builder: (context, state) {
            return switch (state.indexStatus) {
              CubitStatus.success => GridView.builder(
                  itemCount: state.types.length,
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
                          borderRadius: BorderRadius.circular(AppRaduis.r19),
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
                                state.types[index].name!,
                                style: context.textTheme.titleLarge,
                              ),
                              subtitle: Text(
                                'Total Amount: ${state.types[index].totalAmount!}',
                                style: context.textTheme.bodySmall,
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
                                            builder: (context) {
                                              return UpdateTypeDialog(
                                                  type: state.types[index]);
                                            });
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
                                              onTapYes: () {
                                                context.read<TypeBloc>().add(
                                                    DeleteTypeEvent(
                                                        id: state
                                                            .types[index].id!));
                                              }),
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
                      )),
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
                    context.read<TypeBloc>().add(IndexTypesEvent());
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
