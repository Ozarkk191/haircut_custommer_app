import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';

import '../tool_bar.dart';

class ClientAppTransparentAppBar extends PreferredSize {
  final BuildContext context;
  final bool isBack;
  final VoidCallback onPressedBackBtn;
  final VoidCallback onPressedFavBtn;
  final bool isFav;

  ClientAppTransparentAppBar({
    @required this.context,
    this.isBack = false,
    @required this.onPressedBackBtn,
    @required this.onPressedFavBtn,
    Key key,
    Widget title,
    this.isFav = false,
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
              backgroundColor: Colors.transparent,
              leading: Container(),
              elevation: 20,
              flexibleSpace: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: _buildTopAppbarItems(
                  context: context,
                  isBack: isBack,
                  onPressedBackBtn: onPressedBackBtn,
                  onPressedFavBtn: onPressedFavBtn,
                  isFav: isFav,
                ),
              ),
            ),
          ),
        );

  static Widget _buildTopAppbarItems({
    @required BuildContext context,
    bool isBack = false,
    VoidCallback onPressedBackBtn,
    VoidCallback onPressedFavBtn,
    bool isFav,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: isBack ? 1 : 0,
            child: IconButton(
              icon: Image.asset('assets/images/ic_back.png'),
              onPressed: onPressedBackBtn,
            ),
          ),
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              size: 28,
              color: Colors.white,
            ),
            onPressed: onPressedFavBtn,
          ),
        ],
      ),
    );
  }
}
