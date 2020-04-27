import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/reset_password.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Business logic component for the Forgot Password OTP screen.
class ForgotPasswordOtpBloc extends Bloc {
  UserRepository _userRepository;
  StreamController _requestButtonController;
  StreamController _submitButtonController;
  StreamController _otpBoxWidthController;
  StreamController _requestPasswordResetOtpByPhoneController;
  StreamController _requestPasswordResetOtpByEmailController;
  StreamController _submitPasswordResetOtpByPhoneController;
  StreamController _submitPasswordResetOtpByEmailController;

  /// Returns the sink of the request button stream controller.
  StreamSink<bool> get requestButtonSink => _requestButtonController.sink;

  /// Returns the stream of the request button controller.
  Stream<bool> get requestButtonStream => _requestButtonController.stream;

  /// Returns the sink of the submit button stream controller.
  StreamSink<bool> get submitButtonSink => _submitButtonController.sink;

  /// Returns the stream of the submit button controller.
  Stream<bool> get submitButtonStream => _submitButtonController.stream;

  /// Returns the sink of the OTP box width stream controller.
  StreamSink<double> get otpBoxWidthSink => _otpBoxWidthController.sink;

  /// Returns the stream of the OTP box width stream controller.
  Stream<double> get otpBoxWidthStream => _otpBoxWidthController.stream;

  /// Returns the sink of the request password reset otp by phone stream controller.
  StreamSink<ApiResponse> get requestPasswordResetOtpByPhoneSink => _requestPasswordResetOtpByPhoneController.sink;

  /// Returns the stream of the request password reset otp by phone controller.
  Stream<ApiResponse> get requestPasswordResetOtpByPhoneStream => _requestPasswordResetOtpByPhoneController.stream;

  /// Returns the sink of the request password reset otp by email stream controller.
  StreamSink<ApiResponse> get requestPasswordResetOtpByEmailSink => _requestPasswordResetOtpByEmailController.sink;

  /// Returns the stream of the request password reset otp by email controller.
  Stream<ApiResponse> get requestPasswordResetOtpByEmailStream => _requestPasswordResetOtpByEmailController.stream;

  /// Returns the sink of the submit password reset otp by phone stream controller.
  StreamSink<ApiResponse<PasswordResetToken>> get submitPasswordResetOtpByPhoneSink => _submitPasswordResetOtpByPhoneController.sink;

  /// Returns the stream of the submit password reset otp by phone controller.
  Stream<ApiResponse<PasswordResetToken>> get submitPasswordResetOtpByPhoneStream => _submitPasswordResetOtpByPhoneController.stream;

  /// Returns the sink of the submit password reset otp by email stream controller.
  StreamSink<ApiResponse<PasswordResetToken>> get submitPasswordResetOtpByEmailSink => _submitPasswordResetOtpByEmailController.sink;

  /// Returns the stream of the submit password reset otp by email controller.
  Stream<ApiResponse<PasswordResetToken>> get submitPasswordResetOtpByEmailStream => _submitPasswordResetOtpByEmailController.stream;

  ForgotPasswordOtpBloc() {
    _requestButtonController = StreamController<bool>();
    _submitButtonController = StreamController<bool>();
    _otpBoxWidthController = StreamController<double>();
    _requestPasswordResetOtpByPhoneController = StreamController<ApiResponse>.broadcast();
    _requestPasswordResetOtpByEmailController = StreamController<ApiResponse>.broadcast();
    _submitPasswordResetOtpByPhoneController = StreamController<ApiResponse<PasswordResetToken>>.broadcast();
    _submitPasswordResetOtpByEmailController = StreamController<ApiResponse<PasswordResetToken>>.broadcast();
    _userRepository = UserRepository();
  }

  /// Requests a reset password OTP by phone.
  requestPasswordResetOtpByPhone(RequestPasswordResetOtpByPhoneParameters parameters) async {
    requestPasswordResetOtpByPhoneSink.add(ApiResponse.loading());
    try {
      await _userRepository.requestPasswordResetOtpByPhone(parameters);
      requestPasswordResetOtpByPhoneSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      requestPasswordResetOtpByPhoneSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      requestPasswordResetOtpByPhoneSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  /// Requests a reset password OTP by email.
  requestPasswordResetOtpByEmail(RequestPasswordResetOtpByEmailParameters parameters) async {
    requestPasswordResetOtpByEmailSink.add(ApiResponse.loading());
    try {
      await _userRepository.requestPasswordResetOtpByEmail(parameters);
      requestPasswordResetOtpByEmailSink.add(ApiResponse.success(null));
    } on AppException catch (e) {
      requestPasswordResetOtpByEmailSink.add(ApiResponse.error(e.code, e.message));
    } catch (e) {
      requestPasswordResetOtpByEmailSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  /// Submits a reset password OTP by phone.
  submitPasswordResetOtpByPhone(SubmitPasswordResetOtpByPhoneParameters parameters) async {
    submitPasswordResetOtpByPhoneSink.add(ApiResponse<PasswordResetToken>.loading());
    try {
      PasswordResetToken token = await _userRepository.submitPasswordResetOtpByPhone(parameters);
      submitPasswordResetOtpByPhoneSink.add(ApiResponse<PasswordResetToken>.success(token));
    } on AppException catch (e) {
      submitPasswordResetOtpByPhoneSink.add(ApiResponse<PasswordResetToken>.error(e.code, e.message));
    } catch (e) {
      submitPasswordResetOtpByPhoneSink.add(ApiResponse<PasswordResetToken>.error(0, e.toString()));
    }
  }

  /// Submits a reset password OTP by email.
  submitPasswordResetOtpByEmail(SubmitPasswordResetOtpByEmailParameters parameters) async {
    submitPasswordResetOtpByEmailSink.add(ApiResponse<PasswordResetToken>.loading());
    try {
      PasswordResetToken token = await _userRepository.submitPasswordResetOtpByEmail(parameters);
      submitPasswordResetOtpByEmailSink.add(ApiResponse<PasswordResetToken>.success(token));
    } on AppException catch (e) {
      submitPasswordResetOtpByEmailSink.add(ApiResponse<PasswordResetToken>.error(e.code, e.message));
    } catch (e) {
      submitPasswordResetOtpByEmailSink.add(ApiResponse<PasswordResetToken>.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _requestButtonController?.close();
    _submitButtonController?.close();
    _otpBoxWidthController?.close();
    _requestPasswordResetOtpByPhoneController?.close();
    _requestPasswordResetOtpByEmailController?.close();
    _submitPasswordResetOtpByPhoneController?.close();
    _submitPasswordResetOtpByEmailController?.close();
  }
}
