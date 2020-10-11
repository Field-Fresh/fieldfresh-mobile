class Tokens {
  final String accessToken;
  final String refreshToken;
  final int expirseIn;
  final String idToken;
  final String tokenType;

  Tokens({this.accessToken, this.expirseIn, this.idToken, this.refreshToken, this.tokenType});

  static Tokens fromJson(Map<String, dynamic> json) {
    return Tokens(
      idToken: json['id_token'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expirseIn: json['expires_in'],
      tokenType: json['token_type'],
    );
  }
}