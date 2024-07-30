part of 'programs_bloc.dart';

abstract class ProgramsEvent extends Equatable {
  const ProgramsEvent();

  @override
  List<Object> get props => [];
}

class IndexProgramsEvent extends ProgramsEvent {}

class AttachToLessonEvent extends ProgramsEvent {
  final int programId;
  final int teacherId;
  final int lessonId;
  final String time;
  const AttachToLessonEvent({
    required this.programId,
    required this.teacherId,
    required this.lessonId,
    required this.time,
  });
}
