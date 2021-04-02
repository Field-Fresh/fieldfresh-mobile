import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';

abstract class UserSignupVerificationState extends Equatable {
  UserSignupVerificationState([List props = const []]) : super(props);
}

class SignUpStateEmpty extends UserSignupVerificationState {
  @override
  String toString() => 'SignUpStateEmpty';
}

class SignUpStateLoading extends UserSignupVerificationState {
  @override
  String toString() => 'SignUpStateLoading';
}

class SignUpStateVerification extends UserSignupVerificationState {

  final User user;

  SignUpStateVerification({this.user}) : super([user]);

  @override
  String toString() => 'SignUpStateVerification';
}

class SignUpStateFailed extends UserSignupVerificationState {

  final String error;

  SignUpStateFailed(this.error) : super([error]);

  @override
  String toString() => 'SignUpStateFailed';
}

class SignUpStateVerificationSuccess extends UserSignupVerificationState {

  final String email;

  SignUpStateVerificationSuccess(this.email) : super([email]);

  @override
  String toString() => 'SignUpStateVerificationSuccess';
}