import 'dart:developer';

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

  Uri subjects() {
    return _mainUri(
      path: 'subject',
    );
  }

  Uri showSubjects(int id) =>
      _mainUri(path: 'subject/show', queryParameters: {'id': '$id'});

  Uri addSubjects() => _mainUri(
        path: 'subject/add',
      );

  Uri updateSubjects(int id) =>
      _mainUri(path: 'subject/update', queryParameters: {'id': '$id'});

  Uri deleteSubjects(int id) =>
      _mainUri(path: 'subject/delete', queryParameters: {'id': '$id'});
}
