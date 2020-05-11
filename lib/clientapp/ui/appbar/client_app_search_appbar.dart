import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

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
            height: marketPlaceNavToolbar,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '',
                  style: textStyleWithLocale(
                    context: context,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: changeCallback,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    color: Color(0xff009900),
                    child: Text(
                      'client_app_change',
                      style: textStyleWithLocale(
                        context: context,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                'client_app_current_location',
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
