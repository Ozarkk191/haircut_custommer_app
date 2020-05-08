import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);

    return Scaffold(
      body: Column(
        children: <Widget>[
          TextBack(),
          Container(
            child: Text(
              'Reset Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
            ),
          ),
          BigRoundTextField(
            hintText: 'Password',
            marginTop: 20,
          ),
          BigRoundTextField(
            hintText: 'Password (Repeat)',
            marginTop: 20,
          ),
          SizedBox(height: 20),
          BigRoundButton(
            textButton: 'Submit',
            callback: () {},
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
