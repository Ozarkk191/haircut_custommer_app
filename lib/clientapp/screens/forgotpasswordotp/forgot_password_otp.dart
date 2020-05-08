import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextBack(),
          Container(
            child: Text(
              'Please enter phone number\nTo receive the OTP code',
              style: TextStyle(color: Colors.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          BigRoundTextField(
            hintText: 'Number Phone',
            marginTop: 20,
          ),
          BigRoundButton(
            textButton: 'Request OTP',
            callback: () {},
            color: Color(0xffcccccc),
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
              pinTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BigRoundButton(
            textButton: 'Submit OTP',
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
