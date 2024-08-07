part of 'examps_bloc.dart';

class ExampsState {
  final CubitStatus indexStatus;
  final List<ExamModel> exams;
  const ExampsState({
    this.indexStatus = CubitStatus.init,
    this.exams = const [],
  });

  ExampsState copyWith({
    CubitStatus? indexStatus,
    List<ExamModel>? exams,
  }) {
    return ExampsState(
      indexStatus: indexStatus ?? this.indexStatus,
      exams: exams ?? this.exams,
    );
  }
}
