import 'package:haircut_delivery/model/service.dart';

class Shop {
  final int id;
  final String name;
  final String address;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;
  final String avatarUrl;
  final double distance;
  final List<Service> services = new List<Service>();

  Shop.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        email = json['email'],
        phone = json['phone'],
        avatarUrl = json['avatar'],
        latitude = json['lat'],
        longitude = json['lng'],
        distance = json['distance'] {
    if (json['services'] != null) {
      json['services'].forEach((service) {
        services.add(new Service.fromJson(service));
      });
    }
  }
}
