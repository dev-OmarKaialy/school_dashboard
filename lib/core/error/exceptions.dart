class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class UnauthenticatedException implements Exception {
  final String message;
  UnauthenticatedException(this.message);
}

class EmailUsedException implements Exception {}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class ParentCodeException implements Exception {
  final String message;

  ParentCodeException(this.message);
}

class PhoneNumberUsedException implements Exception {
  final String message;
  PhoneNumberUsedException(this.message);
}

class OldPasswordWrongException implements Exception {}

class PasswordOrUsernameWrongException implements Exception {}

class CodeWrongException implements Exception {}

class NoPhoneNumberException implements Exception {}

class PhoneNumberNotVerifyException implements Exception {}

class UserBlockedException implements Exception {}

class UserHasOrderBeforeException implements Exception {}
