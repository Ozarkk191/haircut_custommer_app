import 'package:meta/meta.dart';

class ClientAppCoupon {
  final int couponId;
  final String couponImageUrl;
  final DiscountType discountType;
  final double discount;
  final String title;
  final String content;

  ClientAppCoupon(
      {@required this.couponId,
      this.couponImageUrl,
      @required this.discountType,
      @required this.discount,
      @required this.title,
      @required this.content})
      : assert(couponId != null),
        assert(discountType != null),
        assert(discount != null),
        assert(title != null),
        assert(content != null);
}

enum DiscountType { PERCENT, PRICE, FREE }
