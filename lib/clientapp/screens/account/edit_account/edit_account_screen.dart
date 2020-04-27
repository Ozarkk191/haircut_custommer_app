import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_normal_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/text_line.dart';
import 'package:haircut_delivery/ui/textfield/big_round_textfield.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String _phone = "";
  String _email = "";
  String _password = "";
  String _passwordRepeat = "";

  bool _check() {
    if (_phone == "" ||
        _password == "" ||
        _passwordRepeat == "" ||
        _email == "") {
      return false;
    } else if (_passwordRepeat != _password) {
      return false;
    } else if (_phone.length != 10) {
      return false;
    } else if (!_email.contains('@')) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final ValidateBloc _bloc = context.bloc<ValidateBloc>();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 120),
                  TextLine(title: 'บัญชีผู้ใช้'),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is PhoneErrorState) {
                      return BigRoundTextField(
                        hintText: 'Phonenumber',
                        marginTop: 20,
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
                        hintText: 'Phonenumber',
                        marginTop: 20,
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
                    if (state is EmailErrorState) {
                      return BigRoundTextField(
                        hintText: 'Email',
                        marginTop: 20,
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
                        hintText: 'Email',
                        marginTop: 20,
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
                  SizedBox(height: 40),
                  TextLine(title: 'password'),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is PasswordErrorState) {
                      return BigRoundTextField(
                        hintText: 'New Password',
                        marginTop: 20,
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                        hintText: 'New Password',
                        marginTop: 20,
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                        hintText: 'Password (Repeat)',
                        marginTop: 20,
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                        hintText: 'Password (Repeat)',
                        marginTop: 20,
                        obscureText: true,
                        keyboardType: TextInputType.text,
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
                  SizedBox(height: 40),
                  BigRoundButton(
                    callback: () {},
                    color: !_check() ? Colors.grey : Color(0xffDD133B),
                    textButton: 'Save',
                  )
                ],
              ),
            ),
          ),
          ClientAppNormalAppBar(title: 'Edit Account')
        ],
      ),
    );
  }
}
