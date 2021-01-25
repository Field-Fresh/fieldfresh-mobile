
import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';

class SignUpStateEmpty extends UserSignUpState {
  @override
  String toString() => 'SignUpStateEmpty';
}

class SignUpStateLoading extends UserSignUpState {
  @override
  String toString() => 'SignUpStateLoading';
}

class SignUpStateVerification extends UserSignUpState {

  final User user;

  SignUpStateVerification({this.user}) : super([user]);

  @override
  String toString() => 'SignUpStateVerification';
}

class SignUpStateFailed extends UserSignUpState {

  final String error;

  SignUpStateFailed(this.error) : super([error]);

  @override
  String toString() => 'SignUpStateFailed';
}

class SignUpStateVerificationSuccess extends UserSignUpState {

  final String email;

  SignUpStateVerificationSuccess(this.email) : super([email]);

  @override
  String toString() => 'SignUpStateVerificationSuccess';
}

// User Details
class UserDetailsSuccessState extends UserSignUpState {

  final User user;

  UserDetailsSuccessState(this.user) : super([user]);

  @override
  String toString() => 'UserDetailsSuccessState';
}

// Proxy Details
class ProxyDetailsSuccessState extends UserSignUpState {

  final Proxy proxy;

  ProxyDetailsSuccessState(this.proxy) : super([proxy]);

  @override
  String toString() => 'ProxyDetailsSuccessState';
}
