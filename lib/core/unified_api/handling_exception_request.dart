import 'dart:convert';

import 'package:http/http.dart';

import '../error/exceptions.dart';

mixin HandlingExceptionRequest {
  Exception getException({required Response response}) {
    final String message = json.decode(response.body)['message'].toString();

    if (response.statusCode == 401) return UnauthenticatedException(message);
    if (response.statusCode == 422) return ValidationException(message);
    if (response.statusCode == 402) return ParentCodeException(message);
    if (response.statusCode == 413) return EmailUsedException();
    if (response.statusCode == 414) return OldPasswordWrongException();
    if (response.statusCode == 200) return PasswordOrUsernameWrongException();
    if (response.statusCode == 416) return CodeWrongException();
    if (response.statusCode == 415) return PhoneNumberUsedException(message);
    if (response.statusCode == 418) return PhoneNumberNotVerifyException();
    if (response.statusCode == 419) return NoPhoneNumberException();
    // if (response.statusCode == 420) return UserBlockedException();
    if (response.statusCode == 420) return UserHasOrderBeforeException();

    return ServerException(message);
  }
}
