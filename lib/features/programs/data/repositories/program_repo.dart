import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/features/programs/data/datasources/programs_datasource.dart';
import 'package:school_daashboard/features/programs/data/models/index_programs_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';

class ProgramRepo with HandlingExceptionManager {
  Future<Either<Failure, IndexProgramsModel>> indexPrograms() async {
    return wrapHandling(tryCall: () async {
      return Right(await ProgramsDatasource().indexPrograms());
    });
  }

  Future<Either<Failure, void>> attachToProgram(ParamsMap params) async {
    return wrapHandling(tryCall: () async {
      return Right(await ProgramsDatasource().attachToProgram(params));
    });
  }
}
