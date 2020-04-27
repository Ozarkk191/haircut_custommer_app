import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/bloc/user_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/user.dart';
import 'package:haircut_delivery/screen/profile/profile_screen.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';

class AccountPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AccountPage({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin<AccountPage> {
  // BLoC
  final _bloc = UserBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: TOOL_BAR_HEIGHT),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: StreamBuilder<ApiResponse<User>>(
                stream: _bloc.userStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.data != null) {
                    final user = snapshot.data.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Center(
                                child: SizedBox(
                                  width: 75,
                                  height: 75,
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new ProfileScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF444444),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .tr('account_edit_profile'),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(user.fullName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                  _buildGenderIcon(user.gender),
                                ],
                              ),
                              Text(AppLocalizations.of(context).tr(
                                  'account_phone',
                                  args: [user.phone ?? ''])),
                              Text(AppLocalizations.of(context).tr(
                                  'account_email',
                                  args: [user.email ?? ''])),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
      PrimaryToolBar(title: AppLocalizations.of(context).tr('account_title')),
    ]);
  }

  /// Builds a gender icon from the [gender] object.
  Widget _buildGenderIcon(Gender gender) {
    switch (gender) {
      case Gender.MALE:
        return Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('assets/images/ic_male.png'),
        );
      case Gender.FEMALE:
        return Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Image.asset('assets/images/ic_female.png'),
        );
      default:
        return Container();
    }
  }
}
