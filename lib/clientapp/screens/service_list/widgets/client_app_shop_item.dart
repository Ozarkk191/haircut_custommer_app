import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class ClientAppShopItem extends StatelessWidget {
  final ClientAppShop shop;

  const ClientAppShopItem({Key key, @required this.shop})
      : assert(shop != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 2) - 25;

    return Container(
      margin: EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildShopAvatar(width: width),
              SizedBox(height: 5),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${shop.shopName}',
                      style: textStyleWithLocale(
                        context: context,
                        color: Color(0xff707070),
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    _buildShopAddress(context: context),
                    Text(
                      '',
                      style: textStyleWithLocale(
                        context: context,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                            context: context,
                            color: Color(0xff707070),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShopAvatar({double width}) {
    return Container(
      width: width,
      height: 100,
      child: shop.avatarUrl != null
          ? Image.asset(
              'assets/clientapp/mockup/shops/${shop.avatarUrl}',
              fit: BoxFit.cover,
            )
          : Container(color: Colors.red),
    );
  }

  Widget _buildShopAddress({BuildContext context}) {
    return Row(
      children: <Widget>[
        Image.asset('assets/images/ic_marker_2.png'),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '${shop.address}',
            style: textStyleWithLocale(
              context: context,
              color: Color(0xff707070),
              fontWeight: FontWeight.w300,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
