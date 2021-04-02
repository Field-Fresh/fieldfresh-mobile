import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:flutter/widgets.dart';

abstract class UserSignUpEvent extends Equatable {
  UserSignUpEvent([List props = const []]) : super(props);
}

//Verification
class UserVerificationCodeRequestEvent extends UserSignUpEvent {
  final String code;
  final User user;

  UserVerificationCodeRequestEvent({@required this.user, @required this.code})
      : super([user, code]);

  @override
  String toString() => 'UserVerificationCodeRequestEvent';
}

class UserVerificationSuccessEvent extends UserSignUpEvent {
  final String email;

  UserVerificationSuccessEvent(this.email) : super([email]);

  @override
  String toString() => 'UserVerificationSuccessEvent';
}

class UserVerificationFailureEvent extends UserSignUpEvent {
  final String email;
  final String code;
  final String error;

  UserVerificationFailureEvent(this.email, this.code, {this.error})
      : super([email, code]);

  @override
  String toString() => 'UserVerificationFailureEvent';
}

//Navigation
class UserLoginNavigationRequestEvent extends UserSignUpEvent {
  UserLoginNavigationRequestEvent() : super();

  @override
  String toString() => 'UserLoginNavigationRequestEvent';
}