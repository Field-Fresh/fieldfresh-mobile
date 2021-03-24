import 'dart:io';

import 'package:fieldfreshmobile/app_config.dart';
import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:http/http.dart' as http;

class FieldFreshApi {
  final http.Client httpClient;

  final String baseURL = AppConfig.getInstance().apiHost;

  Map<String, String> basePostHeader() => {
    "Content-Type": "application/json",
  };

  Map<String, String> addAuthenticationHeader(
      Map<String, String> headers, Tokens tokens) {
    headers.putIfAbsent("Authorization", () => "Bearer ${tokens.accessToken}");
    return headers;
  }

  FieldFreshApi({
    httpClient,
  }) : this.httpClient = httpClient ?? http.Client();
}
