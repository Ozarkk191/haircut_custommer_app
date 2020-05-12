import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/styles/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import '../tool_bar.dart';

class ClientAppDefaultAppBar extends PreferredSize {
  final BuildContext context;
  final bool isBack;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onPressedBackBtn;
  final Widget title;

  ClientAppDefaultAppBar({
    @required this.context,
    this.isBack = false,
    this.onPressedBackBtn,
    Key key,
    this.title,
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
                  isShowMenu: isShowMenu,
                  title: title,
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
    Widget title,
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
          Opacity(
            opacity: 0,
            child: IconButton(
              icon: Image.asset('assets/images/ic_hamburger.png'),
              onPressed: null,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: title != null
                  ? title
                  : Text(
                      tr('client_app_main_title'),
                      style: appTitleTextStyle,
                    ),
            ),
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
}
