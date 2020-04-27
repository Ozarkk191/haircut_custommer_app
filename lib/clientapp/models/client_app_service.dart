import 'package:meta/meta.dart';

class ClientAppService {
  final int serviceId;
  final int serviceCategoryId;
  final int parentCatId;
  final int shopId;
  final String serviceName;
  final bool isPartner;
  final double price;
  final double discount;
  final double deliveryPrice;
  final bool isAtShop;
  final bool isDelivery;

  ClientAppService({
    @required this.serviceId,
    @required this.serviceCategoryId,
    @required this.parentCatId,
    @required this.shopId,
    @required this.serviceName,
    this.isPartner = false,
    this.price = 0,
    this.discount = 0,
    this.deliveryPrice = 0,
    this.isAtShop = true,
    this.isDelivery = false,
  });
}
