import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_user.dart';
import 'package:haircut_delivery/clientapp/screens/account/edit_account/edit_account_screen.dart';
import 'package:haircut_delivery/clientapp/screens/account/edit_profile/edit_profile_screen.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_normal_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/avatar/custom_circle_avatar.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/text_edit_line.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:haircut_delivery/model/user.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  Gender _gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  CustomCircleAvatar(
                    user: clientAppUser,
                    width: 100,
                    height: 100,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextEditLine(
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()));
                    },
                    title: tr('profile_profile'),
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr("profile_first_name"),
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr("profile_last_name"),
                  ),
                  _buildRadio(),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr("profile_address_home"),
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr("add_my_place_address"),
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  TextEditLine(
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditAccountScreen()));
                      },
                      title: tr('profile_account')),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr('profile_phone'),
                  ),
                  BigRoundTextField(
                      marginTop: 20,
                      enabled: false,
                      hintText: tr(
                        'profile_email',
                      )),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: tr('profile_password'),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          ClientAppNormalAppBar(title: tr('profile_title'))
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
