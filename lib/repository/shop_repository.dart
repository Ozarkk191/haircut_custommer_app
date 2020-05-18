// import 'dart:async';

// import 'package:haircut_delivery/model/shop.dart';
// import 'package:haircut_delivery/service/haircut_service_client.dart';

// class ShopRepository {
//   final _client = HaircutServiceClient();

//   /// Fetches a shop list around the position with [latitude] and [longitude].
//   /// If [atShop] is true, the result will consist only shops that accept only at-shop service.
//   /// If [delivery] is true, the result will consist only shops that accept only delivery service.
//   /// If both [atShop] and [delivery] are true, the result will consist only shops that accept both at-shop and delivery service.
//   Future<List<Shop>> fetchShopList({latitude: double, longitude: double, atShop: bool, delivery: bool}) async {
//     final response = await _client.get('shops', queryParameters: {'lat': latitude.toString(), 'lng': longitude.toString(), 'atshop': atShop ? '1' : '0', 'delivery': delivery ? '1' : '0'});
//     return response.map<Shop>((shop) => Shop.fromJson(shop)).toList(growable: false);
//   }
// }
