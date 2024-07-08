import 'package:bloc/bloc.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
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
        emit(state.copyWith(status: CubitStatus.success, subjects: r.data));
      });
    });
    on<AddSubjectsEvent>((event, emit) async {
      emit(state.copyWith(addStatus: CubitStatus.loading));
      final result = await SubjectRepo().addSubject(
        {
          'name': event.title,
          'description': event.description,
        },
      );
      result.fold((l) {
        emit(state.copyWith(addStatus: CubitStatus.failed));
      }, (r) {
        emit(
          state.copyWith(
            addStatus: CubitStatus.success,
            subjects: List.of(state.subjects)..add(r.data!),
          ),
        );
      });
    });

    on<DeleteSubjectEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await SubjectRepo().deleteSubject(event.id);
      result.fold((l) {
        Toaster.showToast(l.message);
      }, (r) {
        emit(
          state.copyWith(
            subjects: List.of(state.subjects)
              ..removeWhere(
                (element) {
                  return element.id == event.id;
                },
              ),
          ),
        );
      });
      Toaster.closeLoading();
    });

    on<ShowSubjectEvent>((event, emit) async {
      emit(state.copyWith(showStatus: CubitStatus.loading));
      final result = await SubjectRepo().showSubject(event.id);
      result.fold((l) {
        emit(state.copyWith(showStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(showStatus: CubitStatus.success, subject: r.data));
      });
    });
    on<UpdateSubjectsEvent>((event, emit) async {
      emit(state.copyWith(addStatus: CubitStatus.loading));
      final result = await SubjectRepo().updateSubject({
        'name': event.title,
        'description': event.description,
      }, event.id);
      result.fold((l) {
        emit(state.copyWith(addStatus: CubitStatus.failed));
      }, (r) {
        emit(
          state.copyWith(
            addStatus: CubitStatus.success,
            subjects: List.of(state.subjects)
              ..[state.subjects.lastIndexWhere(
                (element) {
                  return element.id == event.id;
                },
              )] = r.data!,
          ),
        );
      });
      emit(state.copyWith(addStatus: CubitStatus.init));
    });
  }
}
