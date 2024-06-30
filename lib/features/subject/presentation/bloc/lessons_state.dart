part of 'lessons_bloc.dart';

class LessonsState {
  final CubitStatus addStatus;
  final List<LessonModel> lessons;
  LessonsState({
    this.addStatus = CubitStatus.init,
    this.lessons = const [],
  });

  LessonsState copyWith({
    CubitStatus? addStatus,
    List<LessonModel>? lessons,
  }) {
    return LessonsState(
      addStatus: addStatus ?? this.addStatus,
      lessons: lessons ?? this.lessons,
    );
  }
}
