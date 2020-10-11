import 'package:fieldfreshmobile/models/user/tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtil {
  static final String jwtAccessTokenKey = "JWT-ACCESS";
  static final String jwtIDTokenKey = "JWT-ID";
  static final String jwtTokenTypeKey = "JWT-TYPE";
  static final String jwtExpireKey = "JWT-EXPIRE";
  static final String jwtRefreshTokenKey = "JWT-REFRESH";

  static void storeAuth(Tokens tokens) async {
    FlutterSecureStorage credStore = FlutterSecureStorage();
    await credStore.write(key: jwtAccessTokenKey, value: tokens.accessToken);
    await credStore.write(key: jwtIDTokenKey, value: tokens.idToken);
    await credStore.write(key: jwtTokenTypeKey, value: tokens.tokenType);
    await credStore.write(
        key: jwtExpireKey, value: tokens.expirseIn.toString());
  }

  static Future<Tokens> getAuth() async {
    FlutterSecureStorage credStore = FlutterSecureStorage();
    return Tokens(
        accessToken: await credStore.read(key: jwtAccessTokenKey),
        idToken: await credStore.read(key: jwtIDTokenKey),
        refreshToken: await credStore.read(key: jwtRefreshTokenKey),
        tokenType: await credStore.read(key: jwtTokenTypeKey),
        expirseIn: int.parse(await credStore.read(key: jwtExpireKey)),
    );
  }

  static Future<void> clearAuth() async {
    FlutterSecureStorage credStore = FlutterSecureStorage();
    await credStore.delete(key: jwtAccessTokenKey);
    await credStore.delete(key: jwtIDTokenKey);
    await credStore.delete(key: jwtTokenTypeKey);
    await credStore.delete(key: jwtExpireKey);
  }
}
