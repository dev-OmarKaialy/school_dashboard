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
  final String description;
  final String image;
  final String file;
  final String video;
  final int subjectId;
  AddLessonEvent({
    required this.name,
    required this.file,
    required this.video,
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

class IndexLessonsEvent extends LessonsEvent {}
