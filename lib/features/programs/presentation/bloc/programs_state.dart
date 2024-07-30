part of 'programs_bloc.dart';

class ProgramsState {
  final CubitStatus indexStatus;
  final List<ProgramModel> programs;
  const ProgramsState({
    this.indexStatus = CubitStatus.init,
    this.programs = const [],
  });

  ProgramsState copyWith({
    CubitStatus? indexStatus,
    List<ProgramModel>? programs,
  }) {
    return ProgramsState(
      indexStatus: indexStatus ?? this.indexStatus,
      programs: programs ?? this.programs,
    );
  }
}
