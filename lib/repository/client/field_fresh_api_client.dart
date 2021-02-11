import 'dart:io';

import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:http/http.dart' as http;

class FieldFreshApi {
  final http.Client httpClient;

  final String baseURL =
      Platform.isAndroid ? "10.0.2.2:9090" : "localhost:9090";

  final Map<String, String> basePostHeader = {
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
