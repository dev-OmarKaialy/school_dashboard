import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/features/section/data/repositories/sections_repo.dart';

import '../../data/models/section_model.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  SectionBloc() : super(SectionState()) {
    on<IndexSectionsEvent>((event, emit) async {
      emit(state.copyWith(indexStatus: CubitStatus.loading));
      final result = await SectionsRepo().indexSections();
      result.fold((l) {
        emit(state.copyWith(indexStatus: CubitStatus.failed));
      }, (r) {
        emit(
            state.copyWith(indexStatus: CubitStatus.success, sections: r.data));
      });
    });
    on<DeleteSectionEvent>((event, emit) async {
      emit(state.copyWith(deleteStatus: CubitStatus.loading));
      final result = await SectionsRepo().deleteSections(event.id);
      result.fold((l) {
        emit(state.copyWith(deleteStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            deleteStatus: CubitStatus.success,
            sections: List.of(state.sections)
              ..removeWhere((e) => e.id == event.id)));
      });
    });
    on<AddSectionEvent>((event, emit) async {
      emit(state.copyWith(deleteStatus: CubitStatus.loading));
      final result = await SectionsRepo().addSections(event.body);
      result.fold((l) {
        emit(state.copyWith(deleteStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            deleteStatus: CubitStatus.success,
            sections: List.of(state.sections)..add(r.data!)));
      });
    });
    on<UpdateSectionEvent>((event, emit) async {
      emit(state.copyWith(deleteStatus: CubitStatus.loading));
      final result = await SectionsRepo().updateSections(event.body, event.id);
      result.fold((l) {
        emit(state.copyWith(deleteStatus: CubitStatus.failed));
      }, (r) {
        final object = state
            .sections[state.sections.lastIndexWhere((e) => e.id == event.id)];
        emit(state.copyWith(
            deleteStatus: CubitStatus.success,
            sections: List.of(state.sections)
              ..[state.sections.lastIndexWhere((e) => e.id == event.id)] =
                  SectionModel(
                      createdAt: object.createdAt,
                      description: event.body['description'],
                      name: event.body['name'],
                      id: object.id,
                      updatedAt: DateTime.now())));
      });
    });
  }
}
