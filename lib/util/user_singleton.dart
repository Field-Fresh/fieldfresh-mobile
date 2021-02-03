import 'package:fieldfreshmobile/models/api/user/user.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  User _user;

  factory UserSingleton() {
    return _instance;
  }

  void updateUser(User user) {
    this._user = user;
  }

  User getUser() {
    return _user;
  }

  UserSingleton._internal();
}