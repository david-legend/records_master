import 'dart:convert';

TokenModel tokenFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  TokenModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => new TokenModel(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
