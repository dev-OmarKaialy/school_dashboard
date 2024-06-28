import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<Right<Failure, T>> Function() tryCall,
    Future<T?> Function()? tryCallLocal,
  }) async {
    try {
      final right = await tryCall();
      return (right);
    } on UnauthenticatedException catch (e) {
      log("<<UnauthenticatedException>>");
      return Left(UnauthenticatedFailure(e.message));
    } on ValidationException catch (e) {
      log("<<validateRegister>>");
      return Left(ValidationFailure(e.message));
    } on ParentCodeException catch (e) {
      return Left(ParentCodeFailure(e.message));
    } on PhoneNumberUsedException catch (e) {
      return Left(PhoneNumberUsedFailure(e.message));
    } on UserHasOrderBeforeException catch (e) {
      log("<<UnauthenticatedException>>");
      return Left(UserHasOrderBeforeFailure(e.toString()));
    } on ServerException catch (e) {
      log("<< ServerException >> ");
      if (tryCallLocal != null) {
        final result = await tryCallLocal();
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure(e.message));
        }
      } else {
        return Left(ServerFailure(e.message));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
