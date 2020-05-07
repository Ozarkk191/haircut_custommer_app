import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/config/colors.dart';
import 'package:haircut_delivery/model/service.dart';
import 'package:haircut_delivery/model/shop.dart';
import 'package:haircut_delivery/ui/container.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/title.dart';

class ShopScreen extends StatefulWidget {
  final Shop shop;

  ShopScreen({this.shop, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // Input controllers
  final _googleMapController = Completer<GoogleMapController>();

  // Data
  Set<Marker> _markers = Set();
  double latitude;
  double longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.shop.avatarUrl,
              fit: BoxFit.fill,
              placeholder: (context, url) => LoadingIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ContentContainer(
              verticalPaddingEnabled: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.shop.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(widget.shop.distance.toString() + " km"),
                ],
              ),
            ),
            ContentContainer(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/images/ic_marker_2.png"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(widget.shop.address),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3,
              color: MyColors.LIGHT_GREY,
            ),
            ContentContainer(
              child: SectionTitle(
                title: AppLocalizations.of(context).tr('shop_service_list'),
              ),
            ),
            ContentContainer(
              child: _buildServiceList(context, widget.shop.services),
            ),
            Divider(
              thickness: 3,
              color: MyColors.LIGHT_GREY,
            ),
            ContentContainer(
              child: SectionTitle(
                title: AppLocalizations.of(context).tr('shop_location'),
              ),
            ),
            ContentContainer(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(18.817132, 98.986681), zoom: 16),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController.complete(controller);

                  // Set up marker for the map.
                  _setUpMapMarker();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds service list from [serviceList] data.
  Widget _buildServiceList(BuildContext context, List<Service> serviceList) {
    var children = <Widget>[];
    if (serviceList != null && serviceList.isNotEmpty) {
      children.addAll(serviceList.map((service) {
        final divider = Divider(thickness: 1, color: MyColors.LIGHT_GREY);
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset('assets/images/btn_add.png'),
                ),
                Expanded(
                  child: Text(service.name, style: TextStyle(fontSize: 20)),
                ),
                Text("฿" + service.price.toString(),
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).primaryColor)),
              ],
            ),
            divider
          ],
        );
      }).toList());
    } else {
      children.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(AppLocalizations.of(context).tr('shop_no_service')),
        ),
      );
    }
    return Column(
      children: children,
    );
  }

  /// Shows a marker in the map. The position of the marker will be retrieved from
  /// the current location of the device (if available). If the current location of the device
  /// is not available, the last known location of the device will be used instead (if available).
  /// If no location available then do not show the marker.
  _setUpMapMarker() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.granted:
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        _showLocationOnMap(position);
        break;
      default:
        Position position = await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        _showLocationOnMap(position);
    }
  }

  /// Shows a marker on the map at [position] and zoom the camera to that position.
  _showLocationOnMap(Position position) async {
    if (position != null) {
      setState(() {
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(position.latitude, position.longitude),
          anchor: const Offset(0.5,
              0.8), // For some reason Offset(0.5, 1.0) doesn't set the pin's leg at the exact position. Offset(0.5, 0.8) looks better.
        ));
      });
      latitude = position.latitude;
      longitude = position.longitude;

      final GoogleMapController controller = await _googleMapController.future;
      controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 16)));
    }
  }
}
