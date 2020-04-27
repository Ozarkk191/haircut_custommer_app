import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/screen/forgotpassword/forgot_password_screen.dart';
import 'package:haircut_delivery/screen/register/register_screen.dart';
import 'package:haircut_delivery/ui/textfield/big_round_textfield.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Login screen for logging in with normal login method or using Facebook login.
class LoginScreen extends StatefulWidget {
  final String message;

  LoginScreen({this.message, Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _phone = "";
  String _password = "";

  bool _check() {
    if (_phone == "" || _password == "") {
      return false;
    } else if (_phone.length < 10) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Image(
                  image: AssetImage('assets/images/logo_white.png'),
                  height: 154,
                  color: Theme.of(context).primaryColor,
                ),
                BlocBuilder<ValidateBloc, ValidateState>(
                    builder: (BuildContext context, ValidateState state) {
                  if (state is PhoneErrorState) {
                    return BigRoundTextField(
                      marginTop: 20,
                      hintText: 'Phone Number',
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
                      hintText: 'Phone Number',
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
                BlocBuilder<ValidateBloc, ValidateState>(
                    builder: (BuildContext context, ValidateState state) {
                  if (state is PasswordErrorState) {
                    return BigRoundTextField(
                      marginTop: 20,
                      hintText: 'Password',
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
                      hintText: 'Password',
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 40, top: 5),
                    child: Text(
                      'forgot password',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                BigRoundButton(
                  callback: !_check() ? null : () {},
                  textButton: 'LOGIN',
                  color: !_check() ? Colors.grey : Color(0xffdd133b),
                ),
                SizedBox(
                  height: 20,
                ),
                BigRoundButton(
                  callback: () {},
                  textButton: 'Login With Facebook',
                  color: Color(0xff4167B2),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Please register if you are not yet a member.',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                BigRoundButton(
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  textButton: 'Register',
                  color: Color(0xff444444),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Logs in with Facebook.
  // _logInWithFacebook() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logIn(['email']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final token = result.accessToken.token;
  //       final graphResponse = await http.get(
  //           'https://graph.facebook.com/v2.12/me?fields=id,email,first_name,last_name&access_token=$token');
  //       final profile = json.decode(graphResponse.body);

  //       // Sends data received from Facebook API to log in with our web service.
  //       _bloc.logInWithFacebook(LogInWithFacebookParameters(
  //           token, profile['id'], profile['email']));
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       // Do nothing.
  //       break;
  //     case FacebookLoginStatus.error:
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return ErrorDialog(message: result.errorMessage);
  //         },
  //       );
  //       break;
  //   }
  // }

  // /// Goes to the Register screen. Sends [email], [firstName], and [lastName] along.
  // _goToRegisterScreen(String email, String firstName, String lastName) async {
  //   String result = await Navigator.push(
  //     context,
  //     new MaterialPageRoute(
  //       builder: (BuildContext context) => new RegisterScreen(
  //         email: email,
  //         firstName: firstName,
  //         lastName: lastName,
  //       ),
  //       fullscreenDialog: true,
  //     ),
  //   );

  //   // Show the result message.
  //   if (result != null) {
  //     Toast.show(result, context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
  //   }
  // }
}
