import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/delete_api.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/features/subject/data/models/lessons_model.dart';

class LessonsDatasource {
  Future<String> deleteLesson(int id) async {
    final deleteApi = DeleteApi(
      uri: ApiVariables().deleteLessons(id),
      fromJson: (body) {
        return 'success';
      },
    );
    return await deleteApi.callRequest();
  }

  Future<IndexLessonsResponseModel> getLessons() async {
    final getApi = GetApi(
        uri: ApiVariables().lessons(),
        fromJson: indexLessonsResponseModelFromJson);
    return await getApi.callRequest();
  }
}
