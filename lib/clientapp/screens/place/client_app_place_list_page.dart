import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_addresses.dart';
import 'package:haircut_delivery/clientapp/models/client_app_address.dart';
import 'package:haircut_delivery/clientapp/screens/address/client_app_add_address_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppPlaceListPage extends StatefulWidget {
  ClientAppPlaceListPage({Key key}) : super(key: key);

  @override
  _ClientAppPlaceListPageState createState() => _ClientAppPlaceListPageState();
}

class _ClientAppPlaceListPageState extends State<ClientAppPlaceListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClientAppDrawer(bgColor: Theme.of(context).primaryColor),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: TOOL_BAR_HEIGHT + 20, left: 15, right: 15),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildLocationBtn(),
                      Container(
                        child: ExpansionTile(
                          title: Row(
                            children: <Widget>[
                              Image.asset('assets/images/ic_coin.png'),
                              SizedBox(width: 5),
                              Text(
                                '${AppLocalizations.of(context).tr('client_app_saved_location')}',
                                style: textStyleWithLocale(
                                  context: context,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          children: clientAppAddresses
                              .map((item) => _buildTilesItem(item))
                              .toList(),
                        ),
                      ),
                      HorizontalLine(),
                      _buildGetCurrentLocation(),
                      HorizontalLine(),
                    ],
                  ),
                ),
              ),
              Container(
                height: marketPlaceToolbarHeight,
                child: ClientAppDefaultAppBar(
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  isBack: true,
                  onPressedBackBtn: () => Navigator.pop(context),
                  isShowCart: false,
                  isShowMenu: false,
                  title: Text(
                    '${AppLocalizations.of(context).tr('client_app_pin_location')}',
                    style: textStyleWithLocale(
                      context: context,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationBtn() {
    return Row(
      children: <Widget>[
        Container(
          height: 31,
          child: CustomRoundButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Theme.of(context).primaryColor,
            radius: 15,
            callback: () => Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppAddAddressPage(),
              ),
            ),
            child: Text(
              '${AppLocalizations.of(context).tr('client_app_add_home')}',
              style: textStyleWithLocale(
                context: context,
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 31,
          child: CustomRoundButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Color(0xffEFEFEF),
            radius: 15,
            callback: () => Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppAddAddressPage(),
              ),
            ),
            child: Text(
              '${AppLocalizations.of(context).tr('client_app_add_work')}',
              style: textStyleWithLocale(
                context: context,
                color: Color(0xff707070),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTilesItem(ClientAppAddress address) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Image.asset('assets/images/ic_home_2.png'),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${address.addressTitle}',
                    style: textStyleWithLocale(
                      context: context,
                    ),
                  ),
                  Text(
                    '${address.address}',
                    style: textStyleWithLocale(
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppAddAddressPage(
                  address: address,
                ),
              ),
            ),
            child: Image.asset('assets/images/ic_edit.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildGetCurrentLocation() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/ic_location.png'),
            SizedBox(width: 10),
            Text(
              '${AppLocalizations.of(context).tr('client_app_use_current_location')}',
              style: textStyleWithLocale(
                context: context,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
