import 'package:dartz/dartz.dart';
import 'package:school_daashboard/features/teacher/data/datasources/teacher_datasource.dart';
import 'package:school_daashboard/features/teacher/data/models/teacher_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';

class TeacherRepo with HandlingExceptionManager {
  Future<Either<Failure, IndexTeachersModel>> indexTeachers() async {
    return wrapHandling(tryCall: () async {
      return Right(await TeacherDatasource().indexTeachers());
    });
  }

  Future<Either<Failure, void>> blockTeacher(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await TeacherDatasource().blockTeacher(id));
    });
  }

  Future<Either<Failure, void>> unblockTeacher(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await TeacherDatasource().unblockTeacher(id));
    });
  }
}
