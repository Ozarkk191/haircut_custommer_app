import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/bloc/forgot_password_otp_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/reset_password.dart';
import 'package:haircut_delivery/screen/resetpassword/reset_password.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/dialog.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/text_field.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

/// Forgot Password OTP screen.
class ForgotPasswordOtpScreen extends StatefulWidget {
  final ResetPasswordMethod method;

  ForgotPasswordOtpScreen({this.method, Key key}) : super(key: key);

  @override
  _ForgotPasswordOtpScreenState createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  // BLoC
  final _bloc = ForgotPasswordOtpBloc();

  // Global eys
  final _requestFormKey = GlobalKey<FormState>();
  final _centralColumnKey = GlobalKey();

  // Input controllers
  final _identityController = TextEditingController();
  final _otpController = TextEditingController();
  final _otpLength = 4;

  @override
  void initState() {
    // Get the width of the central column. We will use this value to determine
    // the width of each OTP box.
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final RenderBox renderBox =
          _centralColumnKey.currentContext.findRenderObject();
      final width =
          (renderBox.size.width - 45) / _otpLength; // 45 is the padding.
      _bloc.otpBoxWidthSink.add(width);
    });

    super.initState();

    // Listen for the result of requesting an OTP.
    _bloc.requestPasswordResetOtpByPhoneStream.listen((data) {
      switch (data.status) {
        case ResponseStatus.SUCCESS:
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SuccessDialog(
                  message: AppLocalizations.of(context).tr(
                      'forgot_password_otp_success_request',
                      args: [_identityController.text]));
            },
          );
          break;
        case ResponseStatus.ERROR:
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(message: data.message);
            },
          );
          break;
        default: // Do nothing.
      }
    });

    // Listen for the result of submitting an OTP.
    if (widget.method == ResetPasswordMethod.PHONE) {
      _bloc.submitPasswordResetOtpByPhoneStream.listen((response) {
        _handleSubmitOtpResult(response);
      });
    } else {
      _bloc.submitPasswordResetOtpByEmailStream.listen((response) {
        _handleSubmitOtpResult(response);
      });
    }
  }

  /// Handles the result from calling the web service for submitting an OTP.
  _handleSubmitOtpResult(ApiResponse<PasswordResetToken> response) {
    switch (response.status) {
      case ResponseStatus.SUCCESS:
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new ResetPasswordScreen(
                    resetToken: response.data.resetToken)));
        break;
      case ResponseStatus.ERROR:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: response.message);
          },
        );
        break;
      default: // Do nothing.
    }
  }

  @override
  void dispose() {
    _identityController.dispose();
    _otpController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);

    return EasyLocalizationProvider(
      data: EasyLocalizationProvider.of(context).data,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  TransparentToolBar(),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 5,
                        key: _centralColumnKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 45),
                              child: Text(
                                AppLocalizations.of(context).tr(widget.method ==
                                        ResetPasswordMethod.PHONE
                                    ? 'forgot_password_otp_phone_instruction'
                                    : 'forgot_password_otp_email_instruction'),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: SizedBox(
                                width: double.infinity,
                                child: Form(
                                  key: _requestFormKey,
                                  child: PrimaryTextFormField(
                                    controller: _identityController,
                                    hintText: AppLocalizations.of(context).tr(
                                        widget.method ==
                                                ResetPasswordMethod.PHONE
                                            ? 'forgot_password_otp_phone'
                                            : 'forgot_password_otp_email'),
                                    keyboardType: widget.method ==
                                            ResetPasswordMethod.PHONE
                                        ? TextInputType.phone
                                        : TextInputType.emailAddress,
                                    onChanged: (String text) {
                                      if (text.isNotEmpty) {
                                        _bloc.requestButtonSink.add(true);
                                      } else {
                                        _bloc.requestButtonSink.add(false);
                                      }
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context).tr(widget
                                                    .method ==
                                                ResetPasswordMethod.PHONE
                                            ? 'forgot_password_otp_error_phone_blank'
                                            : 'forgot_password_otp_error_email_blank');
                                      }
                                      if (widget.method ==
                                              ResetPasswordMethod.EMAIL &&
                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                        return AppLocalizations.of(context).tr(
                                            'forgot_password_otp_error_email_invalid');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 55),
                              child: SizedBox(
                                width: double.infinity,
                                child: StreamBuilder<bool>(
                                  stream: _bloc.requestButtonStream,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return _buildRequestButton(
                                        context,
                                        snapshot.hasData && snapshot.data,
                                        _requestFormKey,
                                        _identityController,
                                        _bloc,
                                        widget.method);
                                  },
                                ),
                              ),
                            ),
                            StreamBuilder<double>(
                                stream: _bloc.otpBoxWidthStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return _buildOtpBoxes(
                                        _otpController,
                                        _otpLength,
                                        snapshot.data,
                                        _bloc.submitButtonSink);
                                  }
                                  return _buildOtpBoxes(_otpController,
                                      _otpLength, 0, _bloc.submitButtonSink);
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: SizedBox(
                                width: double.infinity,
                                child: StreamBuilder<bool>(
                                  stream: _bloc.submitButtonStream,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return _buildSubmitButton(
                                        context,
                                        snapshot.hasData && snapshot.data,
                                        _requestFormKey,
                                        _identityController,
                                        _otpController,
                                        _otpLength,
                                        _bloc,
                                        widget.method);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  )
                ],
              ),
              StreamBuilder<ApiResponse>(
                stream: widget.method == ResetPasswordMethod.PHONE
                    ? _bloc.requestPasswordResetOtpByPhoneStream
                    : _bloc.requestPasswordResetOtpByEmailStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case ResponseStatus.LOADING:
                        return LoadingScreen();
                      default:
                        return Container();
                    }
                  }
                  return Container();
                },
              ),
              StreamBuilder<ApiResponse>(
                stream: widget.method == ResetPasswordMethod.PHONE
                    ? _bloc.submitPasswordResetOtpByPhoneStream
                    : _bloc.submitPasswordResetOtpByEmailStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case ResponseStatus.LOADING:
                        return LoadingScreen();
                      default:
                        return Container();
                    }
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Builds the OTP boxes that has [pinLength] pin(s). Each box is [boxWidth] in width.
/// The height of each box is equal to its width. [controller] is the text editing controller
/// for the OTP boxes.
Widget _buildOtpBoxes(TextEditingController controller, int pinLength,
    double boxWidth, StreamSink<bool> submitButtonSink) {
  return PinCodeTextField(
    pinBoxWidth: boxWidth,
    pinBoxHeight: boxWidth,
    autofocus: false,
    controller: controller,
    defaultBorderColor: Colors.transparent,
    hasTextBorderColor: Colors.transparent,
    pinBoxColor: const Color(0xFFEEEEEE),
    pinBoxRadius: 5,
    maxLength: pinLength,
    onTextChanged: (text) {
      if (text.length >= pinLength) {
        submitButtonSink.add(true);
      } else {
        submitButtonSink.add(false);
      }
    },
    wrapAlignment: WrapAlignment.spaceBetween,
    pinTextStyle: TextStyle(fontSize: 30.0),
  );
}

/// Builds the Request OTP button. If [isEnabled] is true, the button will be red, otherwise gray.
/// When the user clicks the button, the form indicated by [formKey] will be validated.
/// If pass it will call the web service to request an OTP.
Widget _buildRequestButton(
    BuildContext context,
    bool isEnabled,
    GlobalKey<FormState> formKey,
    TextEditingController identityController,
    ForgotPasswordOtpBloc bloc,
    ResetPasswordMethod method) {
  return PrimaryButton(
    text: AppLocalizations.of(context).tr('forgot_password_otp_request_button'),
    onPressed: isEnabled
        ? () {
            if (formKey.currentState.validate()) {
              if (method == ResetPasswordMethod.PHONE) {
                bloc.requestPasswordResetOtpByPhone(
                    RequestPasswordResetOtpByPhoneParameters(
                        identityController.text));
              } else {
                bloc.requestPasswordResetOtpByEmail(
                    RequestPasswordResetOtpByEmailParameters(
                        identityController.text));
              }
            }
          }
        : null,
  );
}

/// Builds the Submit OTP button. If [isEnabled] is true, the button will be red, otherwise gray.
/// When the user clicks the button, the form indicated by [formKey] will be validated.
/// /// If pass it will call the web service to submit an OTP.
Widget _buildSubmitButton(
    BuildContext context,
    bool isEnabled,
    GlobalKey<FormState> formKey,
    TextEditingController identityController,
    TextEditingController otpController,
    int otpLength,
    ForgotPasswordOtpBloc bloc,
    ResetPasswordMethod method) {
  return PrimaryButton(
    text: AppLocalizations.of(context).tr('forgot_password_otp_submit_button'),
    onPressed: isEnabled
        ? () {
            if (otpController.text.length != otpLength) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                      message: AppLocalizations.of(context)
                          .tr('forgot_password_otp_error_otp_blank'));
                },
              );
              return;
            }
            if (formKey.currentState.validate()) {
              if (method == ResetPasswordMethod.PHONE) {
                bloc.submitPasswordResetOtpByPhone(
                    SubmitPasswordResetOtpByPhoneParameters(
                        identityController.text, otpController.text));
              } else {
                bloc.submitPasswordResetOtpByEmail(
                    SubmitPasswordResetOtpByEmailParameters(
                        identityController.text, otpController.text));
              }
            }
          }
        : null,
  );
}

/// Enumeration for all methods available for resetting password.
enum ResetPasswordMethod { PHONE, EMAIL }
