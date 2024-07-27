import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/cubit_status.dart';
import 'package:school_daashboard/features/users/data/models/get_users_model.dart';
import 'package:school_daashboard/features/users/data/repositories/user_repo.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<GetUsersEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await UserRepo().getUsers();
      result.fold((l) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (r) {
        emit(
          state.copyWith(status: CubitStatus.success, users: r.data),
        );
      });
    });
    on<ToggleBlockUserEvent>((event, emit) async {
      final user = state.users.firstWhere((e) {
        return e.id == event.id;
      });
      emit(state.copyWith(
          users: List.of(state.users)
            ..[state.users.indexOf(user)] =
                user.copyWith(block: user.block == 1 ? 0 : 1)));

      late final Either<Failure, void> result;
      if (user.block == 1) {
        result = await UserRepo().unblockUsers(event.id);
      } else {
        result = await UserRepo().blockUsers(event.id);
      }
      result.fold((l) {
        emit(state.copyWith(
            users: List.of(state.users)
              ..[state.users.indexOf(user)] =
                  user.copyWith(block: user.block == 1 ? 0 : 1)));
      }, (r) {});
    });
  }
}
