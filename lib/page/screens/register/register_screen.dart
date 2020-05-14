import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/model/user.dart';
import 'package:haircut_delivery/page/base_components/buttons/big_round_button.dart';
import 'package:haircut_delivery/page/base_components/textfield/big_round_textfield.dart';
import 'package:haircut_delivery/page/base_components/title/title.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Register screen.
class RegisterScreen extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;

  RegisterScreen({this.email, this.firstName, this.lastName, Key key})
      : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Form keys
  final _registerFormKey = GlobalKey<FormState>();

  Gender _gender;
  String _firstname = "";
  String _lastname = "";
  String _phonenumber = "";
  String _email = "";
  String _password = "";
  String _passwordRepeat = "";

  final _inputPaddingBottom = EdgeInsets.only(bottom: 15);
  final _genderInputTextColor = Color(0x88707070);

  bool _check() {
    if (_firstname == "" ||
        _lastname == "" ||
        _phonenumber == "" ||
        _email == "" ||
        _password == "" ||
        _passwordRepeat == "") {
      return false;
    } else if (_phonenumber.length < 10) {
      return false;
    } else if (_passwordRepeat != _password) {
      return false;
    } else if (!_email.contains("@") || !_email.contains(".com")) {
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
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                TransparentToolBar(),
                ScreenTitle(title: tr('register_title')),
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 5,
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          children: <Widget>[
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is FirstErrorState) {
                                return BigRoundTextField(
                                  hintText: tr('register_first_name'),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc
                                        .add(FirstnameFieldEvent(value: value));
                                    setState(() {
                                      _firstname = value;
                                    });
                                  },
                                  errorText: state.errorText,
                                );
                              } else {
                                return BigRoundTextField(
                                  hintText: tr('register_first_name'),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc
                                        .add(FirstnameFieldEvent(value: value));
                                    setState(() {
                                      _firstname = value;
                                    });
                                  },
                                );
                              }
                            }),
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is LastErrorState) {
                                return BigRoundTextField(
                                  marginTop: 20,
                                  hintText: tr('register_last_name'),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(LastnameFieldEvent(value: value));
                                    setState(() {
                                      _lastname = value;
                                    });
                                  },
                                  errorText: state.errorText,
                                );
                              } else {
                                return BigRoundTextField(
                                  marginTop: 20,
                                  hintText: tr('register_last_name'),
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(LastnameFieldEvent(value: value));
                                    setState(() {
                                      _lastname = value;
                                    });
                                  },
                                );
                              }
                            }),
                            Padding(
                              padding: _inputPaddingBottom,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: Gender.MALE,
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    tr('register_male'),
                                    style:
                                        TextStyle(color: _genderInputTextColor),
                                  ),
                                  SizedBox(width: 25),
                                  Radio(
                                    value: Gender.FEMALE,
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    tr('register_female'),
                                    style:
                                        TextStyle(color: _genderInputTextColor),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is PhoneErrorState) {
                                return BigRoundTextField(
                                  hintText: tr('register_phone'),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    _bloc.add(
                                        PhoneNumberFieldEvent(value: value));
                                    setState(() {
                                      _phonenumber = value;
                                    });
                                  },
                                  errorText: state.errorText,
                                );
                              } else {
                                return BigRoundTextField(
                                  hintText: tr('register_phone'),
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    _bloc.add(
                                        PhoneNumberFieldEvent(value: value));
                                    setState(() {
                                      _phonenumber = value;
                                    });
                                  },
                                );
                              }
                            }),
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is EmailErrorState) {
                                return BigRoundTextField(
                                  marginTop: 20,
                                  hintText: tr('register_email'),
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
                                  hintText: tr('register_email'),
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
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is PasswordErrorState) {
                                return BigRoundTextField(
                                  marginTop: 20,
                                  hintText: tr('register_password'),
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
                                  hintText: tr('register_password'),
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
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is RepeatPasswordErrorState) {
                                return BigRoundTextField(
                                  marginTop: 20,
                                  hintText: tr('register_repeat_password'),
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
                                  hintText: tr('register_repeat_password'),
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
                            SizedBox(height: 30),
                            BigRoundButton(
                              callback: !_check() ? null : () {},
                              textButton: tr('register_submit_button'),
                              color:
                                  !_check() ? Colors.grey : Color(0xffdd133b),
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
          ],
        ),
      ),
    );
  }
}
