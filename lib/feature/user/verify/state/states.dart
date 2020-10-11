import 'package:fieldfreshmobile/feature/user/verify/bloc/verify_state.dart';

class VerifyStateEmpty extends VerifyState {
  @override
  String toString() => 'VerifyStateEmpty';
}

class VerifySuccessState extends VerifyState {

  final String email;

  VerifySuccessState(this.email) : super([email]);

  @override
  String toString() => 'VerifySuccessState';
}

class ResendVerifyCodeSuccessState extends VerifyState {

  final String email;

  ResendVerifyCodeSuccessState(this.email) : super([email]);

  @override
  String toString() => 'ResendVerifyCodeSuccessState';
}

class ResendVerifyCodeFailureState extends VerifyState {

  final String email;
  final String error;

  ResendVerifyCodeFailureState(this.email, {this.error}) : super([email, error]);

  @override
  String toString() => 'ResendVerifyCodeFailureState';
}

class VerifyFailedState extends VerifyState {

  final String email;
  final String error;
  final String code;

  VerifyFailedState(this.email, this.code, {this.error}) : super([email, error, code]);

  @override
  String toString() => 'VerifyFailedState';
}
