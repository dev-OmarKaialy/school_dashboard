import 'package:bloc/bloc.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/features/subject/data/models/subject_model.dart';
import 'package:school_daashboard/features/subject/data/repositories/subject_repo.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(const SubjectState()) {
    on<GetSubjectsEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await SubjectRepo().getSubject();
      result.fold((l) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(status: CubitStatus.success, subjects: r));
      });
    });
    on<AddSubjectsEvent>((event, emit) async {
      emit(state.copyWith(addStatus: CubitStatus.loading));
      final result = await SubjectRepo()
          .addSubject({'name': event.title, 'description': event.description});
      result.fold((l) {
        emit(state.copyWith(addStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(addStatus: CubitStatus.success));
        add(GetSubjectsEvent());
      });
      emit(state.copyWith(addStatus: CubitStatus.init));
    });
  }
}
