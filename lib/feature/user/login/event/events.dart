import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_event.dart';
import 'package:flutter/foundation.dart';

class UserLoginRequestEvent extends UserLoginEvent {
  final String email;
  final String password;

  UserLoginRequestEvent(
      {
        @required this.email,
        @required this.password
      }
      ): super([email, password]);

  @override
  String toString() => 'UserLoginRequestEvent';
}

class UserVerificationSuccessEvent extends UserLoginEvent {
  final String email;

  UserVerificationSuccessEvent(
      {
        @required this.email,
      }
      ): super([email]);

  @override
  String toString() => 'UserVerificationSuccessEvent';
}

class UserVerificationFailureEvent extends UserLoginEvent {
  final String email;
  final String code;
  final String error;

  UserVerificationFailureEvent(
      {
        @required this.email,
        @required this.code,
        @required this.error
      }
      ): super([email, code, error]);

  @override
  String toString() => 'UserVerificationFailureEvent';
}

class UserReturnToLoginEvent extends UserLoginEvent {

  UserReturnToLoginEvent(): super();

  @override
  String toString() => 'UserReturnToLoginEvent';
}