import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  User _user;
  Tokens _tokens;

  factory UserSingleton() {
    return _instance;
  }

  void updateUser(User user) {
    this._user = user;
  }

  void updateTokens(Tokens tokens) {
    this._tokens = tokens;
  }

  Tokens getTokens() {
    return _tokens;
  }

  User getUser() {
    return _user;
  }

  UserSingleton._internal();
}