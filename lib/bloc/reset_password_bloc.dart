import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/reset_password.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Business logic component for the Reset Password screen.
class ResetPasswordBloc extends Bloc {
  UserRepository _userRepository;
  StreamController _resetPasswordController;

  /// Returns the sink of the reset password stream controller.
  StreamSink<ApiResponse> get resetPasswordSink => _resetPasswordController.sink;

  /// Returns the stream of the reset password stream controller.
  Stream<ApiResponse> get resetPasswordStream => _resetPasswordController.stream;

  ResetPasswordBloc() {
    _resetPasswordController = StreamController<ApiResponse>.broadcast();
    _userRepository = UserRepository();
  }

  /// Resets password with [parameters].
  resetPassword(ResetPasswordParameters parameters) async {
    resetPasswordSink.add(ApiResponse.loading());
    try {
      await _userRepository.resetPassword(parameters);
      resetPasswordSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      resetPasswordSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      resetPasswordSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _resetPasswordController?.close();
  }
}
