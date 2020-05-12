import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/models/address_model.dart';
import 'package:haircut_delivery/clientapp/screens/address/client_app_add_address_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/item_listview/address_item.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppPlaceListPage extends StatefulWidget {
  ClientAppPlaceListPage({Key key}) : super(key: key);

  @override
  _ClientAppPlaceListPageState createState() => _ClientAppPlaceListPageState();
}

class _ClientAppPlaceListPageState extends State<ClientAppPlaceListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List<AddressModel> _list;
  List<String> _getList = List<String>();
  List<AddressModel> _addList = List<AddressModel>();
  AddressModel _address;

  Position _position;

  @override
  void initState() {
    _loadSharedPrefs();
    _getCurrentLocation();
    super.initState();
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _position = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _loadSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _getList = prefs.getStringList('address');

    print('place :: $_getList');
    if (_getList != null) {
      _getList.forEach((item) {
        var body = json.decode(item);
        AddressModel address = AddressModel.fromJson(body);

        setState(() {
          _address = address;
          _addList.add(address);
          print('text :: ${_address.address}');
        });
      });
    }
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
                                tr('client_app_saved_location'),
                                style: textStyleWithLocale(
                                  context: context,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _addList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (_getList.length != 0) {
                                  return AddressItem(
                                    addressTitle: _addList[index].addressTitle,
                                    address: _addList[index].address,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
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
                    tr('client_app_pin_location'),
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
                child: ClientAppAddAddressPage(
                  typeAddress: AddressType.HOME.toString(),
                ),
              ),
            ),
            child: Text(
              tr('client_app_add_home'),
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
                child: ClientAppAddAddressPage(
                    typeAddress: AddressType.WORK.toString()),
              ),
            ),
            child: Text(
              tr('client_app_add_work'),
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

  Widget _buildGetCurrentLocation() {
    return InkWell(
      onTap: () => Navigator.pop(context, _position),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Image.asset('assets/images/ic_location.png'),
            SizedBox(width: 10),
            Text(
              tr('client_app_use_current_location'),
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
