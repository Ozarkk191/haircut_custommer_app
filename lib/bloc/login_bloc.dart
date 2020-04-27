import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/login.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Business logic component for the Login screen.
class LoginBloc extends Bloc {
  UserRepository _userRepository;
  StreamController _loginController;
  StreamController _loginWithFacebookController;

  /// Returns the sink of the login stream controller.
  StreamSink<ApiResponse<Tokens>> get loginSink => _loginController.sink;

  /// Returns the sink of the login with Facebook stream controller.
  StreamSink<ApiResponse<Tokens>> get loginWithFacebookSink => _loginWithFacebookController.sink;

  /// Returns the stream of the login stream controller.
  Stream<ApiResponse<Tokens>> get loginStream => _loginController.stream;

  /// Returns the stream of the login with Facebook stream controller.
  Stream<ApiResponse<Tokens>> get loginWithFacebookStream => _loginWithFacebookController.stream;

  LoginBloc() {
    _loginController = StreamController<ApiResponse<Tokens>>.broadcast();
    _loginWithFacebookController = StreamController<ApiResponse<Tokens>>.broadcast();
    _userRepository = UserRepository();
  }

  /// Logs in with [parameters].
  logIn(LoginParameters parameters) async {
    loginSink.add(ApiResponse.loading());
    try {
      Tokens tokens = await _userRepository.logIn(parameters);
      loginSink.add(ApiResponse.success(tokens));
    } on AppException catch (e) {
      loginSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      loginSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  /// Logs in with facebook.
  logInWithFacebook(LogInWithFacebookParameters parameters) async {
    loginWithFacebookSink.add(ApiResponse.loading());
    try {
      Tokens tokens = await _userRepository.logInWithFacebook(parameters);
      loginWithFacebookSink.add(ApiResponse.success(tokens));
    } on AppException catch (e) {
      loginWithFacebookSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      loginWithFacebookSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _loginController?.close();
    _loginWithFacebookController?.close();
  }
}
