

import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/models/user/user.dart';
import 'package:flutter/foundation.dart';

class UserSignUpRequestEvent extends UserSignUpEvent {
  final String name;
  final String email;
  final String password;
  final String retypedPassword;

  UserSignUpRequestEvent(
      {
        @required this.name,
        @required this.email,
        @required this.password,
        @required this.retypedPassword
      }
    ) : super([name, email, password, retypedPassword]);

  @override
  String toString() => 'UserSignUpRequestEvent';
}

class UserVerificationCodeRequestEvent extends UserSignUpEvent {
  final String code;
  final User user;

  UserVerificationCodeRequestEvent(
      {
        @required this.user,
        @required this.code
      }
    ): super([user, code]);

  @override
  String toString() => 'UserVerificationCodeRequestEvent';
}

class UserVerificationSuccessEvent extends UserSignUpEvent {
  final String email;

  UserVerificationSuccessEvent(this.email): super([email]);

  @override
  String toString() => 'UserVerificationSuccessEvent';
}

class UserVerificationFailureEvent extends UserSignUpEvent {
  final String email;
  final String code;
  final String error;

  UserVerificationFailureEvent(this.email, this.code, {this.error}): super([email, code]);

  @override
  String toString() => 'UserVerificationFailureEvent';
}

class UserLoginNavigationRequestEvent extends UserSignUpEvent {

  UserLoginNavigationRequestEvent(): super();

  @override
  String toString() => 'UserLoginNavigationRequestEvent';
}