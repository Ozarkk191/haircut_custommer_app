import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:haircut_delivery/page/base_components/buttons/button.dart';
import 'package:haircut_delivery/page/base_components/dialog/dialog.dart';
import 'package:haircut_delivery/page/screens/login/login_screen.dart';
import 'package:haircut_delivery/repository/user_repository.dart';

/// Primary drawer.
class PrimaryDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 25),
                ListTile(
                  title: Text('menu_policy'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('menu_terms'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('menu_contact'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('menu_language'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      FutureBuilder(
                          future: _fetchAppVersion(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Text('app_version');
                            }
                            return Container();
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text: 'menu_log_out',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmDialog(
                                    message: 'message_confirm_log_out',
                                    onConfirmed: () {
                                      _logOut(context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Returns the app's version name.
Future<String> _fetchAppVersion() async {
  String projectCode;
  try {
    projectCode = await GetVersion.projectVersion;
  } on PlatformException {
    projectCode = '-';
  }
  return projectCode;
}

/// Logs out.
Future _logOut(BuildContext context) async {
  await UserRepository.logOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false);
}
