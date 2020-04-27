import 'package:haircut_delivery/model/request_body_parameters.dart';

class Place {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String group;

  static const String GROUP_HOME = 'home';
  static const String GROUP_WORK = 'home';

  Place.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        latitude = json['lat'],
        longitude = json['lng'],
        group = json['group'];
}

class CreatePlaceParameters extends RequestBodyParameters {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String group;

  CreatePlaceParameters(this.name, this.address, this.latitude, this.longitude, this.group);

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'lat': latitude,
        'lng': longitude,
        'group': group,
      };
}

class UpdatePlaceParameters extends RequestBodyParameters {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String group;

  UpdatePlaceParameters(this.name, this.address, this.latitude, this.longitude, this.group);

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'lat': latitude,
        'lng': longitude,
        'group': group,
      };
}
