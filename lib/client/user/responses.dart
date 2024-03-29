
import 'package:fieldfreshmobile/models/api/proxy/proxy.dart';
import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:fieldfreshmobile/models/api/user/user.dart';

class LoginResponse {
  final User user;
  final Tokens tokens;
  final bool verificationRequired;
  final String defaultProxy;

  LoginResponse({this.tokens, this.user, this.verificationRequired, this.defaultProxy});

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json['user'] == null ? null : User.fromJson(json['user']),
      tokens: json['cognitoJWT'] == null ? null : Tokens.fromJson(json['cognitoJWT']),
      verificationRequired: json['requireVerification'],
      defaultProxy: json['defaultProxy']
    );
  }
}

