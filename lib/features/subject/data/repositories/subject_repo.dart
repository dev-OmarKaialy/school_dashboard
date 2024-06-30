import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/subject/data/datasources/subjects_datasource.dart';
import 'package:school_daashboard/features/subject/data/models/subject_model.dart';

import '../../../../core/error/failures.dart';

class SubjectRepo with HandlingExceptionManager {
  Future<Either<Failure, SubjectsResponseModel>> getSubject() async {
    return wrapHandling(tryCall: () async {
      return Right(await SubjectDatasource().getSubjects());
    });
  }

  Future<Either<Failure, ShowSubjectsResponseModel>> addSubject(
      BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return Right(await SubjectDatasource().addSubject(body));
    });
  }

  Future<Either<Failure, ShowSubjectsResponseModel>> updateSubject(
      BodyMap body, int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await SubjectDatasource().editSubject(body, id));
    });
  }

  Future<Either<Failure, String>> deleteSubject(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await SubjectDatasource().deleteSubject(id));
    });
  }

  Future<Either<Failure, ShowSubjectsResponseModel>> showSubject(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await SubjectDatasource().showSubject(id));
    });
  }
}
