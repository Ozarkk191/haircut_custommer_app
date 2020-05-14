import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/helpers/share_helper.dart';
import 'package:haircut_delivery/model/address_model.dart';
import 'package:haircut_delivery/model/client_app_address.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/page/base_components/buttons/big_round_button.dart';
import 'package:haircut_delivery/page/base_components/drawer/client_app_drawer.dart';
import 'package:haircut_delivery/page/base_components/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/page/base_components/textfield/big_round_textfield.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/page/screens/pinlocation/pin_location_screen.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppAddAddressPage extends StatefulWidget {
  final ClientAppAddress address;
  final String typeAddress;

  ClientAppAddAddressPage({Key key, this.address, this.typeAddress})
      : super(key: key);

  @override
  _ClientAppAddAddressPageState createState() =>
      _ClientAppAddAddressPageState();
}

class _ClientAppAddAddressPageState extends State<ClientAppAddAddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  BitmapDescriptor _markerIcon;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String _titleAddress = "";
  String _address = "";
  List<String> _prefList = List<String>();

  double _latitude = 18.807268;
  double _longitude = 99.0159334;

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }).catchError((e) {
      print(e);
    });
  }

  bool _check() {
    if (_titleAddress == "" || _address == "") {
      return false;
    } else {
      return true;
    }
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('address');

    if (list != null) {
      _prefList.addAll(list);
      setState(() {
        AddressModel value = AddressModel(
          addressType: widget.typeAddress,
          addressTitle: _titleAddress,
          address: _address,
          addressLat: _latitude,
          addressLon: _longitude,
        );
        _prefList.add(json.encode(value));
        print('value to String ::  $_prefList');
        SharedPref().save('address', _prefList);
      });
    } else {
      setState(() {
        AddressModel value = AddressModel(
          addressType: widget.typeAddress,
          addressTitle: _titleAddress,
          address: _address,
          addressLat: _latitude,
          addressLon: _longitude,
        );
        _prefList.add(json.encode(value));
        print('value to String ::  $_prefList');
        SharedPref().save('address', _prefList);
      });
    }
  }

  void initState() {
    super.initState();
    _getCurrentLocation();
    _createMarkerImageFromAsset(context);

    if (widget.address != null) {
      _titleController.text = widget.address.addressTitle;
      _addressController.text = widget.address.address;
    }
    _markers.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _addressController.dispose();
  }

  void updateInformation(LatLng latLng) {
    setState(() {
      _latitude = latLng.latitude;
      _longitude = latLng.longitude;
      print('value of latLng :: $_latitude , $_longitude');
    });
  }

  void moveToSecondPage() async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) =>
              PinLocationScreen(latitude: _latitude, longitude: _longitude)),
    );
    updateInformation(information);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _markers.add(
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(18.807268, 99.0159334),
        anchor: const Offset(0.5, 0.8),
        icon: _markerIcon,
        infoWindow: InfoWindow(
          title: '',
          snippet: '',
        ),
      ),
    );
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
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));
    //ignore: close_sinks
    final ValidateBloc _bloc = context.bloc<ValidateBloc>();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClientAppDrawer(bgColor: Theme.of(context).primaryColor),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: TOOL_BAR_HEIGHT + 20, left: 15, right: 15),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: Text(
                                tr('edit_account_edit_address'),
                                style: textStyleWithLocale(context: context),
                              ),
                            ),
                            SizedBox(height: 10),
                            HorizontalLine(),
                            SizedBox(height: 10),
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is TitleAddressErrorState) {
                                return BigRoundTextField(
                                  hintText: tr('add_my_place_place_title'),
                                  controller: _titleController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(
                                        TitleAddressFieldEvent(value: value));
                                    setState(() {
                                      _titleAddress = value;
                                    });
                                  },
                                  errorText: state.errorText,
                                );
                              } else {
                                return BigRoundTextField(
                                  hintText: tr('add_my_place_place_title'),
                                  controller: _titleController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(
                                        TitleAddressFieldEvent(value: value));
                                    setState(() {
                                      _titleAddress = value;
                                    });
                                  },
                                );
                              }
                            }),
                            SizedBox(height: 10),
                            BlocBuilder<ValidateBloc, ValidateState>(builder:
                                (BuildContext context, ValidateState state) {
                              if (state is AddressErrorState) {
                                return BigRoundTextField(
                                  hintText: tr('add_my_place_address'),
                                  maxLines: 4,
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(AddressFieldEvent(value: value));
                                    setState(() {
                                      _address = value;
                                    });
                                  },
                                  errorText: state.errorText,
                                );
                              } else {
                                return BigRoundTextField(
                                  hintText: tr('add_my_place_address'),
                                  maxLines: 4,
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    _bloc.add(AddressFieldEvent(value: value));
                                    setState(() {
                                      _address = value;
                                    });
                                  },
                                );
                              }
                            }),
                            SizedBox(height: 10),
                            BigRoundButton(
                              callback: !_check()
                                  ? null
                                  : () {
                                      _saveData();
                                      Navigator.pop(context);
                                    },
                              color: !_check()
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor,
                              textButton: tr('btn_save'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          moveToSecondPage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Color(0xffdddddd)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    shape: BoxShape.rectangle,
                                  ),
                                  width: double.infinity,
                                  height: 300,
                                  child: GoogleMap(
                                    gestureRecognizers:
                                        <Factory<OneSequenceGestureRecognizer>>[
                                      Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
                                      ),
                                    ].toSet(),
                                    mapType: MapType.normal,
                                    markers: _markers,
                                    initialCameraPosition: CameraPosition(
                                      target: widget.address == null
                                          ? LatLng(18.807268, 99.0159334)
                                          : LatLng(widget.address.addressLat,
                                              widget.address.addressLon),
                                      zoom: 16,
                                    ),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  color: Colors.black54,
                                  width: double.infinity,
                                ),
                                Container(
                                  height: 300,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          tr('add_my_place_open_map'),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: marketPlaceToolbarHeight,
                child: ClientAppDefaultAppBar(
                  context: context,
                  scaffoldKey: _scaffoldKey,
                  isBack: true,
                  onPressedBackBtn: () => Navigator.pop(context),
                  isShowCart: false,
                  isShowMenu: false,
                  title: Text(
                    '',
                    style: textStyleWithLocale(
                      context: context,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
