// ignore_for_file: strict_raw_type

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum RequestType { GET, POST, PATCH, PUT, DELETE }

class ApiClient extends GetConnect {
  @override
  void onInit() {
    _initClient();
    super.onInit();
  }

  Future<void> _initClient() async {
    httpClient
      ..baseUrl = dotenv.get('API_URL')
      ..timeout = const Duration(seconds: 30)
      ..defaultContentType = 'application/json';
  }

  Future<Response> execute(
    RequestType type,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    switch (type) {
      case RequestType.GET:
        return httpClient.get(
          endpoint,
          query: _paramsToString(params),
        );
      case RequestType.POST:
        return httpClient.post(
          endpoint,
          body: body,
          query: _paramsToString(params),
        );
      case RequestType.PATCH:
        return httpClient.patch(
          endpoint,
          body: body,
          query: _paramsToString(params),
        );
      case RequestType.PUT:
        return httpClient.put(
          endpoint,
          body: body,
          query: _paramsToString(params),
        );
      case RequestType.DELETE:
        return httpClient.delete(
          endpoint,
          query: _paramsToString(params),
        );
    }
  }

  Map<String, String>? _paramsToString(Map<String, dynamic>? params) {
    return params?.map<String, String>(
      (key, value) => MapEntry(key, value.toString()),
    )?..removeWhere((key, value) => value == 'null');
  }
}
