import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:record_master/src/models/token.dart';
import 'package:record_master/src/models/user.dart';

final root_url = "https://recordmaster.shrinqghana.com";
//final String root_url = "http://4e887650.ngrok.io";
final String client_secret = "whg5Uetc6T6IzzqkbFan1fMMGO7gK5Yawurbrgd9";
final String grant_type = "password";
final String client_id = "2";

class loginApiProvider {
  getAccessToken(String username, String password) async {
    final response = await http.post(
      '$root_url/oauth/token',
      body: {
        "username": username,
        "password": password,
        "grant_type": grant_type,
        "client_id": client_id,
        "client_secret": client_secret,
      },
    );

    final parsedJson = json.decode(response.body);
    print('${response.body}');
    return TokenModel.fromJson(parsedJson);
  }

  getUserData(String email, String password, String token) async {
    final response = await http.post(
      '$root_url/api/user',
      body: {
        "email": email,
        "password": password,
      },
      headers: {"Authorization": "Bearer $token"},
    );

    final parsedJson = json.decode(response.body);
    print('${response.body}');
    return UserModel.fromJson(parsedJson);
  }
}
