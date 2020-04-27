import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/user.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Business logic component for user.
class UserBloc extends Bloc {
  UserRepository _userRepository;
  StreamController _userController;

  /// Returns the sink of the user stream controller.
  StreamSink<ApiResponse<User>> get userSink => _userController.sink;

  /// Returns the stream of the user stream controller.
  Stream<ApiResponse<User>> get userStream => _userController.stream;

  UserBloc() {
    _userController = StreamController<ApiResponse<User>>();
    _userRepository = UserRepository();
    fetchMyUser();
  }

  /// Fetches my user info.
  fetchMyUser() async {
    userSink.add(ApiResponse.loading());
    try {
      User user = await _userRepository.fetchMyUser();
      userSink.add(ApiResponse.success(user));
    } on AppException catch (e) {
      userSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      userSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _userController?.close();
  }
}
