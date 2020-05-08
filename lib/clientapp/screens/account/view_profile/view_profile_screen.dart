import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_user.dart';
import 'package:haircut_delivery/clientapp/screens/account/edit_account/edit_account_screen.dart';
import 'package:haircut_delivery/clientapp/screens/account/edit_profile/edit_profile_screen.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_normal_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/avatar/custom_circle_avatar.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/text_edit_line.dart';
import 'package:haircut_delivery/clientapp/ui/textfield/big_round_textfield.dart';
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
                    title: 'ข้อมูลผู้ใช้',
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: "First Name",
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: "Last Name",
                  ),
                  _buildRadio(),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: "Adderss",
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: "Adderss",
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
                      title: 'บัญชีผู้ใช้'),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: 'Phone Number',
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: 'Email',
                  ),
                  BigRoundTextField(
                    marginTop: 20,
                    enabled: false,
                    hintText: 'Password',
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          ClientAppNormalAppBar(title: 'View Profile')
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
            'Male',
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
            'Female',
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
            'Other',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
