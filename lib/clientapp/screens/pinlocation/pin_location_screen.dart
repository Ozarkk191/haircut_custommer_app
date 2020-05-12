import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../ui/buttons/big_round_button.dart';

class PinLocationScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  PinLocationScreen({this.latitude, this.longitude, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PinLocationScreenState();
}

class _PinLocationScreenState extends State<PinLocationScreen> {
  // Global keys
  GlobalKey _googleMapKey = GlobalKey();

  // Input controllers
  final _googleMapController = Completer<GoogleMapController>();

  Position _currentLocation;

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                key: _googleMapKey,
                mapType: MapType.normal,
                initialCameraPosition:
                    widget.latitude != null && widget.longitude != null
                        ? CameraPosition(
                            target: LatLng(widget.latitude, widget.longitude),
                            zoom: 16)
                        : CameraPosition(
                            target: LatLng(
                              _currentLocation.latitude,
                              _currentLocation.longitude,
                            ),
                            zoom: 16),
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController.complete(controller);
                },
                myLocationEnabled: true,
                padding: EdgeInsets.only(top: 70),
              ),
              // PlaceAutocompleteToolBar(
              //   _suggestions,
              //   searchFieldKey: _searchFieldKey,
              //   hintText: 'pin_location_search',
              //   onTextChanged: (text) {
              //     if (_placeAutocompleteDebounce?.isActive ?? false) {
              //       _placeAutocompleteDebounce.cancel();
              //     }
              //     _placeAutocompleteDebounce =
              //         Timer(const Duration(milliseconds: 500), () {
              //       _querySuggestions(text);
              //     });
              //   },
              //   onItemSubmitted: (item) {
              //     _onSuggestionTap(item);
              //   },
              // ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Icon(
                    Icons.location_on,
                    size: 50,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: BigRoundButton(
                      textButton: tr('btn_confirm'),
                      color: Color(0xffbb133b),
                      callback: () {
                        _goBack();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
    );
  }

  /// Returns the device's current location.
  Future<void> _fetchUserLocation() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.granted:
        _currentLocation = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        break;
      default:
        _currentLocation = await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }
  }

  /// Goes back to the previous screen with the location data sent along.
  /// The location data is obtained from the center position of the map.
  Future<void> _goBack() async {
    final GoogleMapController controller = await _googleMapController.future;
    final RenderBox mapRenderBox =
        _googleMapKey.currentContext.findRenderObject();
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final mapWidthInPixel = mapRenderBox.size.width * devicePixelRatio;
    final mapHeightInPixel = mapRenderBox.size.height * devicePixelRatio;
    LatLng latLng = await controller.getLatLng(ScreenCoordinate(
        x: (mapWidthInPixel / 2).round(), y: (mapHeightInPixel / 2).round()));
    print('LatLng :: $latLng');
    Navigator.pop(context, latLng);
  }
}
