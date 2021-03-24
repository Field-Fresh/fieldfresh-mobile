import 'package:flutter/foundation.dart';

class CreateUserRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;

  CreateUserRequest(
      {this.email, this.password, this.firstName, this.lastName, this.phone});
}

class VerifyCodeRequest {
  final String email;
  final String code;

  VerifyCodeRequest({@required this.email, @required this.code});
}

class ResendVerifyCodeRequest {
  final String email;

  ResendVerifyCodeRequest({@required this.email});
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({@required this.email, @required this.password});
}
