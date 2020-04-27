import 'dart:async';

import 'package:haircut_delivery/bloc/bloc.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/shop.dart';
import 'package:haircut_delivery/repository/shop_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Business logic component for shop list.
class ShopListBloc extends Bloc {
  ShopRepository _shopRepository;
  StreamController _shopListController;

  /// Returns the sink of the shop list stream controller.
  StreamSink<ApiResponse<List<Shop>>> get shopListSink => _shopListController.sink;

  /// Returns the stream of the shop list stream controller.
  Stream<ApiResponse<List<Shop>>> get shopListStream => _shopListController.stream;

  ShopListBloc() {
    _shopListController = StreamController<ApiResponse<List<Shop>>>();
    _shopRepository = ShopRepository();
  }

  /// Fetches a shop list.
  fetchShopList() async {
    shopListSink.add(ApiResponse.loading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final latitude = prefs.getDouble('myLatitude');
      final longitude = prefs.getDouble('myLongitude');
      final isDelivery = prefs.getBool('delivery') ?? false;
      List<Shop> serviceList = await _shopRepository.fetchShopList(latitude: latitude, longitude: longitude, atShop: !isDelivery, delivery: isDelivery);
      shopListSink.add(ApiResponse.success(serviceList));
    } on AppException catch (e) {
      shopListSink.add(ApiResponse.error(e.code, e.toString()));
    } catch (e) {
      shopListSink.add(ApiResponse.error(0, e.toString()));
    }
  }

  @override
  void dispose() {
    _shopListController?.close();
  }
}
