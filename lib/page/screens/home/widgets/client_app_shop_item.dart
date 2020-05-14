import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/model/client_app_shop.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppServiceItem extends StatelessWidget {
  final ClientAppService clientAppService;
  final ClientAppShop shop;
  final Function callback;

  const ClientAppServiceItem(
      {Key key,
      @required this.clientAppService,
      @required this.shop,
      @required this.callback})
      : assert(clientAppService != null),
        assert(shop != null),
        assert(callback != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(
                0, // horizontal, move right 10
                3.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            _buildShopAvatar(),
            _buildShopData(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildShopAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Container(
        width: 100,
        height: 120,
        child: shop.avatarUrl != null
            ? Image.asset(
                'assets/clientapp/mockup/shops/${shop.avatarUrl}',
                fit: BoxFit.cover,
              )
            : Container(color: Colors.red),
      ),
    );
  }

  Widget _buildShopData({BuildContext context}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildServiceName(context: context),
                _buildShopPrice(context: context),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _buildShopName(context: context),
                ),
                _buildShopServices(context: context),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Image.asset('assets/images/ic_marker_2.png'),
                SizedBox(width: 5),
                Expanded(
                    child: Text(
                  '${shop.address}',
                  style: textStyleWithLocale(
                    context: context,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${shop.rating}',
                      style: textStyleWithLocale(context: context),
                    ),
                    SizedBox(width: 5),
                    clientAppService.isPartner
                        ? Text(
                            '',
                            style: textStyleWithLocale(context: context),
                          )
                        : _blankContainer(),
                  ],
                ),
                _buildReserveButton(context: context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceName({BuildContext context}) {
    return Expanded(
      child: Row(
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
              '${clientAppService.serviceName}',
              style: textStyleWithLocale(
                context: context,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopPrice({BuildContext context}) {
    final _formatCurrency =
        NumberFormat.currency(locale: 'th_TH', symbol: '', decimalDigits: 0);
    double _showPrice = clientAppService.price > clientAppService.deliveryPrice
        ? clientAppService.price
        : clientAppService.deliveryPrice;

    return Text(
      '฿${_formatCurrency.format(_showPrice)}',
      style: textStyleWithLocale(
        context: context,
        color: Theme.of(context).primaryColor,
        fontSize: 18,
      ),
    );
  }

  Widget _buildShopName({BuildContext context}) {
    return Row(
      children: <Widget>[
        Image.asset('assets/clientapp/images/ic_shop.png'),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            '${shop.shopName}',
            style: textStyleWithLocale(
              context: context,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildShopServices({BuildContext context}) {
    final _formatCurrency =
        NumberFormat.currency(locale: 'th_TH', symbol: '', decimalDigits: 0);

    return Row(
      children: <Widget>[
        clientAppService.isAtShop
            ? _shopServiceLabelWithIcon(
                icon: Image.asset('assets/images/ic_calendar.png'))
            : _blankContainer(),
        // SizedBox(width: 5),
        clientAppService.isDelivery
            ? _shopServiceLabelWithIcon(
                icon: Image.asset('assets/images/ic_delivery.png'),
                title:
                    '฿${_formatCurrency.format(clientAppService.deliveryPrice)}',
                context: context,
              )
            : _blankContainer(),
      ],
    );
  }

  Widget _shopServiceLabelWithIcon(
      {Widget icon, String title, BuildContext context}) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(width: 5),
        title != null
            ? Text(
                '$title',
                style: textStyleWithLocale(
                    context: context, color: Theme.of(context).primaryColor),
              )
            : _blankContainer(),
      ],
    );
  }

  Widget _blankContainer() {
    return Container(height: 0, width: 0);
  }

  Widget _buildReserveButton({@required BuildContext context}) {
    return Container(
      height: 25,
      width: 60,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0),
        color: Color(0xff1DAD1D),
        onPressed: callback,
        child: Text(
          tr('client_app_reserve'),
          style: textStyleWithLocale(
            context: context,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
