import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/widgets/main_button.dart';
import 'package:school_daashboard/core/widgets/main_error_widget.dart';
import 'package:school_daashboard/features/examps/presentation/bloc/examps_bloc.dart';
import 'package:school_daashboard/features/examps/presentation/widgets/add_exam_dialog.dart';

class ExampsScreen extends StatefulWidget {
  const ExampsScreen({super.key});

  @override
  State<ExampsScreen> createState() => _ExampsScreenState();
}

class _ExampsScreenState extends State<ExampsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExampsBloc>().add(GetExampsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MainButton(
              text: 'اضافة',
              onPressed: () {
                showAdaptiveDialog(
                  context: context,
                  builder: (context) => MyEventDialog(onSubmit: (s) {
                    context.read<ExampsBloc>().add(AddExamEvent(body: s));
                  }),
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<ExampsBloc, ExampsState>(
          builder: (context, state) {
            return switch (state.indexStatus) {
              CubitStatus.success => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3),
                  itemCount: state.exams.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.exams[index].name ?? ''),
                      ),
                    );
                  }),
              CubitStatus.failed => Center(child: MainErrorWidget(
                  onPressed: () {
                    context.read<ExampsBloc>().add(GetExampsEvent());
                  },
                )),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            };
          },
        ),
      ),
    );
  }
}
