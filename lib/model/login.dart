import 'package:haircut_delivery/model/request_body_parameters.dart';

const CLIENT_ID = 'Android';
const CLIENT_SECRET = '11upFYPwV2dFYNl1G8ZLQzPoJWfJeMz9';

class LoginParameters extends RequestBodyParameters {
  final String username;
  final String password;

  LoginParameters(this.username, this.password);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'grant_type': 'password',
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET,
      };
}

class LogInWithFacebookParameters extends RequestBodyParameters {
  final String accessToken;
  final String id;
  final String email;

  LogInWithFacebookParameters(this.accessToken, this.id, this.email);

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'id': id,
        'email': email,
        'grant_type': 'facebook_credentials',
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET
      };
}

class Tokens {
  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Tokens.fromJson(Map json)
      : tokenType = json['token_type'],
        expiresIn = json['expires_in'],
        accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}
