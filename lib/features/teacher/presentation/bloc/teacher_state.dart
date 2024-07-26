part of 'teacher_bloc.dart';

class TeacherState {
  final CubitStatus indexStatus;
  final List<TeacherModel> teachers;

  TeacherState({
    this.indexStatus = CubitStatus.init,
    this.teachers = const [],
  });
  TeacherState copyWith(
      {CubitStatus? indexStatus, List<TeacherModel>? teachers}) {
    return TeacherState(
      indexStatus: indexStatus ?? this.indexStatus,
      teachers: teachers ?? this.teachers,
    );
  }
}
