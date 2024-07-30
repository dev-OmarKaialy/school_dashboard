import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/type/data/datasources/type_datasource.dart';
import 'package:school_daashboard/features/type/data/models/index_type_model.dart';

class TypeRepoImpl with HandlingExceptionManager {
  Future<Either<Failure, IndexTypesResponseModel>> getTypes() async {
    return await wrapHandling(tryCall: () async {
      return Right(await TypeDatasource().indexTypes());
    });
  }

  Future<Either<Failure, ShowTypesResponseModel>> addType(BodyMap body) async {
    return await wrapHandling(tryCall: () async {
      return Right(await TypeDatasource().addType(body));
    });
  }

  Future<Either<Failure, void>> deleteType(int id) async {
    return await wrapHandling(tryCall: () async {
      return Right(await TypeDatasource().deleteType(id));
    });
  }

  Future<Either<Failure, ShowTypesResponseModel>> updateType(
      BodyMap body) async {
    return await wrapHandling(tryCall: () async {
      return Right(await TypeDatasource().updateType(body));
    });
  }

  Future<Either<Failure, ShowTypesResponseModel>> assignTypesToSection(
      int id, int sid) async {
    return wrapHandling(tryCall: () async {
      return Right(await TypeDatasource().assignTypeToSection(id, sid));
    });
  }
}
