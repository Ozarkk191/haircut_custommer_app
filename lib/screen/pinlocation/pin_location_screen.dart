import 'dart:async';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:haircut_delivery/config/keys.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

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
  GlobalKey<AutoCompleteTextFieldState<Prediction>> _searchFieldKey =
      new GlobalKey();

  // Input controllers
  final _googleMapController = Completer<GoogleMapController>();

  // Google API
  final _googleMapPlaces =
      new GoogleMapsPlaces(apiKey: Keys.GOOGLE_PLACES_API_KEY);
  final _uuid = Uuid();
  String _placeAutocompleteSessionToken;
  Timer _placeAutocompleteDebounce;

  // Data
  List<Prediction> _suggestions = <Prediction>[];
  Position _currentLocation;

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        target: LatLng(18.817132, 98.986681), zoom: 16),
            onMapCreated: (GoogleMapController controller) {
              _googleMapController.complete(controller);
            },
            myLocationEnabled: true,
            padding: EdgeInsets.only(top: 70),
          ),
          PlaceAutocompleteToolBar(
            _suggestions,
            searchFieldKey: _searchFieldKey,
            hintText: AppLocalizations.of(context).tr('pin_location_search'),
            onTextChanged: (text) {
              if (_placeAutocompleteDebounce?.isActive ?? false) {
                _placeAutocompleteDebounce.cancel();
              }
              _placeAutocompleteDebounce =
                  Timer(const Duration(milliseconds: 500), () {
                _querySuggestions(text);
              });
            },
            onItemSubmitted: (item) {
              _onSuggestionTap(item);
            },
          ),
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
                child: PrimaryButton(
                  text: AppLocalizations.of(context).tr('btn_confirm'),
                  onPressed: () {
                    _goBack();
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  /// Queries place suggestions with keyword [text] from Google API.
  Future<void> _querySuggestions(String text) async {
    // Generate a new session token if null.
    if (_placeAutocompleteSessionToken == null) {
      _placeAutocompleteSessionToken = _uuid.v4();
    }

    // Make a place details request.
    PlacesAutocompleteResponse response = await _googleMapPlaces.autocomplete(
      text,
      sessionToken: _placeAutocompleteSessionToken,
      language: 'th',
      location: _currentLocation == null
          ? null
          : Location(_currentLocation.latitude, _currentLocation.longitude),
      radius: _currentLocation == null ? null : 50000,
    );

    // Process the response and update the suggestion list.
    if (response.isOkay) {
      _suggestions.clear();
      for (var prediction in response.predictions) {
        _suggestions.add(prediction);
      }
      _searchFieldKey.currentState.updateSuggestions(_suggestions);
    } else {
      Toast.show(response.errorMessage, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  /// Event handler for tapping a place autocomplete item.
  /// Makes an API request to query place details by place ID in [prediction],
  /// if success, move the map's camera to the location of the place.
  Future<void> _onSuggestionTap(Prediction prediction) async {
    // Query place details.
    PlacesDetailsResponse response = await _googleMapPlaces.getDetailsByPlaceId(
        prediction.placeId,
        sessionToken: _placeAutocompleteSessionToken);
    if (response.isOkay) {
      _showLocationOnMap(response?.result?.geometry?.location);
    } else {
      Toast.show(response.errorMessage, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }

    // Resets the session token UUID.
    _placeAutocompleteSessionToken = null;
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

  /// Moves the map's camera to [location].
  _showLocationOnMap(Location location) async {
    if (location != null) {
      final GoogleMapController controller = await _googleMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(location.lat, location.lng), zoom: 16)));
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

    Navigator.pop(context, latLng);
  }
}
