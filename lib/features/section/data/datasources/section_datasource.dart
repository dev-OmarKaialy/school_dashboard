import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';

import '../../../../core/unified_api/get_api.dart';
import '../models/section_model.dart';

class SectionDatasource {
  Future<IndexSectionModel> indexSections() async {
    final getApi = GetApi(
        uri: ApiVariables().section(), fromJson: indexSectionModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowSectionModel> addSections(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().addSection(),
        body: body,
        fromJson: showSectionModelFromJson);
    return await postApi.callRequest();
  }

  Future<void> updateSections(BodyMap body, int id) async {
    final postApi = PostApi(
        uri: ApiVariables().updateSection(id), body: body, fromJson: (s) {});
    return await postApi.callRequest();
  }

  Future<void> deleteSections(int id) async {
    final postApi = PostApi(
        uri: ApiVariables().deleteSection(id), body: {}, fromJson: (s) {});
    return await postApi.callRequest();
  }
}
