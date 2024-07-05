import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/delete_api.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/features/type/data/models/index_type_model.dart';

class TypeDatasource {
  Future<List<TypeModel>> indexTypes() async {
    final getApi = GetApi(
        uri: ApiVariables().types(), fromJson: indexTypesResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> addType(BodyMap body) async {
    final getApi =
        PostApi(uri: ApiVariables().addTypes(), body: body, fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<void> deleteType(int id) async {
    final getApi =
        DeleteApi(uri: ApiVariables().deleteTypes(id), fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<void> updateType(int id, BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().updateTypes(id), body: body, fromJson: (s) {});
    return await getApi.callRequest();
  }
}
