import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_daashboard/core/config/extensions/widget_extensions.dart';
import 'package:school_daashboard/core/config/theme/light_theme.dart';
import 'package:school_daashboard/core/widgets/main_error_widget.dart';
import 'package:school_daashboard/features/programs/presentation/widgets/attach_to_lesson.dart';
import 'package:school_daashboard/features/programs/presentation/widgets/program_details.dart';

import '../../../../core/resources/cubit_status.dart';
import '../bloc/programs_bloc.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  void initState() {
    context.read<ProgramsBloc>().add(IndexProgramsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('البرامج'),
      ),
      body: BlocBuilder<ProgramsBloc, ProgramsState>(
        builder: (context, state) {
          return state.indexStatus == CubitStatus.failed
              ? Center(
                  child: MainErrorWidget(onPressed: () {
                    context.read<ProgramsBloc>().add(IndexProgramsEvent());
                  }),
                )
              : state.indexStatus == CubitStatus.success
                  ? state.programs.isEmpty
                      ? const Center(
                          child: Text('لا يوجد هناك أي برامج بعد!'),
                        )
                      : GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, childAspectRatio: 1.5),
                          children: [
                            for (int i = 0; i < state.programs.length; i++)
                              Card(
                                color: LightThemeColors.linearSecondColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          PopupMenuButton(
                                              icon: const Icon(
                                                  Icons.more_horiz_rounded),
                                              itemBuilder: (c) {
                                                return [
                                                  PopupMenuItem(
                                                    child: const Text(
                                                        'إضافة دروس'),
                                                    onTap: () {
                                                      showAdaptiveDialog(
                                                          context: context,
                                                          builder: (c) =>
                                                              AttachToLesson(
                                                                id: state
                                                                    .programs[i]
                                                                    .id!,
                                                              ));
                                                    },
                                                  ),
                                                ];
                                              })
                                        ],
                                      ),
                                      Text(
                                          'اسم البرنامج: ${state.programs[i].name!}'),
                                      Text(
                                          'وصف البرنامج: ${state.programs[i].description!}'),
                                    ],
                                  ),
                                ),
                              ).onTap(() {
                                showAdaptiveDialog(
                                    context: context,
                                    builder: (context) {
                                      return ProgramDetails(
                                          program: state.programs[i]);
                                    });
                              })
                          ],
                        )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
        },
      ),
    );
  }
}
