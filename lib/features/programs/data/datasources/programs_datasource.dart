import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/features/programs/data/models/index_programs_datasource.dart';

class ProgramsDatasource {
  Future<IndexProgramsModel> indexPrograms() async {
    final getApi = GetApi(
        uri: ApiVariables().program(), fromJson: indexProgramsModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> attachToProgram(ParamsMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().attachprogram(body), body: {}, fromJson: (str) {});
    return await postApi.callRequest();
  }
}
