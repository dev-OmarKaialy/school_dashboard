import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';

import '../../../../core/resources/type_defs.dart';
import '../models/subject_model.dart';

class SubjectDatasource {
  Future<List<SubjectResponseModel>> getSubjects() async {
    final getApi = GetApi(
        uri: ApiVariables().subjects(), fromJson: subjectResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<String> addSubject(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().addsubjects(),
        body: body,
        fromJson: (str) {
          return 'Done';
        });
    return await postApi.callRequest();
  }
}
