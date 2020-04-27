import 'dart:async';

import 'package:haircut_delivery/model/service.dart';
import 'package:haircut_delivery/service/haircut_service_client.dart';

class ServiceRepository {
  final _client = HaircutServiceClient();

  /// Fetches a service list.
  Future<List<Service>> fetchServiceList() async {
    final response = await _client.get('services');
    return response.map<Service>((service) => Service.fromJson(service)).toList(growable: false);
  }
}
