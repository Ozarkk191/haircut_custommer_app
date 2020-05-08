import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

import '../tool_bar.dart';

class ClientAppNavigatorAppBar extends PreferredSize {
  final BuildContext context;
  final bool isBack;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onPressedBackBtn;
  final VoidCallback navigatorCallback;

  ClientAppNavigatorAppBar({
    @required this.context,
    this.isBack = false,
    this.onPressedBackBtn,
    this.navigatorCallback,
    Key key,
    Widget title,
    bool isShowCart = true,
    bool isShowMenu = true,
    this.scaffoldKey,
  })  : assert(context != null),
        super(
          key: key,
          preferredSize: Size.fromHeight(marketPlaceToolbarHeight),
          child: Container(
            height: TOOL_BAR_HEIGHT,
            child: AppBar(
              actions: <Widget>[
                Container(),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              leading: Container(),
              elevation: 20,
              flexibleSpace: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: _buildTopAppbarItems(
                  context: context,
                  isShowCart: isShowCart,
                  scaffoldKey: scaffoldKey,
                  isBack: isBack,
                  onPressedBackBtn: onPressedBackBtn,
                  navigatorCallback: navigatorCallback,
                  isShowMenu: isShowMenu,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(marketPlaceAppbarRoundCorner),
                  bottomRight: Radius.circular(marketPlaceAppbarRoundCorner),
                ),
              ),
            ),
          ),
        );

  static Widget _buildTopAppbarItems({
    @required BuildContext context,
    bool isShowCart,
    bool isBack = false,
    bool isShowMenu = true,
    GlobalKey<ScaffoldState> scaffoldKey,
    VoidCallback onPressedBackBtn,
    VoidCallback navigatorCallback,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: [
          Opacity(
            opacity: isBack ? 1 : 0,
            child: IconButton(
              icon: Image.asset('assets/images/ic_back.png'),
              onPressed: onPressedBackBtn,
            ),
          ),
          Expanded(
            child: _buildSearchLocationTextField(
                context: context, callback: navigatorCallback),
          ),
          Row(
            children: <Widget>[
              Opacity(
                opacity: isShowCart ? 1 : 0,
                child: IconButton(
                  icon: Image.asset('assets/images/ic_cart.png'),
                  onPressed: () {},
                ),
              ),
              Opacity(
                opacity: isShowMenu ? 1 : 0,
                child: IconButton(
                  icon: Image.asset('assets/images/ic_hamburger.png'),
                  onPressed: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildSearchLocationTextField(
      {@required BuildContext context, VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            Image.asset('assets/images/ic_marker_2.png'),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '${AppLocalizations.of(context).tr('client_app_current_location')}',
                style: textStyleWithLocale(
                  context: context,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
