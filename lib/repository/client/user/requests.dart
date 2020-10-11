import 'package:flutter/foundation.dart';

class CreateUserRequest {
  final String email;
  final String password;

  CreateUserRequest({@required this.email,@required this.password});
}

class VerifyCodeRequest {
  final String email;
  final String code;

  VerifyCodeRequest({@required this.email,@required this.code});
}

class ResendVerifyCodeRequest {
  final String email;

  ResendVerifyCodeRequest({@required this.email});
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({@required this.email,@required this.password});
}