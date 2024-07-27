import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/users/data/datasources/user_datasource.dart';
import 'package:school_daashboard/features/users/data/models/get_users_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/resources/type_defs.dart';

class UserRepo with HandlingExceptionManager {
  Future<Either<Failure, IndexUsersModel>> getUsers() async {
    return wrapHandling(tryCall: () async {
      return Right(await UserDatasource().getUsers());
    });
  }

  Future<Either<Failure, void>> blockUsers(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await UserDatasource().blockUsers(id));
    });
  }

  Future<Either<Failure, void>> unblockUsers(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await UserDatasource().unblockUsers(id));
    });
  }

  Future<Either<Failure, void>> sendNotification(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return Right(await UserDatasource().sendNotification(body));
    });
  }
}
