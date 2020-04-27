import 'package:haircut_delivery/clientapp/models/client_app_coupons.dart';

final List<ClientAppCoupon> clientAppCoupons = [
  ClientAppCoupon(
    couponId: 1,
    discountType: DiscountType.PERCENT,
    discount: 10,
    title: 'รับส่วนลดบริการ 10%',
    content:
        'รับส่วนลดบริการ 10% (ยกเว้นสินค้าโปรโมชั่น) โปรดแสดงบัตรเมื่อใช้บริการ',
    couponImageUrl: 'coupon1.png',
  ),
  ClientAppCoupon(
    couponId: 2,
    discountType: DiscountType.PERCENT,
    discount: 15,
    title: 'แต่งหน้า-ทำผม เจ้าสาว เจ้าบ่าว ลด 15%',
    content:
        'แต่งหน้า-ทำผม เจ้าสาว เจ้าบ่าว ลด 15% จองคิวแต่งหน้า 2 เวลา เช้าและเย็น รับส่วนลดทันที 15% (นอกสถานที่)',
    couponImageUrl: 'coupon2.jpg',
  ),
  ClientAppCoupon(
    couponId: 3,
    discountType: DiscountType.PRICE,
    discount: 200,
    title: 'ส่วนลดทำทรีทเม้นท์ 200.-',
    content: 'Promotion ส่วนลดทำทรีทเม้นท์ 200.- ตั้งแต่วันที่ 1-15 ก.พ. 2563',
    couponImageUrl: 'coupon3.jpg',
  ),
  ClientAppCoupon(
    couponId: 4,
    discountType: DiscountType.PERCENT,
    discount: 20,
    title: 'เพ้นท์สีเล็บ รับส่วนลด 20%',
    content: 'เพ้นท์สีเล็บ รับส่วนลด 20% เฉพาะบริการจองคิว ทำที่ร้าน',
    couponImageUrl: 'coupon4.jpg',
  ),
  ClientAppCoupon(
    couponId: 5,
    discountType: DiscountType.PERCENT,
    discount: 30,
    title: 'ทำสีผมแฟชั่น รับส่วนลด 30%',
    content: 'ทำสีผมแฟชั่น ภายในวันที่ 5-20 มีนาคม 63 รับส่วนลด 30%',
    couponImageUrl: 'coupon5.jpg',
  ),
  ClientAppCoupon(
    couponId: 6,
    discountType: DiscountType.FREE,
    discount: 0,
    title: 'ตัด 1 ฟรี 1',
    content: 'โปรโมชั่นพิเศษ ตัด 1 ฟรี 1 (สำหรับเด็กอายุไม่เกิน 7 ขวบ)',
    couponImageUrl: 'coupon6.jpg',
  ),
];
