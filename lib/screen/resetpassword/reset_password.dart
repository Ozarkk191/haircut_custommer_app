import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/bloc/reset_password_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/reset_password.dart';
import 'package:haircut_delivery/screen/login/login_screen.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/dialog.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/text_field.dart';
import 'package:haircut_delivery/ui/title.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Reset Password screen.
class ResetPasswordScreen extends StatefulWidget {
  final String resetToken;

  ResetPasswordScreen({this.resetToken, Key key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // BLoC
  final _bloc = ResetPasswordBloc();

  // Form keys
  final _resetPasswordFormKey = GlobalKey<FormState>();

  // Input controllers
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  // Focus nodes
  final _repeatPasswordFocusNode = FocusNode();

  // Constants
  final _inputPaddingBottom = EdgeInsets.only(bottom: 15);

  @override
  void initState() {
    super.initState();

    // Listens for the result of resetting password.
    _bloc.resetPasswordStream.listen((data) {
      switch (data.status) {
        case ResponseStatus.SUCCESS:
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen(message: AppLocalizations.of(context).tr('message_success'))), (Route<dynamic> route) => false);
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
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
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
                  ScreenTitle(title: AppLocalizations.of(context).tr('reset_password_title')),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 5,
                        child: Form(
                          key: _resetPasswordFormKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: _inputPaddingBottom,
                                child: PrimaryTextFormField(
                                  controller: _passwordController,
                                  hintText: AppLocalizations.of(context).tr('reset_password_password'),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).tr('reset_password_error_password_blank');
                                    }
                                    if ((value as String).length < 8) {
                                      return AppLocalizations.of(context).tr('reset_password_error_password_length');
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(_repeatPasswordFocusNode);
                                  },
                                ),
                              ),
                              Padding(
                                padding: _inputPaddingBottom * 2,
                                child: PrimaryTextFormField(
                                  controller: _repeatPasswordController,
                                  hintText: AppLocalizations.of(context).tr('reset_password_repeat_password'),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  focusNode: _repeatPasswordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context).tr('reset_password_error_repeat_password_blank');
                                    }
                                    if (_passwordController.text != value) {
                                      return AppLocalizations.of(context).tr('reset_password_error_repeat_password_not_match');
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryButton(
                                    text: AppLocalizations.of(context).tr('btn_submit'),
                                    onPressed: () {
                                      if (_resetPasswordFormKey.currentState.validate()) {
                                        _bloc.resetPassword(ResetPasswordParameters(widget.resetToken, _passwordController.text));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ],
              ),
              StreamBuilder<ApiResponse>(
                stream: _bloc.resetPasswordStream,
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
