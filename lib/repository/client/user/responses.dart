import 'package:fieldfreshmobile/models/user/tokens.dart';
import 'package:fieldfreshmobile/models/user/user.dart';

class LoginResponse {
  final User user;
  final Tokens tokens;
  final bool verificationRequired;

  LoginResponse({this.tokens, this.user, this.verificationRequired});

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json['user'] == null ? null : User.fromJson(json['user']),
      tokens: json['cognitoJWT'] == null ? null : Tokens.fromJson(json['cognitoJWT']),
      verificationRequired: json['requireVerification'],
    );
  }
}

