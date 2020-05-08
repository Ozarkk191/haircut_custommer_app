import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/ui/loading_screen.dart';
import 'package:haircut_delivery/clientapp/ui/text_field.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/user.dart';
import 'package:haircut_delivery/util/ui_util.dart';

/// Profile screen.
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Constants
  final _inputPaddingBottom = EdgeInsets.only(bottom: 15);
  final _genderInputTextColor = Color(0x88707070);

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(Theme.of(context).primaryColor);

    return EasyLocalizationProvider(
      data: EasyLocalizationProvider.of(context).data,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  PrimaryToolBar(
                      title: AppLocalizations.of(context).tr('profile_title')),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 5,
                        child: StreamBuilder<ApiResponse<User>>(
                            builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data.data != null) {
                            final user = snapshot.data.data;
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 10),
                                  child: Center(
                                    child: SizedBox(
                                      width: 135,
                                      height: 135,
                                      child: CircularProfileAvatar(
                                        user.avatarUrl,
                                        radius: 135,
                                        borderWidth: 4,
                                        borderColor: Color(0xFF707070),
                                        cacheImage: true,
                                        placeHolder: (context, url) =>
                                            LoadingIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .tr('profile_profile'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                          'assets/images/ic_edit.png'),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Divider(
                                    color: const Color(0xFFBDBDBD),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryTextFormField(
                                    hintText: user.firstName ??
                                        AppLocalizations.of(context)
                                            .tr('profile_first_name'),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryTextFormField(
                                    hintText: user.lastName ??
                                        AppLocalizations.of(context)
                                            .tr('profile_last_name'),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Radio(
                                        value: Gender.MALE,
                                        groupValue: user.gender,
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('profile_gender_male'),
                                        style: TextStyle(
                                            color: _genderInputTextColor),
                                      ),
                                      SizedBox(width: 25),
                                      Radio(
                                        value: Gender.FEMALE,
                                        groupValue: user.gender,
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .tr('profile_gender_female'),
                                        style: TextStyle(
                                            color: _genderInputTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .tr('profile_account'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                            'assets/images/ic_edit.png'),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Divider(
                                    color: const Color(0xFFBDBDBD),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryTextFormField(
                                    hintText: user.phone ??
                                        AppLocalizations.of(context)
                                            .tr('profile_phone'),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryTextFormField(
                                    hintText: user.email ??
                                        AppLocalizations.of(context)
                                            .tr('profile_email'),
                                    enabled: false,
                                  ),
                                ),
                                Padding(
                                  padding: _inputPaddingBottom,
                                  child: PrimaryTextFormField(
                                    hintText: '********',
                                    enabled: false,
                                  ),
                                ),
                              ],
                            );
                          }
                          return LoadingIndicator();
                        }),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
