import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'https';
  final _host = "schoolbarea.000webhostapp.com";

  Uri _mainUri({
    required String path,
    Map<String, String>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      // port: 8000,
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
}
