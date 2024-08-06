import 'package:bloc/bloc.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/type/data/repositories/type_repo_impl.dart';

import '../../data/models/index_type_model.dart';

part 'type_event.dart';
part 'type_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  TypeBloc() : super(TypeState()) {
    on<IndexTypesEvent>((event, emit) async {
      emit(state.copyWith(indexStatus: CubitStatus.loading));
      final result = await TypeRepoImpl().getTypes();
      result.fold(
        (l) => emit(state.copyWith(indexStatus: CubitStatus.failed)),
        (r) => emit(
          state.copyWith(indexStatus: CubitStatus.success, types: r.data),
        ),
      );
    });
    on<AddTypeEvent>((event, emit) async {
      emit(state.copyWith(addStatus: CubitStatus.loading));
      final result = await TypeRepoImpl().addType({
        'name': event.name,
        'description': event.description,
        'total_amount': event.totalAmount,
      });
      result.fold((l) {
        Toaster.showToast(l.message, isError: true);
        emit(state.copyWith(addStatus: CubitStatus.failed));
      }, (r) {
        emit(
          state.copyWith(
            addStatus: CubitStatus.success,
            types: List.of(state.types)..add(r.data!),
          ),
        );
      });
    });
    on<DeleteTypeEvent>((event, emit) async {
      emit(state.copyWith(deleteStatus: CubitStatus.loading));
      final result = await TypeRepoImpl().deleteType(event.id);
      result.fold((l) {
        Toaster.showToast(l.message, isError: true);
        emit(state.copyWith(deleteStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            deleteStatus: CubitStatus.success,
            types: List.of(state.types)
              ..removeWhere((e) {
                return e.id == event.id;
              })));
      });
    });
    on<UpdateTypeEvent>((event, emit) async {
      emit(state.copyWith(addStatus: CubitStatus.loading));
      final result = await TypeRepoImpl()
          .updateType({'total_amount': event.totalAmount, 'id': event.id});
      result.fold((l) {
        Toaster.showToast(l.message, isError: true);
        emit(state.copyWith(addStatus: CubitStatus.failed));
      }, (r) {
        emit(state.copyWith(
            addStatus: CubitStatus.success,
            types: List.of(state.types)
              ..[state.types.lastIndexWhere((e) => e.id == event.id)] =
                  r.data!));
      });
    });
    on<AssignTypeToSection>((event, emit) async {
      Toaster.showLoading();
      final result =
          await TypeRepoImpl().assignTypesToSection(event.id, event.sid);
      result.fold((l) {
        Toaster.showToast(l.message, isError: true);
      }, (r) {
        emit(state.copyWith(
            types: List.of(state.types)
              ..[state.types.lastIndexWhere((e) => e.id == event.id)] =
                  r.data!));
      });
      Toaster.closeLoading();
    });
    on<AddHomeWorkEvent>((event, emit) async {
      Toaster.showLoading();
      final result = await TypeRepoImpl().addHomeWork(event.toMap());
      result.fold((left) {
        Toaster.showToast(left.message);
      }, (right) {
        Toaster.showToast('تمت الإضافة بنجاح');
      });
      Toaster.closeLoading();
    });
  }
}
