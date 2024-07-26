import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/features/teacher/data/repositories/teacher_repo.dart';

import '../../data/models/teacher_model.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(TeacherState()) {
    on<IndexTeachersEvent>((event, emit) async {
      emit(state.copyWith(indexStatus: CubitStatus.loading));
      final result = await TeacherRepo().indexTeachers();
      result.fold((l) {
        emit(
          state.copyWith(indexStatus: CubitStatus.failed),
        );
      }, (r) {
        emit(
          state.copyWith(indexStatus: CubitStatus.success, teachers: r.data),
        );
      });
    });
    on<BlockTeachersEvent>(
      (event, emit) async {
        emit(state.copyWith(
            teachers: List.of(state.teachers)
              ..[state.teachers.indexWhere((e) => e.id == event.id)] =
                  state.teachers.firstWhere(((e) => e.id == event.id)).copyWith(
                      block: state.teachers
                                  .firstWhere(((e) => e.id == event.id))
                                  .block ==
                              0
                          ? 1
                          : 0)));

        late final Either<Failure, void> result;

        if (state.teachers.firstWhere(((e) => e.id == event.id)).block == 0) {
          result = await TeacherRepo().unblockTeacher(event.id);
        } else {
          result = await TeacherRepo().blockTeacher(event.id);
        }
        result.fold((l) {
          emit(state.copyWith(
              teachers: List.of(state.teachers)
                ..[state.teachers.indexWhere((e) => e.id == event.id)] = state
                    .teachers
                    .firstWhere(((e) => e.id == event.id))
                    .copyWith(
                        block: state.teachers
                                    .firstWhere(((e) => e.id == event.id))
                                    .block ==
                                0
                            ? 1
                            : 0)));
        }, (r) {});
      },
      transformer: (events, mapper) {
        return events.transform(_ExhaustMapStreamTransformer(mapper));
      },
    );
  }
}

class _ExhaustMapStreamTransformer<T> extends StreamTransformerBase<T, T> {
  _ExhaustMapStreamTransformer(this.mapper);

  final EventMapper<T> mapper;

  @override
  Stream<T> bind(Stream<T> stream) {
    late StreamSubscription<T> subscription;
    StreamSubscription<T>? mappedSubscription;

    final controller = StreamController<T>(
      onCancel: () async {
        await mappedSubscription?.cancel();
        return subscription.cancel();
      },
      sync: true,
    );

    subscription = stream.listen(
      (data) {
        if (mappedSubscription != null) return;
        final Stream<T> mappedStream;

        mappedStream = mapper(data);
        mappedSubscription = mappedStream.listen(
          controller.add,
          onError: controller.addError,
          onDone: () => mappedSubscription = null,
        );
      },
      onError: controller.addError,
      onDone: () => mappedSubscription ?? controller.close(),
    );

    return controller.stream;
  }
}
