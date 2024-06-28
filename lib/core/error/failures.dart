import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ParentCodeFailure extends Failure {
  const ParentCodeFailure(super.message);
}

class EmailUsedFailure extends Failure {
  const EmailUsedFailure(super.message);
}

class PhoneNumberUsedFailure extends Failure {
  const PhoneNumberUsedFailure(super.message);
}

class OldPasswordWrongFailure extends Failure {
  const OldPasswordWrongFailure(super.message);
}

class PasswordOrUsernameFailure extends Failure {
  const PasswordOrUsernameFailure(super.message);
}

class CodeWrongFailure extends Failure {
  const CodeWrongFailure(super.message);
}

class NoPhoneNumberFailure extends Failure {
  const NoPhoneNumberFailure(super.message);
}

class PhoneNumberNotVerifyFailure extends Failure {
  const PhoneNumberNotVerifyFailure(super.message);
}

class UserBlockedFailure extends Failure {
  const UserBlockedFailure(super.message);
}

class UserHasOrderBeforeFailure extends Failure {
  const UserHasOrderBeforeFailure(super.message);
}
