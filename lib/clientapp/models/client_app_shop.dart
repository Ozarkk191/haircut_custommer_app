import 'package:haircut_delivery/clientapp/models/client_app_user.dart';
import 'package:meta/meta.dart';

class ClientAppShop {
  final int shopId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String avatarUrl;
  final bool isApproved;
  final String shopName;
  final String address;
  final double latitude;
  final double longitude;
  final UserGender gender;
  final bool isDelivery;
  final double deliveryFee1;
  final double deliveryFee2;
  final double deliveryFee3;
  final double deliveryFee4;
  final double deliveryFee5;
  final double rating;
  final int counting;

  ClientAppShop({
    @required this.shopId,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    this.phone,
    this.avatarUrl,
    this.isApproved = false,
    @required this.shopName,
    @required this.address,
    this.latitude,
    this.longitude,
    this.gender,
    this.rating = 0,
    this.isDelivery = false,
    this.deliveryFee1 = 0,
    this.deliveryFee2 = 0,
    this.deliveryFee3 = 0,
    this.deliveryFee4 = 0,
    this.deliveryFee5 = 0,
    this.counting = 0,
  });
}
