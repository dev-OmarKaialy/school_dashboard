part of 'lessons_bloc.dart';

@immutable
abstract class LessonsEvent {}

class AddLocalLessons extends LessonsEvent {
  final List<LessonModel> lessons;
  AddLocalLessons({
    required this.lessons,
  });
}

class AddLessonEvent extends LessonsEvent {}

class DeleteLessonEvent extends LessonsEvent {
  final int id;
  DeleteLessonEvent({
    required this.id,
  });
}

class UpdateLessonEvent extends LessonsEvent {}
