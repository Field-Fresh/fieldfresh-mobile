import 'dart:convert';

import 'package:fieldfreshmobile/client/field_fresh_api_client.dart';
import 'package:fieldfreshmobile/models/api/error.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:flutter/foundation.dart';

import 'requests.dart';
import 'responses.dart';

class UserClient {
  final FieldFreshApi apiClient;

  final String _userUrl = "/user";
  final String _authUrl = "/auth";

  UserClient({@required this.apiClient});

  Future<User> signup(UserSignupRequest request) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_authUrl/signup",
    );
    final response = await apiClient.httpClient.post(url,
        headers: apiClient.basePostHeader(),
        body: jsonEncode({
          "email": request.email,
          "password": request.password,
          "firstName": request.firstName,
          "lastName": request.lastName,
          "phone": request.phone,
          "proxy": request.proxy.toJson()
        }));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(results);
    } else {
      print(results);
      throw APIError.fromResponse(response);
    }
  }

  Future<bool> verifyCode(VerifyCodeRequest request) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_authUrl/verify",
    );
    final response = await apiClient.httpClient.post(url,
        headers: apiClient.basePostHeader(),
        body: jsonEncode({"email": request.email, "code": request.code}));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(results);
      throw Exception(results["message"]);
    }
  }

  Future<bool> resendVerifyCode(ResendVerifyCodeRequest request) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_authUrl/verify/resend",
    );
    final response = await apiClient.httpClient.put(url,
        headers: apiClient.basePostHeader(),
        body: jsonEncode({
          "email": request.email,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Error();
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    Uri url = Uri.http(
      apiClient.baseURL,
      "$_authUrl/signin",
    );
    final response = await apiClient.httpClient.post(url,
        headers: apiClient.basePostHeader(),
        body:
            jsonEncode({"email": request.email, "password": request.password}));
    final results = json.decode(response.body);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(results);
    } else {
      print(results);
      throw APIError.fromResponse(response);
    }
  }
}
