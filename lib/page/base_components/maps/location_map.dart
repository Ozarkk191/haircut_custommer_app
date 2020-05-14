import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/page/base_components/buttons/big_round_button.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationMap extends StatefulWidget {
  final String locationTitle;
  final double latitude;
  final double longitude;
  final double mapWidth;
  final double mapHeight;
  final String shopName;
  final String shopAddress;

  const LocationMap({
    Key key,
    this.locationTitle,
    @required this.latitude,
    @required this.longitude,
    @required this.shopName,
    @required this.shopAddress,
    this.mapWidth = 300,
    this.mapHeight = 300,
  })  : assert(latitude != null),
        assert(longitude != null),
        assert(shopName != null),
        assert(shopAddress != null),
        super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  // Global keys
  GlobalKey _googleMapKey = GlobalKey();
  Position _currentLocation;
  GeolocationStatus _geoStatus;

  Set<Marker> _markers = Set();
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _getPermission();
    _createMarkerImageFromAsset(context);
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(widget.latitude, widget.longitude),
        anchor: const Offset(0.5, 0.8),
        icon: _markerIcon,
        infoWindow: InfoWindow(
          title: '${widget.shopName}',
          snippet: '${widget.shopAddress}',
        ),
      ),
    );
  }

  _getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        setState(() {
          _geoStatus = GeolocationStatus.denied;
        });
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        setState(() {
          _geoStatus = GeolocationStatus.restricted;
        });
        break;
      case GeolocationStatus.unknown:
        setState(() {
          _geoStatus = GeolocationStatus.unknown;
        });
        break;
      case GeolocationStatus.granted:
        Position currloc = await Geolocator().getCurrentPosition();
        setState(() {
          _geoStatus = GeolocationStatus.granted;
          _currentLocation = currloc;
        });
        break;
    }
  }

  Future _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      ImageConfiguration configuration = ImageConfiguration();
      BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
          configuration, 'assets/images/ic_marker_2.png');
      setState(() {
        _markerIcon = bmpd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.locationTitle != null
            ? Text(
                widget.locationTitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : _blankContainer(),
        SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Color(0xffdddddd)),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              shape: BoxShape.rectangle,
            ),
            height: widget.mapWidth,
            width: widget.mapHeight,
            child: _map(),
          ),
        ),
      ],
    );
  }

  Widget _blankContainer() {
    return Container(width: 0, height: 0);
  }

  Widget _map() {
    Widget result;

    if (_currentLocation == null && _geoStatus == null) {
      result = Center(
        child: CircularProgressIndicator(),
      );
    } else if (_currentLocation != null &&
        _geoStatus == GeolocationStatus.granted) {
      result = GoogleMap(
        key: _googleMapKey,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        ].toSet(),
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
    } else {
      result = Center(
        child: BigRoundButton(
          textButton: 'กรุณาอนุญาติให้ใช้โลเคชั่น',
          callback: _getPermission,
          color: Colors.grey,
        ),
      );
    }

    return result;
  }
}
