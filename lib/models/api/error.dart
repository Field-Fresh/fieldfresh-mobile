import 'dart:convert';

import 'package:http/http.dart';


class APIError {
  final String message;
  final String errorType;
  final int statusCode;

  APIError(this.message, this.statusCode, this.errorType);

  static APIError fromResponse(Response response) {
    var code = response.statusCode;
    var asJson = json.decode(response.body);
    if (code == 500) {
      return APIError(asJson['message'], code, asJson['error']);
    } else if (code == 400) {
      return APIError("message", 400, "errorType");
    }
  }
}