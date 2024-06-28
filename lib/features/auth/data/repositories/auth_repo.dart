import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/auth/data/datasources/auth_datasource.dart';
import 'package:school_daashboard/features/auth/data/models/login_model.dart';

class AuthRepo with HandlingExceptionManager {
  Future<Either<Failure, LoginModel>> login(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return Right(await AuthDatasource().login(body));
    });
  }
}
