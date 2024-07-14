part of 'section_bloc.dart';

class SectionState {
  final CubitStatus indexStatus;
  final CubitStatus deleteStatus;
  final List<SectionModel> sections;
  SectionState({
    this.indexStatus = CubitStatus.init,
    this.deleteStatus = CubitStatus.init,
    this.sections = const [],
  });

  SectionState copyWith({
    CubitStatus? indexStatus,
    CubitStatus? deleteStatus,
    List<SectionModel>? sections,
  }) {
    return SectionState(
      indexStatus: indexStatus ?? this.indexStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      sections: sections ?? this.sections,
    );
  }
}
