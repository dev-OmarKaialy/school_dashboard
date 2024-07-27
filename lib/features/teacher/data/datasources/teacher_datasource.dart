import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';

import '../models/teacher_model.dart';

class TeacherDatasource {
  Future<IndexTeachersModel> indexTeachers() async {
    final getApi = GetApi(
        uri: ApiVariables().teacher(), fromJson: indexTeachersModelFromJson);
    return await getApi.callRequest();
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
