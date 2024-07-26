import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';

import '../models/teacher_model.dart';

class TeacherDatasource {
  Future<IndexTeachersModel> indexTeachers() async {
    final getApi = GetApi(
        uri: ApiVariables().teacher(), fromJson: indexTeachersModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowTeachersModel> addTeacher(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().addTeacher(),
        body: body,
        fromJson: showTeachersModelFromJson);
    return await postApi.callRequest();
  }

  Future<ShowTeachersModel> updateTeacher(BodyMap body, int id) async {
    final postApi = PostApi(
        uri: ApiVariables().updateTeacher(id),
        body: body,
        fromJson: showTeachersModelFromJson);
    return await postApi.callRequest();
  }

  Future<void> blockTeacher(int id) async {
    final getApi =
        GetApi(uri: ApiVariables().blockTeacher(id), fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<void> unblockTeacher(int id) async {
    final getApi =
        GetApi(uri: ApiVariables().unblockTeacher(id), fromJson: (s) {});
    return await getApi.callRequest();
  }
}
