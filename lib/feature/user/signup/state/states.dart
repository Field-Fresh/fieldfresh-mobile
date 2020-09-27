import 'package:fieldfreshmobile/feature/user/signup/bloc/user_signup_state.dart';
import 'package:fieldfreshmobile/models/user/user.dart';

class SignUpStateEmpty extends UserSignUpState {
  @override
  String toString() => 'SignUpStateEmpty';
}

class SignUpStateLoading extends UserSignUpState {
  @override
  String toString() => 'SignUpStateLoading';
}

class SignUpStateSuccess extends UserSignUpState {

  final User user;
  final bool verificationRequired;

  SignUpStateSuccess(this.user, this.verificationRequired) : super([user, verificationRequired]);

  @override
  String toString() => 'SignUpStateSuccess';
}

class SignUpStateFailed extends UserSignUpState {

  final String error;

  SignUpStateFailed(this.error) : super([error]);

  @override
  String toString() => 'SignUpStateFailed';
}
