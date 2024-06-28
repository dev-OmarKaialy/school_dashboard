import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:school_daashboard/core/utils/toaster.dart';
import 'package:school_daashboard/features/auth/data/models/login_model.dart';
import 'package:school_daashboard/features/auth/data/repositories/auth_repo.dart';

import '../../../../core/resources/cubit_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await AuthRepo().login(
        {
          'email': event.email,
          'password': event.password,
        },
      );
      result.fold(
        (l) {
          emit(state.copyWith(status: CubitStatus.failed));
          Toaster.showNotification(
            leading: (p0) {
              return const Icon(
                Icons.warning_amber,
                color: Colors.red,
              );
            },
            title: (p0) {
              return Text(l.message);
            },
          );
        },
        (r) {
          emit(state.copyWith(status: CubitStatus.success, user: r));
        },
      );
    });
  }
}
