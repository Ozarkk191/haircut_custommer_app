import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_services.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_shops.dart';
import 'package:haircut_delivery/clientapp/datas/service_categories.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_service_type_dialog_no_title.dart';
import 'package:haircut_delivery/clientapp/screens/near_me/widgets/category_avatar_item.dart';
import 'package:haircut_delivery/clientapp/screens/near_me/widgets/near_me_service_item.dart';
import 'package:haircut_delivery/clientapp/screens/place/client_app_place_list_page.dart';
import 'package:haircut_delivery/clientapp/screens/profile/client_app_shop_profile_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_search_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:permission_handler/permission_handler.dart';

class ClientAppNearMePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClientAppNearMePage({
    this.scaffoldKey,
    Key key,
  }) : super(key: key);

  @override
  _ClientAppNearMePageState createState() => _ClientAppNearMePageState();
}

class _ClientAppNearMePageState extends State<ClientAppNearMePage>
    with AutomaticKeepAliveClientMixin<ClientAppNearMePage> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  bool get wantKeepAlive => true;
  ServiceType _serviceType = ServiceType.BOOKING;
  List<ClientAppService> nearMeServices;

  // Global keys
  GlobalKey _googleMapKey = GlobalKey();
  Position _currentLocation;
  GeolocationStatus geoStatus;

  @override
  void initState() {
    super.initState();
    _getPermission();
    nearMeServices = [];
    final _services =
        clientAppServices.where((item) => item.parentCatId == 102).toList();
    nearMeServices.addAll(_services);
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
          geoStatus = GeolocationStatus.denied;
        });
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        setState(() {
          geoStatus = GeolocationStatus.restricted;
        });
        break;
      case GeolocationStatus.unknown:
        setState(() {
          geoStatus = GeolocationStatus.unknown;
        });
        break;
      case GeolocationStatus.granted:
        Position currloc = await Geolocator().getCurrentPosition();
        setState(() {
          geoStatus = GeolocationStatus.granted;
          _currentLocation = currloc;
        });
        break;
    }
  }

  void _showDialog({@required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClientAppServiceTypeDialogNoTitle(
          content: _buildDialogContent(context: context),
          actions: _buildActions(context: context),
        );
      },
    );
  }

  void _setServiceType({ServiceType serviceType = ServiceType.BOOKING}) {
    setState(() {
      _serviceType = serviceType;
    });
    Navigator.pop(context);
  }

  void _handleSelectedCat({@required ClientAppServiceCategory service}) {
    final services = clientAppServices.where((item) {
      return item.parentCatId == service.categoryId;
    }).toList();
    setState(() {
      nearMeServices.clear();
      nearMeServices.addAll(services);
    });
  }

  void _goToPage({@required ClientAppShop shop, int rnd}) {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppShopProfilePage(
          shop: shop,
          distance: rnd,
          serviceType: _serviceType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _returnMap(),
            Container(
              margin: EdgeInsets.only(top: marketPlaceNavToolbar + 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildCategory(),
                  nearMeServices.length > 0
                      ? _buildListView()
                      : _noServiceAvailable(),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        height: marketPlaceNavToolbar,
        child: ClientAppSearchAppBar(
          changeCallback: () => _showDialog(context: context),
          context: context,
          navigatorCallback: () => Navigator.push(
            context,
            SlideUpTransition(
              child: ClientAppPlaceListPage(),
            ),
          ),
          serviceType: _serviceType,
        ),
      ),
    ]);
  }

  Widget _returnMap() {
    Widget result;

    if (_currentLocation == null && geoStatus == null) {
      result = Center(
        child: CircularProgressIndicator(),
      );
    } else if (_currentLocation != null &&
        geoStatus == GeolocationStatus.granted) {
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
        child: RaisedButton(
          onPressed: _getPermission,
          child: Text(
            '${AppLocalizations.of(context).tr('client_app_please_enble_permission')}',
            style: textStyleWithLocale(context: context),
          ),
        ),
      );
    }

    return result;
  }

  Widget _buildCategory() {
    return Container(
      height: 125,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.chevron_left,
            size: 35,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () =>
                      _handleSelectedCat(service: serviceCategories[index]),
                  child: CategoryAvatarItem(
                    category: serviceCategories[index],
                  ),
                );
              },
              itemCount: serviceCategories.length,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 35,
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    final random = Random();
    final rnd = 1 + random.nextInt(12 - 1);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 180,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => _goToPage(
              shop: clientAppShops.firstWhere(
                  (item) => item.shopId == nearMeServices[index].shopId),
              rnd: rnd,
            ),
            child: NearMeServiceItem(
              service: nearMeServices[index],
              rnd: rnd,
            ),
          );
        },
        itemCount: nearMeServices.length,
      ),
    );
  }

  Widget _buildDialogContent({@required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/clientapp/images/ic_haircut_man.png'),
        SizedBox(height: 15),
        Text(
          AppLocalizations.of(context).tr('client_app_select_service_type'),
          style: textStyleWithLocale(
            context: context,
            color: Color(0xff6F6F6F),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions({@required BuildContext context}) {
    List<Widget> _actions = [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _actionBtn(
              context: context,
              callback: () => _setServiceType(serviceType: ServiceType.BOOKING),
              text: '${AppLocalizations.of(context).tr('client_app_booking')}',
            ),
            _actionBtn(
              context: context,
              callback: () =>
                  _setServiceType(serviceType: ServiceType.DELIVERY),
              text: '${AppLocalizations.of(context).tr('client_app_delivery')}',
            ),
          ],
        ),
      ),
    ];

    return _actions;
  }

  Widget _actionBtn(
      {@required BuildContext context, Function callback, String text}) {
    return CustomRoundButton(
      callback: callback,
      child: Text(
        text,
        style: textStyleWithLocale(
          context: context,
          fontSize: 16,
        ),
      ),
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _noServiceAvailable() {
    return Container(
      color: Colors.white54,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '${AppLocalizations.of(context).tr('client_app_no_services_available')}',
        style: textStyleWithLocale(
          context: context,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
