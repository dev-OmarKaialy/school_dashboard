part of 'lessons_bloc.dart';

@immutable
abstract class LessonsEvent {}

class AddLocalLessons extends LessonsEvent {
  final List<LessonModel> lessons;
  AddLocalLessons({
    required this.lessons,
  });
}

class AddLessonEvent extends LessonsEvent {
  final String name;
  final String activity;
  final String text;
  final String description;
  final String image;
  final int subjectId;
  AddLessonEvent({
    required this.name,
    required this.activity,
    required this.text,
    required this.description,
    required this.image,
    required this.subjectId,
  });
}

class DeleteLessonEvent extends LessonsEvent {
  final int id;
  DeleteLessonEvent({
    required this.id,
  });
}

class UpdateLessonEvent extends LessonsEvent {}
