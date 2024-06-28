import 'package:school_daashboard/core/resources/type_defs.dart';
import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';

import '../models/login_model.dart';

class AuthDatasource {
  Future<LoginModel> login(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().authUri(),
        body: body,
        fromJson: loginModelFromJson);
    return await postApi.callRequest();
  }
}
