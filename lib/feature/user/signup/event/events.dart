

import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:flutter/foundation.dart';

class UserSignUpRequestEvent extends UserSignUpEvent {
  final String email;
  final String password;
  final String retypedPassword;

  UserSignUpRequestEvent(
      {
        @required this.email,
        @required this.password,
        @required this.retypedPassword
      }
    ) : super([email, password, retypedPassword]);

  @override
  String toString() => 'UserSignUpRequestEvent';
}