import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/model/client_app_shop.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ActivityItem extends StatelessWidget {
  final ClientAppShop shop;
  final ClientAppService service;

  const ActivityItem({Key key, @required this.shop, @required this.service})
      : assert(shop != null),
        assert(service != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Container(
              width: 130,
              height: 120,
              child: Image.asset(
                'assets/clientapp/mockup/shops/${shop.avatarUrl}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset('assets/clientapp/images/ic_mini_clock.png'),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '12 February 2020 - 10:00',
                        style: textStyleWithLocale(
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        color: Colors.green,
                        width: 10,
                        height: 10,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${shop.shopName}',
                        style: textStyleWithLocale(
                          context: context,
                          fontSize: 18,
                          height: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset('assets/images/ic_marker_2.png'),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${shop.address}',
                        style: textStyleWithLocale(
                          context: context,
                          fontSize: 16,
                          height: 1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
