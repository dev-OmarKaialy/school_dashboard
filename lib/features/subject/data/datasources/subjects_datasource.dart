import 'dart:convert';

import 'package:school_daashboard/core/unified_api/api_variables.dart';
import 'package:school_daashboard/core/unified_api/get_api.dart';
import 'package:school_daashboard/core/unified_api/post_api.dart';

import '../../../../core/resources/type_defs.dart';
import '../models/subject_model.dart';

class SubjectDatasource {
  Future<SubjectsResponseModel> getSubjects() async {
    final getApi = GetApi(
        uri: ApiVariables().subjects(),
        fromJson: subjectsResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowSubjectsResponseModel> showSubject(int id) async {
    final getApi = GetApi(
        uri: ApiVariables().showSubjects(id),
        fromJson: showSubjectsResponseModelFromJson);
    return await getApi.callRequest();
  }

  Future<ShowSubjectsResponseModel> addSubject(BodyMap body) async {
    final postApi = PostApi(
        uri: ApiVariables().addSubjects(),
        body: body,
        fromJson: showSubjectsResponseModelFromJson);
    return await postApi.callRequest();
  }

  Future<ShowSubjectsResponseModel> editSubject(BodyMap body, int id) async {
    final postApi = PostApi(
        uri: ApiVariables().updateSubjects(id),
        body: body,
        fromJson: showSubjectsResponseModelFromJson);
    return await postApi.callRequest();
  }

  Future<String> deleteSubject(int id) async {
    final postApi = PostApi(
        body: {},
        uri: ApiVariables().deleteSubjects(id),
        fromJson: (str) {
          final result = jsonDecode(str);
          return result['message'];
        });
    return await postApi.callRequest();
  }
}
