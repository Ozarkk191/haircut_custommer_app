import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/bloc/edit_my_place_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/place.dart';
import 'package:haircut_delivery/repository/user_repository.dart';
import 'package:haircut_delivery/screen/login/login_screen.dart';
import 'package:haircut_delivery/screen/pinlocation/pin_location_screen.dart';
import 'package:haircut_delivery/ui/button.dart';
import 'package:haircut_delivery/ui/container.dart';
import 'package:haircut_delivery/ui/dialog.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:haircut_delivery/ui/text_field.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';

/// Edit My Place screen for adding a new my place.
class EditMyPlacesScreen extends StatefulWidget {
  final Place place;

  EditMyPlacesScreen(this.place, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditMyPlaceScreenState();
}

class _EditMyPlaceScreenState extends State<EditMyPlacesScreen> {
  // BLoC
  final _bloc = EditMyPlaceBloc();

  // Form keys
  final _registerFormKey = GlobalKey<FormState>();

  // Input controllers
  TextEditingController _titleController;
  TextEditingController _addressController;

  final _googleMapController = Completer<GoogleMapController>();

  // Focus nodes
  final _addressFocusNode = FocusNode();

  // Constants
  final _inputPaddingBottom = EdgeInsets.only(bottom: 15);

  // Data
  Set<Marker> _markers = Set();
  double _latitude;
  double _longitude;

  @override
  void initState() {
    super.initState();

    // Assign latitude and longitude data sent from the previous screen.
    _titleController = TextEditingController(text: widget.place?.name);
    _addressController = TextEditingController(text: widget.place?.address);
    _latitude = widget.place?.latitude;
    _longitude = widget.place?.longitude;

    // Listens for the result of creating a new my place.
    _bloc.updateMyPlaceStream.listen((data) {
      switch (data.status) {
        case ResponseStatus.SUCCESS:
          Navigator.pop(context, true);
          break;
        case ResponseStatus.ERROR:
          if (data.httpStatus == 401) {
            UserRepository.logOut();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(message: data.message);
              },
            );
          }
          break;
        default: // Do nothing.
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.place.address);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                PrimaryToolBar(title: AppLocalizations.of(context).tr('edit_my_place_title')),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 5,
                            child: Form(
                              key: _registerFormKey,
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        AppLocalizations.of(context).tr('edit_my_place_sub_title'),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: _inputPaddingBottom,
                                    child: Divider(color: const Color(0xFFBDBDBD), thickness: 1),
                                  ),
                                  Padding(
                                    padding: _inputPaddingBottom,
                                    child: PrimaryTextFormField(
                                      controller: _titleController,
                                      hintText: AppLocalizations.of(context).tr('add_my_place_place_title'),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context).tr('add_my_place_error_title_blank');
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context).requestFocus(_addressFocusNode);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: _inputPaddingBottom,
                                    child: PrimaryTextFormField(
                                      controller: _addressController,
                                      hintText: AppLocalizations.of(context).tr('add_my_place_address'),
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      focusNode: _addressFocusNode,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context).tr('add_my_place_error_address_blank');
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: _inputPaddingBottom,
                                      child: PrimaryButton(
                                        text: AppLocalizations.of(context).tr('btn_save'),
                                        onPressed: () {
                                          if (_latitude == null || _longitude == null) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ErrorDialog(message: AppLocalizations.of(context).tr('add_my_place_error_location_blank'));
                                              },
                                            );
                                            return;
                                          }
                                          if (_registerFormKey.currentState.validate()) {
                                            print("update " + _latitude.toString() + " " + _longitude.toString());
                                            _bloc.updateMyPlace(
                                              widget.place?.id,
                                              UpdatePlaceParameters(
                                                _titleController.text,
                                                _addressController.text,
                                                _latitude,
                                                _longitude,
                                                widget.place?.group,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                      AspectRatio(
                        aspectRatio: 1.35,
                        child: ContentContainer(
                            verticalPaddingEnabled: true,
                            child: InkWell(
                              onTap: () {
                                _goToPinLocationScreen();
                              },
                              child: Stack(
                                children: <Widget>[
                                  GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(target: LatLng(widget.place?.latitude, widget.place?.longitude), zoom: 16),
                                    markers: _markers,
                                    onMapCreated: (GoogleMapController controller) {
                                      _googleMapController.complete(controller);

                                      // Create a marker at the initial position.
                                      _showLocationOnMap(Position(latitude: widget.place?.latitude, longitude: widget.place?.longitude));
                                    },
                                  ),
                                  Container(decoration: BoxDecoration(color: const Color(0x88000000))),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          AppLocalizations.of(context).tr('add_my_place_open_map'),
                                          style: const TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            StreamBuilder<ApiResponse>(
              stream: _bloc.updateMyPlaceStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case ResponseStatus.LOADING:
                      return LoadingScreen();
                    default:
                      return Container();
                  }
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Shows a marker on the map at [position] and zoom the camera to that position.
  _showLocationOnMap(Position position) async {
    if (position != null) {
      setState(() {
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(position.latitude, position.longitude),
          anchor: const Offset(0.5, 0.8), // For some reason Offset(0.5, 1.0) doesn't set the pin's leg at the exact position. Offset(0.5, 0.8) looks better.
        ));
      });
      _latitude = position.latitude;
      _longitude = position.longitude;
      print("new " + _latitude.toString() + " " + _longitude.toString());

      final GoogleMapController controller = await _googleMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16)));
    }
  }

  /// Goes to the Pin Location screen.
  _goToPinLocationScreen() async {
    LatLng result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new PinLocationScreen(latitude: _latitude, longitude: _longitude),
        fullscreenDialog: true,
      ),
    );

    // Update the map.
    if (result != null) {
      _showLocationOnMap(Position(latitude: result.latitude, longitude: result.longitude));
    }
  }
}
