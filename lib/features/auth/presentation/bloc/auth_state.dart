part of 'auth_bloc.dart';

class AuthState {
  final CubitStatus status;
  final LoginModel? user;
  AuthState({
    this.status = CubitStatus.init,
    this.user,
  });

  AuthState copyWith({
    CubitStatus? status,
    LoginModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
