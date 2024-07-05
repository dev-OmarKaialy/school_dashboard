part of 'type_bloc.dart';

class TypeState {
  final CubitStatus indexStatus;
  final CubitStatus addStatus;
  final CubitStatus deleteStatus;
  final List<TypeModel> types;
  TypeState({
    this.indexStatus = CubitStatus.init,
    this.addStatus = CubitStatus.init,
    this.deleteStatus = CubitStatus.init,
    this.types = const [],
  });

  TypeState copyWith({
    CubitStatus? indexStatus,
    CubitStatus? addStatus,
    CubitStatus? deleteStatus,
    List<TypeModel>? types,
  }) {
    return TypeState(
      indexStatus: indexStatus ?? this.indexStatus,
      addStatus: addStatus ?? this.addStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      types: types ?? this.types,
    );
  }
}
