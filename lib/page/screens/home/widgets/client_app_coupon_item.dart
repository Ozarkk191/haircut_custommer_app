import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/client_app_coupons.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppCouponItem extends StatelessWidget {
  final ClientAppCoupon clientAppCoupon;

  const ClientAppCouponItem({Key key, @required this.clientAppCoupon})
      : assert(clientAppCoupon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(0),
              width: 100,
              height: 120,
              child: Image.asset(
                'assets/clientapp/mockup/coupons/${clientAppCoupon.couponImageUrl}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Container(
                color: Colors.white,
                child: clientAppCoupon.discountType == DiscountType.FREE
                    ? _buildFreeType(context: context)
                    : _buildDiscountType(context: context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreeType({@required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          clientAppCoupon.title,
          style: textStyleWithLocale(
            context: context,
            color: Colors.black,
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          clientAppCoupon.content,
          style: textStyleWithLocale(
            context: context,
            color: Colors.black,
            fontSize: 12,
            height: 1,
          ),
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        _getCode(context: context),
      ],
    );
  }

  Widget _buildDiscountType({@required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '',
          style: textStyleWithLocale(
            context: context,
            height: 1,
            color: Colors.black,
          ),
        ),
        Text(
          _showDiscount(),
          style: textStyleWithLocale(
            context: context,
            color: Colors.black,
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textStyleWithLocale(
            context: context,
            color: Colors.black,
            fontSize: 12,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: textStyleWithLocale(
            context: context,
            color: Colors.black,
            fontSize: 12,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
        _getCode(context: context),
      ],
    );
  }

  Widget _getCode({@required BuildContext context}) {
    return Container(
      height: 17,
      width: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 0),
        color: Theme.of(context).primaryColor,
        onPressed: () {},
        child: Text(
          '',
          style: textStyleWithLocale(
            context: context,
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  String _showDiscount() {
    String discount = clientAppCoupon.discount.toString();
    String unitType = '';

    clientAppCoupon.discountType == DiscountType.PERCENT
        ? unitType = '%'
        : unitType = '฿';

    return discount + unitType;
  }
}
