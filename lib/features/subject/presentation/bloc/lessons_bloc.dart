import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/subject/data/repositories/lesson_repo.dart';

import '../../data/models/lessons_model.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  LessonsBloc() : super(LessonsState()) {
    on<AddLocalLessons>((event, emit) {
      emit(state.copyWith(lessons: event.lessons));
    });
    on<DeleteLessonEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await LessonRepo().deleteLesson(event.id);
      result.fold((l) {
        Toaster.showToast(l.message, isError: true);
      }, (r) {
        emit(state.copyWith(
            lessons: List.of(state.lessons)
              ..removeWhere((element) {
                return element.id == event.id;
              })));
      });
      Toaster.closeLoading();
    });
  }
}
