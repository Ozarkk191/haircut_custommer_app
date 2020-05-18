import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppSearchAppBar extends PreferredSize {
  final BuildContext context;
  final VoidCallback navigatorCallback;
  final VoidCallback changeCallback;
  final ServiceType serviceType;

  ClientAppSearchAppBar({
    @required this.context,
    this.navigatorCallback,
    this.changeCallback,
    Key key,
    Widget title,
    this.serviceType = ServiceType.BOOKING,
  })  : assert(context != null),
        super(
          key: key,
          preferredSize: Size.fromHeight(marketPlaceNavToolbar),
          child: Container(
            child: AppBar(
              actions: <Widget>[
                Container(),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              leading: Container(),
              elevation: 20,
              flexibleSpace: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: _buildTopAppbarItems(
                  context: context,
                  navigatorCallback: navigatorCallback,
                  serviceType: serviceType,
                  changeCallback: changeCallback,
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
    VoidCallback navigatorCallback,
    ServiceType serviceType = ServiceType.BOOKING,
    final VoidCallback changeCallback,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: _buildSearchLocationTextField(
                  context: context,
                  callback: navigatorCallback,
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/clientapp/images/ic_listing.png'),
                    onPressed: navigatorCallback,
                  ),
                ],
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
                tr('client_app_current_location'),
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

  // static String _showServiceType(ServiceType serviceType) {
  //   if (serviceType == ServiceType.BOOKING) {
  //     return 'Booking';
  //   } else {
  //     return 'Delivery';
  //   }
  // }
}
