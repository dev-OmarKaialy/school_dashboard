part of 'subject_bloc.dart';

class SubjectState {
  final CubitStatus status;
  final CubitStatus addStatus;
  final CubitStatus showStatus;
  final List<SubjectModel> subjects;
  final SubjectModel? subject;
  const SubjectState({
    this.status = CubitStatus.init,
    this.showStatus = CubitStatus.init,
    this.subject,
    this.addStatus = CubitStatus.init,
    this.subjects = const [],
  });

  SubjectState copyWith({
    CubitStatus? status,
    CubitStatus? addStatus,
    CubitStatus? showStatus,
    List<SubjectModel>? subjects,
    SubjectModel? subject,
  }) {
    return SubjectState(
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      showStatus: showStatus ?? this.showStatus,
      subjects: subjects ?? this.subjects,
      subject: subject ?? this.subject,
    );
  }
}
