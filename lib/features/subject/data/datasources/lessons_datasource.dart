import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/features/subject/data/models/lessons_model.dart';

class LessonsDatasource {
  Future<String> deleteLesson(int id) async {
    final deleteApi = PostApi(
      uri: ApiVariables().deleteLessons(id),
      body: {},
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

  Future<ShowLessonsResponseModel> storeLesson(BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().addLessons(),
        body: body,
        fromJson: showLessonsResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowLessonsResponseModel> updateLesson(int id, BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().updateLessons(id),
        body: body,
        fromJson: showLessonsResponseModelFromJson);
    return await getApi.callRequest();
  }
}
