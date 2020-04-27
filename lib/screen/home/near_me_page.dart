import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/bloc/service_bloc.dart';
import 'package:haircut_delivery/bloc/shop_list_bloc.dart';
import 'package:haircut_delivery/model/api_response.dart';
import 'package:haircut_delivery/model/shop.dart';
import 'package:haircut_delivery/screen/myplacelist/my_place_list_screen.dart';
import 'package:haircut_delivery/screen/shop/shop_screen.dart';
import 'package:haircut_delivery/ui/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearMePage extends StatefulWidget {
  @override
  _NearMePageState createState() => _NearMePageState();
}

class _NearMePageState extends State<NearMePage>
    with AutomaticKeepAliveClientMixin<NearMePage> {
  // BLoC
  final _serviceBloc = ServiceBloc();
  final _shopListBloc = ShopListBloc();

  // Global keys
  GlobalKey _googleMapKey = GlobalKey();

  // Input controllers
  final _googleMapController = Completer<GoogleMapController>();

  // Data
  Set<Marker> _markers = Set();
  String _myLocationName;
  double _myLatitude;
  double _myLongitude;

  @override
  void dispose() {
    _serviceBloc.dispose();
    _shopListBloc.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      GoogleMap(
        key: _googleMapKey,
        mapType: MapType.normal,
        initialCameraPosition: _myLatitude != null && _myLongitude != null
            ? CameraPosition(
                target: LatLng(_myLatitude, _myLongitude), zoom: 16)
            : CameraPosition(target: LatLng(18.817132, 98.986681), zoom: 16),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);

          // Fetch saved my location.
          _fetchMyLocation();
        },
        myLocationEnabled: true,
        padding: EdgeInsets.only(top: 70),
      ),
      _buildShopList(),
      _buildSearchSection(context),
    ]);
  }

  /// Fetches saved my location.
  Future _fetchMyLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final myLocationName = prefs.getString('myLocationName');
    _myLatitude = prefs.getDouble('myLatitude');
    _myLongitude = prefs.getDouble('myLongitude');
    if (_myLatitude != null && _myLongitude != null) {
      setState(() {
        _myLocationName = myLocationName ??
            AppLocalizations.of(context).tr('home_current_location');
      });
      _showLocationOnMap();
      _shopListBloc.fetchShopList();
    } else {
      setState(() {
        _myLocationName = null;
      });
    }
  }

  /// Shows a marker on the map at my location and zoom the camera to that position.
  _showLocationOnMap() async {
    if (_myLatitude != null && _myLongitude != null) {
      setState(() {
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId('myLocation'),
          position: LatLng(_myLatitude, _myLongitude),
          anchor: const Offset(0.5,
              0.8), // For some reason Offset(0.5, 1.0) doesn't set the pin's leg at the exact position. Offset(0.5, 0.8) looks better.
        ));
      });

      final GoogleMapController controller = await _googleMapController.future;
      controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(_myLatitude, _myLongitude), zoom: 16)));
    }
  }

  /// Builds the search section.
  Widget _buildSearchSection(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyPlacesListScreen()));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset('assets/images/ic_marker_2.png'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 10),
                            child: Text(
                              _myLocationName ??
                                  AppLocalizations.of(context)
                                      .tr('home_pin_location'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(_myLocationName != null
                                    ? 0xFF707070
                                    : 0x66707070),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  /// Builds the shop list section.
  Widget _buildShopList() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: StreamBuilder<ApiResponse<List<Shop>>>(
            stream: _shopListBloc.shopListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final shopList = snapshot.data?.data ?? [];
                return ListView.builder(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: shopList.length,
                  itemBuilder: (context, index) {
                    final shop = shopList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new ShopScreen(shop: shop)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 110,
                              height: 70,
                              child: CachedNetworkImage(
                                imageUrl: shop.avatarUrl ?? '',
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    LoadingIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(shop.name,
                                  style: TextStyle(fontSize: 12)),
                            ),
                            Text(shop.distance.toString() + " km",
                                style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}
