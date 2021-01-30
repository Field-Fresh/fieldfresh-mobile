import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_event.dart';
import 'package:fieldfreshmobile/feature/user/signup/ui/user_signup.dart';
import 'package:fieldfreshmobile/models/address_components.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:flutter/foundation.dart';

// SignUp
class UserSignUpSubmittedEvent extends UserSignUpEvent {
  final String email;
  final String password;
  final String retypedPassword;

  UserSignUpSubmittedEvent(
      {@required this.email,
      @required this.password,
      @required this.retypedPassword})
      : super([email, password, retypedPassword]);

  @override
  String toString() => 'UserSignUpSubmittedEvent';
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

//UserDetails Collection
class UserDetailsSubmittedEvent extends UserSignUpEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  UserDetailsSubmittedEvent(
      {@required this.firstName, @required this.lastName, this.phoneNumber})
      : super([firstName, lastName, phoneNumber]);

  @override
  String toString() => 'UserDetailsSubmittedEvent';
}

//ProxyDetails Collection
class ProxyDetailsSubmittedEvent extends UserSignUpEvent {
  final String proxyName;
  final String proxyDescription;
  final String isBusiness;

  ProxyDetailsSubmittedEvent(
      {this.proxyName, this.proxyDescription, this.isBusiness})
      : super([proxyName, proxyDescription, isBusiness]);

  @override
  String toString() => 'ProxyDetailsSubmittedEvent';
}

class ProxyDetailsBusinessToggleEvent extends UserSignUpEvent {
  final bool toggled;

  ProxyDetailsBusinessToggleEvent(this.toggled);

  @override
  String toString() => 'ProxyDetailsBusinessToggleEvent';
}

class ProxyLocationSubmittedEvent extends UserSignUpEvent {
  final AddressComponents components;
  final double long;
  final double lat;

  ProxyLocationSubmittedEvent(this.components, this.long, this.lat)
      : super([components, long, lat]);

  @override
  String toString() => 'ProxyLocationSubmittedEvent';
}

//Navigation
class UserLoginNavigationRequestEvent extends UserSignUpEvent {
  UserLoginNavigationRequestEvent() : super();

  @override
  String toString() => 'UserLoginNavigationRequestEvent';
}
