part of 'users_bloc.dart';

class UsersState {
  final CubitStatus status;
  final List<UserModel> users;
  const UsersState({
    this.status = CubitStatus.init,
    this.users = const [],
  });

  UsersState copyWith({
    CubitStatus? status,
    List<UserModel>? users,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
