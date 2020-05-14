import 'package:meta/meta.dart';

class ClientAppAddress {
  final int addressId;
  final String addressTitle;
  final String address;
  final double addressLat;
  final double addressLon;

  ClientAppAddress({
    @required this.addressId,
    @required this.addressTitle,
    @required this.address,
    this.addressLat,
    this.addressLon,
  });
}
