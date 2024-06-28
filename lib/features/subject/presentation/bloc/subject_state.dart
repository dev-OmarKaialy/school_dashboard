part of 'subject_bloc.dart';

class SubjectState {
  final CubitStatus status;
  final CubitStatus addStatus;
  final List<SubjectResponseModel> subjects;
  const SubjectState({
    this.status = CubitStatus.init,
    this.addStatus = CubitStatus.init,
    this.subjects = const [],
  });

  SubjectState copyWith({
    CubitStatus? status,
    CubitStatus? addStatus,
    List<SubjectResponseModel>? subjects,
  }) {
    return SubjectState(
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      subjects: subjects ?? this.subjects,
    );
  }
}
