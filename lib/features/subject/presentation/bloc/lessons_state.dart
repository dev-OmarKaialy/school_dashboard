part of 'lessons_bloc.dart';

class LessonsState {
  final CubitStatus addStatus;
  final List<LessonModel> lessons;
  final List<LessonModel> tlessons;
  LessonsState({
    this.addStatus = CubitStatus.init,
    this.lessons = const [],
    this.tlessons = const [],
  });

  LessonsState copyWith({
    CubitStatus? addStatus,
    List<LessonModel>? lessons,
    List<LessonModel>? tlessons,
  }) {
    return LessonsState(
      addStatus: addStatus ?? this.addStatus,
      lessons: lessons ?? this.lessons,
      tlessons: tlessons ?? this.tlessons,
    );
  }
}
