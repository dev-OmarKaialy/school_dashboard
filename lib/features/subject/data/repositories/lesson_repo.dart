import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/subject/data/datasources/lessons_datasource.dart';
import 'package:school_daashboard/features/subject/data/models/lessons_model.dart';

class LessonRepo with HandlingExceptionManager {
  Future<Either<Failure, IndexLessonsResponseModel>> indexLessons() async {
    return wrapHandling(tryCall: () async {
      final result = await LessonsDatasource().getLessons();
      return Right(result);
    });
  }

  Future<Either<Failure, ShowLessonsResponseModel>> storeLessons(
      BodyMap body) async {
    return wrapHandling(tryCall: () async {
      final result = await LessonsDatasource().storeLesson(body);
      return Right(result);
    });
  }

  Future<Either<Failure, ShowLessonsResponseModel>> updateLessons(
      int id, BodyMap body) async {
    return wrapHandling(tryCall: () async {
      final result = await LessonsDatasource().updateLesson(id, body);
      return Right(result);
    });
  }

  Future<Either<Failure, String>> deleteLesson(int id) async {
    return wrapHandling(tryCall: () async {
      final result = await LessonsDatasource().deleteLesson(id);
      return Right(result);
    });
  }
}
