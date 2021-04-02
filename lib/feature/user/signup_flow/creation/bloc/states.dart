import 'package:equatable/equatable.dart';
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';

abstract class UserSignUpFlowState extends Equatable {
  UserSignUpFlowState([List props = const []]) : super(props);
}

abstract class SignupStepState extends UserSignUpFlowState {
  final int step;

  SignupStepState(this.step, [List props = const []]) : super([step, ...props]);
}

class CredentialsStep extends SignupStepState {
  final String email;

  CredentialsStep(step, {this.email}) : super(step, [email]);

  @override
  String toString() {
    return "CredentialsStep";
  }
}

class UserInfoStep extends SignupStepState {
  final String firstName;
  final String lastName;
  final String phone;

  UserInfoStep(step, {this.firstName, this.lastName, this.phone})
      : super(step, [firstName, lastName, phone]);

  @override
  String toString() {
    return "UserInfoStep";
  }
}

class ProxyStep extends SignupStepState {
  final Proxy proxy;

  ProxyStep(step, this.proxy) : super(step, [proxy]);

  @override
  String toString() {
    return "ProxyStep";
  }
}

class SignupSuccess extends UserSignUpFlowState {
  final User user;

  SignupSuccess(this.user) : super([user]);

  @override
  String toString() {
    return "SignupSuccess";
  }
}

class Error extends UserSignUpFlowState {
  final String errorString;
  final SignupStepState prevState;

  Error(this.errorString, this.prevState) : super([errorString, prevState]);

  @override
  String toString() {
    return "Error";
  }
}
