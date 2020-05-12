import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/screens/resetpassword/reset_password.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/text_back.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  @override
  _ForgotPasswordOtpScreenState createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  String _phone = "";

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
              tr('forgot_password_otp_phone_instruction'),
              style: TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          BlocBuilder<ValidateBloc, ValidateState>(
              builder: (BuildContext context, ValidateState state) {
            if (state is PhoneErrorState) {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('forgot_password_otp_phone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  _bloc.add(PhoneNumberFieldEvent(value: value));
                  setState(() {
                    _phone = value;
                  });
                },
                errorText: state.errorText,
              );
            } else {
              return BigRoundTextField(
                marginTop: 20,
                hintText: tr('forgot_password_otp_phone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  _bloc.add(PhoneNumberFieldEvent(value: value));
                  setState(() {
                    _phone = value;
                  });
                },
              );
            }
          }),
          SizedBox(height: 20),
          BigRoundButton(
            textButton: tr('forgot_password_otp_request_button'),
            callback: _phone == "" ? null : () {},
            color: _phone == "" ? Color(0xffcccccc) : Color(0xffdd133b),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: PinCodeTextField(
              pinBoxHeight: 60,
              pinBoxWidth: 60,
              hasTextBorderColor: Colors.transparent,
              pinBoxRadius: 10,
              wrapAlignment: WrapAlignment.center,
              pinBoxColor: Color(0xffeeeeee),
              defaultBorderColor: Color(0xffeeeeee),
              pinTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BigRoundButton(
            textButton: tr('forgot_password_otp_submit_button'),
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen()));
            },
            color: Color(0xffcccccc),
          ),
        ],
      ),
    );
  }
}
