import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/programs/data/repositories/program_repo.dart';

import '../../data/models/index_programs_datasource.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  ProgramsBloc() : super(const ProgramsState()) {
    on<AttachToLessonEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await ProgramRepo().attachToProgram({
        'teacher_id': event.teacherId.toString(),
        'lesson_id': event.lessonId.toString(),
        'program_id': event.programId.toString(),
      });
      result.fold((l) {
        Toaster.showToast(l.message);
      }, (r) {});
      Toaster.closeLoading();
    });
    on<IndexProgramsEvent>((event, emit) async {
      emit(state.copyWith(indexStatus: CubitStatus.loading));
      final result = await ProgramRepo().indexPrograms();

      result.fold((l) {
        emit(state.copyWith(indexStatus: CubitStatus.failed));
      }, (r) {
        emit(
            state.copyWith(indexStatus: CubitStatus.success, programs: r.data));
      });
    });
  }
}
