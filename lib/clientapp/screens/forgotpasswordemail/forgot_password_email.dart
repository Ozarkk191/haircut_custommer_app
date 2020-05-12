import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/screens/resetpassword/reset_password.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/text_back.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';

class ForgotPasswordEmail extends StatefulWidget {
  @override
  _ForgotPasswordEmailState createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  String _email = "";
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final ValidateBloc _bloc = context.bloc<ValidateBloc>();
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextBack(),
          Container(
            child: Text(
              tr('forgot_password_otp_email_instruction'),
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BlocBuilder<ValidateBloc, ValidateState>(
              builder: (BuildContext context, ValidateState state) {
            if (state is EmailErrorState) {
              return BigRoundTextField(
                marginTop: 20,
                hintText: 'Email',
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _bloc.add(EmailFieldEvent(value: value));
                  setState(() {
                    _email = value;
                  });
                },
                errorText: state.errorText,
              );
            } else {
              return BigRoundTextField(
                marginTop: 20,
                hintText: 'Email',
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _bloc.add(EmailFieldEvent(value: value));
                  setState(() {
                    _email = value;
                  });
                },
              );
            }
          }),
          SizedBox(height: 20),
          BigRoundButton(
            textButton: tr('btn_submit'),
            callback: _email == ""
                ? null
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen()));
                  },
            color: _email == "" ? Colors.grey : Color(0xffdd133b),
          )
        ],
      ),
    );
  }
}
