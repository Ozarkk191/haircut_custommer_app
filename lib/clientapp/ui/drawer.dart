import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:haircut_delivery/clientapp/screens/login/login_screen.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/button.dart';
import 'package:haircut_delivery/clientapp/ui/dialog.dart';
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
                  title: Text(AppLocalizations.of(context).tr('menu_policy')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).tr('menu_terms')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).tr('menu_contact')),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).tr('menu_language')),
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
                              return Text(AppLocalizations.of(context)
                                  .tr('app_version', args: [snapshot.data]));
                            }
                            return Container();
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: double.infinity,
                          child: PrimaryButton(
                            text:
                                AppLocalizations.of(context).tr('menu_log_out'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmDialog(
                                    message: AppLocalizations.of(context)
                                        .tr('message_confirm_log_out'),
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
