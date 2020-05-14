import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/datas/client_app_services.dart';
import 'package:haircut_delivery/datas/client_app_shops.dart';
import 'package:haircut_delivery/datas/nearme_categories.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_search_appbar.dart';
import 'package:haircut_delivery/page/base_components/buttons/custom_round_button.dart';
import 'package:haircut_delivery/page/base_components/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_service_type_dialog_no_title.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_shop_item.dart';
import 'package:haircut_delivery/page/screens/near_me/widgets/category_avatar_item.dart';
import 'package:haircut_delivery/page/screens/place/client_app_place_list_page.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

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
  @override
  bool get wantKeepAlive => true;
  ServiceType _serviceType = ServiceType.BOOKING;
  List<ClientAppService> nearMeServices;

  GeolocationStatus geoStatus;

  String _categoryStatus = "Near Me (All)";

  @override
  void initState() {
    super.initState();
    // _getPermission();
    nearMeServices = [];
    final _services =
        clientAppServices.where((item) => item.parentCatId == 102).toList();
    nearMeServices.addAll(_services);
  }

  // _getPermission() async {
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.location);
  //   if (permission == PermissionStatus.denied) {
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.locationAlways]);
  //   }

  //   var geolocator = Geolocator();
  //   GeolocationStatus geolocationStatus =
  //       await geolocator.checkGeolocationPermissionStatus();

  //   switch (geolocationStatus) {
  //     case GeolocationStatus.denied:
  //       setState(() {
  //         geoStatus = GeolocationStatus.denied;
  //       });
  //       break;
  //     case GeolocationStatus.disabled:
  //     case GeolocationStatus.restricted:
  //       setState(() {
  //         geoStatus = GeolocationStatus.restricted;
  //       });
  //       break;
  //     case GeolocationStatus.unknown:
  //       setState(() {
  //         geoStatus = GeolocationStatus.unknown;
  //       });
  //       break;
  //     case GeolocationStatus.granted:
  //       setState(() {
  //         geoStatus = GeolocationStatus.granted;
  //       });
  //       break;
  //   }
  // }

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

  void moveToSecondPage() async {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppPlaceListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: marketPlaceNavToolbar + 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildCategory(),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _categoryStatus,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 30,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text(
                              'Booking',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text(
                              'Delivery',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              _buildServiceItemList()
            ],
          ),
        ),
      ),
      Container(
        height: marketPlaceNavToolbar,
        child: ClientAppSearchAppBar(
          changeCallback: () => _showDialog(context: context),
          context: context,
          navigatorCallback: () {
            moveToSecondPage();
          },
          serviceType: _serviceType,
        ),
      ),
    ]);
  }

  Widget _buildCategory() {
    return Container(
      height: 125,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    _categoryStatus =
                        "Near Me (${nearmeCategories[index].categoryNameTH})";
                  },
                  child: CategoryAvatarItem(
                    category: nearmeCategories[index],
                  ),
                );
              },
              itemCount: nearmeCategories.length,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildListView() {
  //   final random = Random();
  //   final rnd = 1 + random.nextInt(12 - 1);

  //   return Container(
  //     margin: EdgeInsets.only(bottom: 10),
  //     height: 180,
  //     width: double.infinity,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (BuildContext context, int index) {
  //         return InkWell(
  //           onTap: () => _goToPage(
  //             shop: clientAppShops.firstWhere(
  //                 (item) => item.shopId == nearMeServices[index].shopId),
  //             rnd: rnd,
  //           ),
  //           child: NearMeServiceItem(
  //             service: nearMeServices[index],
  //             rnd: rnd,
  //           ),
  //         );
  //       },
  //       itemCount: nearMeServices.length,
  //     ),
  //   );
  // }

  Widget _buildDialogContent({@required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/clientapp/images/ic_haircut_man.png'),
        SizedBox(height: 15),
        Text(
          'client_app_select_service_type',
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
              text: 'client_app_booking',
            ),
            _actionBtn(
              context: context,
              callback: () =>
                  _setServiceType(serviceType: ServiceType.DELIVERY),
              text: 'client_app_delivery',
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

  // Widget _noServiceAvailable() {
  //   return Container(
  //     color: Colors.white54,
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(vertical: 20),
  //     child: Text(
  //       '${AppLocalizations.of(context).tr('client_app_no_services_available')}',
  //       style: textStyleWithLocale(
  //         context: context,
  //         fontSize: 18,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  Widget _buildServiceItemList() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          return ClientAppServiceItem(
            clientAppService: nearMeServices[index],
            callback: () {},
            shop: clientAppShops.firstWhere(
                (item) => item.shopId == nearMeServices[index].shopId),
          );
        },
        itemCount: nearMeServices.length,
      ),
    );
  }
}
