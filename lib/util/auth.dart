import 'package:fieldfreshmobile/models/api/user/tokens.dart';
import 'package:fieldfreshmobile/util/user_singleton.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtil {
  static final String jwtAccessTokenKey = "JWT-ACCESS";
  static final String jwtIDTokenKey = "JWT-ID";
  static final String jwtTokenTypeKey = "JWT-TYPE";
  static final String jwtExpireKey = "JWT-EXPIRE";
  static final String jwtRefreshTokenKey = "JWT-REFRESH";

  static void storeAuth(Tokens tokens) async {
    UserSingleton().updateTokens(tokens);
  }

  static Future<Tokens> getAuth() async {
    return UserSingleton().getTokens();
  }

  static Future<void> clearAuth() async {
    FlutterSecureStorage credStore = FlutterSecureStorage();
    await credStore.delete(key: jwtAccessTokenKey);
    await credStore.delete(key: jwtIDTokenKey);
    await credStore.delete(key: jwtTokenTypeKey);
    await credStore.delete(key: jwtExpireKey);
  }
}
