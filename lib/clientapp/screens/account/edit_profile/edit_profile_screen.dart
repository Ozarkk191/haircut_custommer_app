import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_user.dart';
import 'package:haircut_delivery/clientapp/screens/account/address/add_address_screen.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_normal_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/avatar/edit_circle_avatar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/big_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/text_line.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:haircut_delivery/model/user.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Gender _gender;
  String _firstname = "";
  String _lastname = "";
  String _address = "";

  bool _check() {
    if (_firstname == "" || _lastname == "" || _address == "") {
      return false;
    } else {
      return true;
    }
  }

  // _getStringAddress() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   String stringValue = prefs.getString('address_string') ?? "";

  //   return stringValue;
  // }

  @override
  void initState() {
    super.initState();
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
                  SizedBox(height: 100),
                  EditCircleAvatar(
                    user: clientAppUser,
                    width: 100,
                    height: 100,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 10),
                  TextLine(title: tr('profile_profile')),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is FirstErrorState) {
                      return BigRoundTextField(
                        hintText: tr('profile_first_name'),
                        marginTop: 10,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(FirstnameFieldEvent(value: value));
                          setState(() {
                            _firstname = value;
                          });
                        },
                        errorText: state.errorText,
                      );
                    } else {
                      return BigRoundTextField(
                        hintText: tr('profile_first_name'),
                        marginTop: 10,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _bloc.add(FirstnameFieldEvent(value: value));
                          setState(() {
                            _firstname = value;
                          });
                        },
                      );
                    }
                  }),
                  BlocBuilder<ValidateBloc, ValidateState>(
                      builder: (BuildContext context, ValidateState state) {
                    if (state is LastErrorState) {
                      return BigRoundTextField(
                        marginTop: 10,
                        hintText: tr('profile_last_name'),
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
                        marginTop: 10,
                        hintText: tr('profile_last_name'),
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
                  _buildRadio(),
                  BigRoundTextField(
                    marginTop: 10,
                    hintText: tr('profile_address_work'),
                  ),
                  BigRoundTextField(
                    marginTop: 10,
                    hintText: tr('add_my_place_address'),
                    maxLines: 4,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  BigRoundButton(
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressScreen()));
                    },
                    textButton: tr('edit_profile_add_address_button'),
                    color: Color(0xff444444),
                  ),
                  SizedBox(height: 10),
                  BigRoundButton(
                    callback: !_check() ? null : () {},
                    textButton: tr('btn_save'),
                    color: Color(0xffDD133B),
                  )
                ],
              ),
            ),
          ),
          ClientAppNormalAppBar(title: tr('edit_profile_title'))
        ],
      ),
    );
  }

  Container _buildRadio() {
    return Container(
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
            tr('profile_gender_male'),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(width: 10),
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
            tr('profile_gender_female'),
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(width: 10),
          Radio(
            value: Gender.OTHER,
            groupValue: _gender,
            onChanged: (value) {
              setState(() {
                _gender = value;
              });
            },
          ),
          Text(
            tr('profile_gender_other'),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
