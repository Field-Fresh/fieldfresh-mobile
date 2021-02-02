import 'package:fieldfreshmobile/models/api/user/user.dart';
import 'package:fieldfreshmobile/repository/client/user/requests.dart';
import 'package:fieldfreshmobile/repository/client/user/responses.dart';
import 'package:fieldfreshmobile/repository/client/user/user_client.dart';

class UserRepository {
  final UserClient userClient;

  UserRepository(this.userClient);
  
  Future<User> createUser(User user, String password) async {
    return userClient.createUser(
      CreateUserRequest(
        email: user.email,
        password: password,
        firstName: user.firstName,
        lastName: user.lastName
      )
    );
  }

  Future<User> updateUser(User user) async {
    return user;
  }

  Future<bool> verifyUserCode(String email, String code) async {
    return userClient.verifyCode(
        VerifyCodeRequest(email: email, code: code)
    );
  }

  Future<LoginResponse> login(String email, String password) async {
    return userClient.login(
        LoginRequest(email: email, password: password)
    );
  }

  Future<bool> resendVerification(String email) async {
    return userClient.resendVerifyCode(
      ResendVerifyCodeRequest(email: email.trim())
    );
  }
}