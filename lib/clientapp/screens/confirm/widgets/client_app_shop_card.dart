import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class ClientAppShopCart extends StatelessWidget {
  final ClientAppShop shop;
  final int distance;

  const ClientAppShopCart({Key key, @required this.shop, this.distance = 1})
      : assert(shop != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(right: 10),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/clientapp/mockup/shops/${shop.avatarUrl}',
                fit: BoxFit.cover,
              ),
              width: 130,
              height: 120,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipOval(
                              child: Container(
                                color: Colors.green,
                                width: 10,
                                height: 10,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                '${shop.shopName}',
                                style: textStyleWithLocale(
                                  context: context,
                                  color: Color(0xff707070),
                                  fontSize: 18,
                                  height: 1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$distance km',
                        style: textStyleWithLocale(
                          context: context,
                          height: 1,
                          color: Color(0xff707070),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset('assets/images/ic_marker_2.png'),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                '${shop.address}',
                                style: textStyleWithLocale(
                                  context: context,
                                  color: Color(0xff707070),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/ic_calendar.png',
                      )
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${shop.rating}',
                        style: textStyleWithLocale(
                            context: context, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
