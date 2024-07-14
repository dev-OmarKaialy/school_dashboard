import 'package:dartz/dartz.dart';
import 'package:school_daashboard/core/error/failures.dart';
import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/handling_exception_manager.dart';
import 'package:school_daashboard/features/section/data/datasources/section_datasource.dart';
import 'package:school_daashboard/features/section/data/models/section_model.dart';

class SectionsRepo with HandlingExceptionManager {
  Future<Either<Failure, IndexSectionModel>> indexSections() async {
    return wrapHandling(tryCall: () async {
      return Right(await SectionDatasource().indexSections());
    });
  }

  Future<Either<Failure, void>> deleteSections(int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await SectionDatasource().deleteSections(id));
    });
  }

  Future<Either<Failure, ShowSectionModel>> addSections(BodyMap body) async {
    return wrapHandling(tryCall: () async {
      return Right(await SectionDatasource().addSections(body));
    });
  }

  Future<Either<Failure, void>> updateSections(BodyMap body, int id) async {
    return wrapHandling(tryCall: () async {
      return Right(await SectionDatasource().updateSections(body, id));
    });
  }
}
