import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/marketplace_colors.dart';
import 'package:haircut_delivery/clientapp/screens/points/client_app_my_point_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';

/// Primary drawer.
class ClientAppDrawer extends StatefulWidget {
  final Color bgColor;

  const ClientAppDrawer(
      {Key key, this.bgColor = MarketplaceColors.PRIMARY_COLOR})
      : super(key: key);

  @override
  _ClientAppDrawerState createState() => _ClientAppDrawerState();
}

class _ClientAppDrawerState extends State<ClientAppDrawer> {
  bool isSwitched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == 'en') {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  setNewLocale(BuildContext context, Locale locale) {
    context.locale = locale;
  }

  // void _handleChangeLanguageSwitcher(bool value, data) {
  //   setState(() {
  //     isSwitched = value;
  //     if (value) {
  //       setNewLocale(
  //         context,
  //         EasyLocalization.of(context).supportedLocales[0],
  //       );
  //     } else {
  //       setNewLocale(
  //         context,
  //         EasyLocalization.of(context).supportedLocales[1],
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var data = EasyLocalizationProvider.of(context).data;

    return Drawer(
      child: Container(
        color: widget.bgColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 25),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          tr('marketplace_point'),
                          style: _drawerTextStyle(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset(
                                    'assets/marketplace/images/ic_bluecoin.png'),
                                SizedBox(width: 5),
                                Text(
                                  '99,9999',
                                  style: textStyleWithLocale(
                                    context: context,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              tr('marketplace_exchange_for_coupon'),
                              style: textStyleWithLocale(
                                context: context,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        SlideUpTransition(
                          child: ClientAppMyPointPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      tr('marketplace_menu_policy'),
                      style: _drawerTextStyle(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   SlideUpTransition(
                      //     child: ClientAppContentPage(
                      //       appbarTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_policy')}',
                      //       contentTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_policy')}',
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  ListTile(
                    title: Text(
                      tr('marketplace_menu_terms_and_conditions'),
                      style: _drawerTextStyle(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   SlideUpTransition(
                      //     child: ClientAppContentPage(
                      //       appbarTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_terms_and_conditions')}',
                      //       contentTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_terms_and_conditions')}',
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  ListTile(
                    title: Text(
                      tr('marketplace_menu_contact'),
                      style: _drawerTextStyle(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   SlideUpTransition(
                      //     child: ClientAppContentPage(
                      //       appbarTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_contact')}',
                      //       contentTitle:
                      //           '${AppLocalizations.of(context).tr('marketplace_menu_contact')}',
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  // ListTile(
                  //   title: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Text(
                  //         AppLocalizations.of(context)
                  //             .tr('marketplace_menu_language'),
                  //         style: _drawerTextStyle(),
                  //       ),
                  //       Row(
                  //         children: <Widget>[
                  //           Text(
                  //             AppLocalizations.of(context)
                  //                 .tr('marketplace_language_th'),
                  //             style: _drawerTextStyle(),
                  //           ),
                  //           Switch(
                  //             value: isSwitched,
                  //             onChanged: (value) =>
                  //                 _handleChangeLanguageSwitcher(value, data),
                  //             activeTrackColor:
                  //                 MarketplaceColors.LANGUAGE_SWITCH_COLOR,
                  //             activeColor: Colors.white,
                  //             inactiveTrackColor:
                  //                 MarketplaceColors.LANGUAGE_SWITCH_COLOR,
                  //             inactiveThumbColor: Colors.white,
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)
                  //                 .tr('marketplace_language_en'),
                  //             style: _drawerTextStyle(),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            ),
            // Container(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15),
            //       child: Container(
            //         child: Column(
            //           children: <Widget>[
            //             FutureBuilder(
            //                 future: _fetchAppVersion(),
            //                 builder: (context, snapshot) {
            //                   if (snapshot.data != null) {
            //                     return Text(AppLocalizations.of(context).tr(
            //                         'app_version',
            //                         args: [snapshot.data]));
            //                   }
            //                   return Container();
            //                 }),
            //             Padding(
            //               padding: const EdgeInsets.only(top: 5),
            //               child: SizedBox(
            //                 width: double.infinity,
            //                 child: PrimaryButton(
            //                   text: AppLocalizations.of(context)
            //                       .tr('menu_log_out'),
            //                   onPressed: () {
            //                     showDialog(
            //                       context: context,
            //                       builder: (BuildContext context) {
            //                         return ConfirmDialog(
            //                           message: AppLocalizations.of(context)
            //                               .tr('message_confirm_log_out'),
            //                           onConfirmed: () {
            //                             _logOut(context);
            //                           },
            //                         );
            //                       },
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  TextStyle _drawerTextStyle() {
    return textStyleWithLocale(
      context: context,
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w300,
    );
  }
}

// /// Returns the app's version name.
// Future<String> _fetchAppVersion() async {
//   String projectCode;
//   try {
//     projectCode = await GetVersion.projectVersion;
//   } on PlatformException {
//     projectCode = '-';
//   }
//   return projectCode;
// }

// /// Logs out.
// Future _logOut(BuildContext context) async {
//   await UserRepository.logOut();
//   Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//       (Route<dynamic> route) => false);
// }
