import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/features/type/data/models/index_type_model.dart';

class TypeDatasource {
  Future<IndexTypesResponseModel> indexTypes() async {
    final getApi = GetApi(
        uri: ApiVariables().types(), fromJson: indexTypesResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowTypesResponseModel> addType(BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().addTypes(),
        body: body,
        fromJson: showTypesResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> deleteType(int id) async {
    final getApi = PostApi(
        uri: ApiVariables().deleteTypes(id),
        body: {'id': id},
        fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<ShowTypesResponseModel> updateType(BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().updateTypes(),
        body: body,
        fromJson: showTypesResponseModelFromJson);
    return await getApi.callRequest();
  }
}
