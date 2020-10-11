import 'package:fieldfreshmobile/feature/user/login/bloc/user_login_state.dart';
import 'package:fieldfreshmobile/models/user/tokens.dart';
import 'package:fieldfreshmobile/models/user/user.dart';

class UserLoginStateEmpty extends UserLoginState {
  @override
  String toString() => 'UserLoginStateEmpty';
}

class UserLoginStateVerificationRequired extends UserLoginState {
  final String email;

  UserLoginStateVerificationRequired(this.email): super([email]);

  @override
  String toString() => 'UserLoginStateVerificationRequired';
}

class UserLoginStateSuccess extends UserLoginState {
  final User user;

  UserLoginStateSuccess(this.user): super([user]);

  @override
  String toString() => 'UserLoginStateSuccess';
}

class UserLoginStateFailed extends UserLoginState {
  final String error;

  UserLoginStateFailed(this.error): super([error]);

  @override
  String toString() => 'UserLoginStateFailed';
}