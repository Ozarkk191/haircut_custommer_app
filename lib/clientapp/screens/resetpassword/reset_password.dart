import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/text_back.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Reset Password screen.
class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _password = "";
  String _passwordRepeat = "";

  bool _check() {
    if (_password == "" || _passwordRepeat == "") {
      return false;
    } else if (_passwordRepeat != _password) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);

    //ignore: close_sinks
    final ValidateBloc _bloc = context.bloc<ValidateBloc>();
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextBack(),
          Container(
            child: Text(
              tr('reset_password_title'),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
            ),
          ),
          BlocBuilder<ValidateBloc, ValidateState>(
              builder: (BuildContext context, ValidateState state) {
            if (state is PasswordErrorState) {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('reset_password_password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  _bloc.add(PasswordFieldEvent(value: value));
                  setState(() {
                    _password = value;
                  });
                },
                errorText: state.errorText,
              );
            } else {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('reset_password_password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  _bloc.add(PasswordFieldEvent(value: value));
                  setState(() {
                    _password = value;
                  });
                },
              );
            }
          }),
          BlocBuilder<ValidateBloc, ValidateState>(
              builder: (BuildContext context, ValidateState state) {
            if (state is RepeatPasswordErrorState) {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('reset_password_repeat_password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  _bloc.add(RepeatPasswordFieldEvent(
                    repeat: value,
                    password: _password,
                  ));
                  setState(() {
                    _passwordRepeat = value;
                  });
                },
                errorText: state.errorText,
              );
            } else {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('reset_password_repeat_password'),
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (value) {
                  _bloc.add(RepeatPasswordFieldEvent(
                    repeat: value,
                    password: _password,
                  ));
                  setState(() {
                    _passwordRepeat = value;
                  });
                },
              );
            }
          }),
          SizedBox(height: 20),
          BigRoundButton(
            textButton: tr('btn_submit'),
            callback: !_check() ? null : () {},
            color: !_check() ? Colors.grey : Color(0xffdd133b),
          ),
        ],
      ),
    );
  }
}
