part of 'teacher_bloc.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}

class IndexTeachersEvent extends TeacherEvent {}

class ShowTeachersEvent extends TeacherEvent {}

class BlockTeachersEvent extends TeacherEvent {
  final int id;
  const BlockTeachersEvent({
    required this.id,
  });
}
