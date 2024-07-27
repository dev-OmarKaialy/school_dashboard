part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class ToggleBlockUserEvent extends UsersEvent {
  final int id;
  const ToggleBlockUserEvent({
    required this.id,
  });
}

class GetUsersEvent extends UsersEvent {}
