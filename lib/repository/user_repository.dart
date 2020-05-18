import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haircut_delivery/model/login.dart';
import 'package:haircut_delivery/model/register.dart';
import 'package:haircut_delivery/model/reset_password.dart';
import 'package:haircut_delivery/model/user.dart';
import 'package:haircut_delivery/service/haircut_service_client.dart';

class UserRepository {
  final _client = HaircutServiceClient();

  /// Registers a user account.
  Future register(RegisterParameters parameters) async {
    return await _client.post('customer-users', data: parameters);
  }

  /// Logs in.
  Future<Tokens> logIn(LoginParameters parameters) async {
    final response =
        await _client.post('customer-users/log-in', data: parameters);

    // Persist the access token.
    Tokens tokens = Tokens.fromJson(response);
    _persistAccessToken(tokens.accessToken);

    return tokens;
  }

  /// Persists an access token locally.
  _persistAccessToken(String accessToken) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'accessToken', value: accessToken);
  }

  /// Logs in with Facebook.
  Future<Tokens> logInWithFacebook(
      LogInWithFacebookParameters parameters) async {
    final response = await _client.post('customer-users/log-in-with-facebook',
        data: parameters);

    // Persist the access token.
    Tokens tokens = Tokens.fromJson(response);
    _persistAccessToken(tokens.accessToken);

    return tokens;
  }

  /// Fetches my user info.
  Future<User> fetchMyUser() async {
    final response =
        await _client.get('customer-users/me', withAccessToken: true);
    return User.fromJson(response);
  }

  /// Request a password reset OTP by email address.
  Future requestPasswordResetOtpByEmail(
      RequestPasswordResetOtpByEmailParameters parameters) async {
    return await _client.post('customer-users/request-password-reset-otp',
        data: parameters);
  }

  /// Request a password reset OTP by pone number.
  Future requestPasswordResetOtpByPhone(
      RequestPasswordResetOtpByPhoneParameters parameters) async {
    return await _client.post('customer-users/request-password-reset-otp',
        data: parameters);
  }

  /// Submits a password reset OTP by email address.
  Future<PasswordResetToken> submitPasswordResetOtpByEmail(
      SubmitPasswordResetOtpByEmailParameters parameters) async {
    final response = await _client
        .post('customer-users/submit-password-reset-otp', data: parameters);
    return PasswordResetToken.fromJson(response);
  }

  /// Submits a password reset OTP by phone number.
  Future submitPasswordResetOtpByPhone(
      SubmitPasswordResetOtpByPhoneParameters parameters) async {
    final response = await _client
        .post('customer-users/submit-password-reset-otp', data: parameters);
    return PasswordResetToken.fromJson(response);
  }

  /// Submits a new password along with a password reset code.
  Future resetPassword(ResetPasswordParameters parameters) async {
    return await _client.post('customer-users/reset-password',
        data: parameters);
  }

  /// Returns true if the current user has not logged in, false otherwise.
  static Future<bool> isGuest() async {
    final storage = FlutterSecureStorage();
    String accessToken = await storage.read(key: 'accessToken');
    return accessToken == null;
  }

  /// Logs out.
  static Future logOut() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'accessToken');
    return;
  }
}
