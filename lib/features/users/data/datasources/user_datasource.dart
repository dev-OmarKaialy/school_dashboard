import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';
import 'package:school_daashboard/features/users/data/models/get_users_model.dart';

class UserDatasource {
  Future<IndexUsersModel> getUsers() async {
    final getApi =
        GetApi(uri: ApiVariables().users(), fromJson: indexUsersModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> blockUsers(int id) async {
    final getApi = GetApi(uri: ApiVariables().blockuser(id), fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<void> unblockUsers(int id) async {
    final getApi =
        GetApi(uri: ApiVariables().unblockuser(id), fromJson: (s) {});
    return await getApi.callRequest();
  }

  Future<void> sendNotification(BodyMap body) async {
    final getApi = PostApi(
        uri: ApiVariables().sendNotification(), body: body, fromJson: (s) {});
    return await getApi.callRequest();
  }
}
