import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/screens/forgotpasswordemail/forgot_password_email.dart';
import 'package:haircut_delivery/clientapp/screens/forgotpasswordotp/forgot_password_otp.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/text_back.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Forgot Password screen.
class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextBack(),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Forget Password',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          BigRoundButton(
            textButton: 'OTP',
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordOtpScreen()));
            },
            color: Color(0xffdd133b),
          ),
          BigRoundButton(
            textButton: 'Email',
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordEmail()));
            },
            color: Color(0xffdd133b),
          ),
        ],
      ),
    );
  }
}
