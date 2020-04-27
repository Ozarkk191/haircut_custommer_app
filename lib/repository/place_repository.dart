import 'dart:async';

import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/service/haircut_service_client.dart';

class PlaceRepository {
  final _client = HaircutServiceClient();

  /// Fetches a service list.
  Future<List<Place>> fetchMyPlaceList() async {
    final response = await _client.get('my-places', withAccessToken: true);
    return response.map<Place>((place) => Place.fromJson(place)).toList(growable: false);
  }

  /// Create a new my place with data in [parameters].
  Future createMyPlace(CreatePlaceParameters parameters) async {
    return await _client.post('my-places', data: parameters, withAccessToken: true);
  }

  /// Updates my place with ID [id] with data in [parameters].
  Future updateMyPlace(int id, UpdatePlaceParameters parameters) async {
    return await _client.patch('my-places/$id', data: parameters, withAccessToken: true);
  }

  /// Deletes my place with ID [id].
  Future deleteMyPlace(int id) async {
    return await _client.delete('my-places/$id', withAccessToken: true);
  }
}
