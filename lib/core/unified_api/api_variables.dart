import 'dart:developer';

import 'package:school_daashboard/core/resources/type_defs.dart';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'http';
  final _host = "localhost";

  Uri _mainUri({
    required String path,
    Map<String, String>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      port: 8000,
      path: 'api/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  Uri authUri() {
    return _mainUri(
      path: 'auth/login',
    );
  }

/////subjects/////
  Uri subjects() => _mainUri(path: 'subject');

  Uri showSubjects(int id) =>
      _mainUri(path: 'subject/show', queryParameters: {'id': '$id'});

  Uri addSubjects() => _mainUri(path: 'subject/add');

  Uri updateSubjects(int id) =>
      _mainUri(path: 'subject/update', queryParameters: {'id': '$id'});

  Uri deleteSubjects(int id) =>
      _mainUri(path: 'subject/delete', queryParameters: {'id': '$id'});
/////lessons/////
  Uri lessons() => _mainUri(path: 'lesson');

  Uri addLessons() => _mainUri(path: 'lesson/add');

  Uri updateLessons(int id) =>
      _mainUri(path: 'lesson/update', queryParameters: {'id': '$id'});

  Uri deleteLessons(int id) =>
      _mainUri(path: 'lesson/delete', queryParameters: {'id': '$id'});
/////types/////
  Uri types() => _mainUri(path: 'type');

  Uri addTypes() => _mainUri(path: 'type/add');

  Uri updateTypes() => _mainUri(path: 'type/update');

  Uri deleteTypes(int id) => _mainUri(path: 'type/delete');
/////section/////
  Uri section() => _mainUri(path: 'section');

  Uri addSection() => _mainUri(path: 'section/add');

  Uri updateSection(int id) =>
      _mainUri(path: 'section/update', queryParameters: {'id': '$id'});

  Uri deleteSection(int id) =>
      _mainUri(path: 'section/delete', queryParameters: {'id': "$id"});
/////teacher/////
  Uri teacher() => _mainUri(path: 'teacher');
  Uri blockTeacher(int id) =>
      _mainUri(queryParameters: {'id': '$id'}, path: 'teacher/block');
  Uri unblockTeacher(int id) =>
      _mainUri(queryParameters: {'id': '$id'}, path: 'teacher/unblock');
/////users/////
  Uri users() => _mainUri(path: 'user');
  Uri blockuser(int id) =>
      _mainUri(queryParameters: {'id': '$id'}, path: 'user/block');
  Uri unblockuser(int id) =>
      _mainUri(queryParameters: {'id': '$id'}, path: 'user/unblock');
  Uri sendNotification() {
    return _mainUri(path: 'user/sendNotification');
  }

  ///// assignments ///////
  Uri assignUserToClassSection() {
    return _mainUri(path: 'user/assign_user_to_class_section');
  }

  Uri assingSectionToType(int id, int sid) => _mainUri(
      path: 'type/assing_section_to_type',
      queryParameters: {'type_id': "$id", "section_id": "$sid"});
  Uri program() => _mainUri(path: 'program');
  Uri addprogram() => _mainUri(path: 'program/add');
  Uri attachprogram(ParamsMap params) =>
      _mainUri(path: 'program/attach', queryParameters: params);
  Uri addHomework() => _mainUri(path: 'homework/add');
  Uri exams() => _mainUri(path: 'examp');
  Uri examsAdd() => _mainUri(path: 'examp/add');
}
