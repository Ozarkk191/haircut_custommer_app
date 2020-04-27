import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/register.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Business logic component for the Register screen.
class RegisterBloc extends Bloc {
  UserRepository _userRepository;
  StreamController _registerController;

  /// Returns the sink of the user registration stream controller.
  StreamSink<ApiResponse> get registerSink => _registerController.sink;

  /// Returns the stream of the user registration stream controller.
  Stream<ApiResponse> get registerStream => _registerController.stream;

  RegisterBloc() {
    _registerController = StreamController<ApiResponse>.broadcast();
    _userRepository = UserRepository();
  }

  /// Registers a user with [parameters].
  register(RegisterParameters parameters) async {
    registerSink.add(ApiResponse.loading());
    try {
      await _userRepository.register(parameters);
      registerSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      registerSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      registerSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _registerController?.close();
  }
}
