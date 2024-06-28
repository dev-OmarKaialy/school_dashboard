import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'http';
  final _host = "localhost";

  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
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

  Uri addsubjects() {
    return _mainUri(
      path: 'subject/add',
    );
  }
}
