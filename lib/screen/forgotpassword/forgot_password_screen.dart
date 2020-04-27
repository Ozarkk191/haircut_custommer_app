import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/screen/forgotpasswordotp/forgot_password_otp.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/title.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Forgot Password screen.
class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);

    return EasyLocalizationProvider(
      data: EasyLocalizationProvider.of(context).data,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              TransparentToolBar(),
              ScreenTitle(title: AppLocalizations.of(context).tr('forgot_password_title')),
              Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: AppLocalizations.of(context).tr('forgot_password_otp'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) => new ForgotPasswordOtpScreen(method: ResetPasswordMethod.PHONE)));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              text: AppLocalizations.of(context).tr('forgot_password_email'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => new ForgotPasswordOtpScreen(method: ResetPasswordMethod.EMAIL)));
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
        ),
      ),
    );
  }
}
