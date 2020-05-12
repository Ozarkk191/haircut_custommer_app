import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_services.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/client_app_confirm_page.dart';
import 'package:haircut_delivery/clientapp/screens/profile/widgets/client_app_icon_btn.dart';
import 'package:haircut_delivery/clientapp/screens/profile/widgets/client_app_service_row_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_transparent_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppShopProfilePage extends StatefulWidget {
  final ClientAppShop shop;
  final int distance;
  final ServiceType serviceType;

  ClientAppShopProfilePage({
    Key key,
    @required this.shop,
    this.distance = 1,
    this.serviceType = ServiceType.BOOKING,
  })  : assert(shop != null),
        super(key: key);

  @override
  _ClientAppShopProfilePageState createState() =>
      _ClientAppShopProfilePageState();
}

class _ClientAppShopProfilePageState extends State<ClientAppShopProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  bool _isFav;
  Set<Marker> _markers = Set();
  BitmapDescriptor _markerIcon;
  List<ClientAppService> serviceCart;
  Map<ClientAppService, int> cart;

  @override
  void initState() {
    super.initState();
    serviceCart = [];
    cart = {};
    _createMarkerImageFromAsset(context);
    _isFav = false;
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(widget.shop.latitude, widget.shop.longitude),
        anchor: const Offset(0.5, 0.8),
        icon: _markerIcon,
        infoWindow: InfoWindow(
          title: '${widget.shop.shopName}',
          snippet: '${widget.shop.address}',
        ),
      ),
    );
  }

  void _handleFav() {
    setState(() {
      _isFav = !_isFav;
    });
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

  void _onAddService({@required ClientAppService service}) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _buildBuyModalSheet(
                  state: state,
                  service: service,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDialog({@required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 370,
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 50,
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'February 2020',
                      style: textStyleWithLocale(
                        context: context,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _buildDate(),
                SizedBox(height: 5),
                HorizontalLine(),
                _buildListTile(),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _addQuantity({@required ClientAppService service}) {
  //   print(service.price);
  //   if (serviceCart.contains(service)) {
  //   } else {
  //     serviceCart.add(service);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClientAppDrawer(bgColor: Theme.of(context).primaryColor),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildProfileImage(),
                    _buildShopData(context),
                    HorizontalLine(),
                    _buildServiceListSection(),
                  ],
                ),
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppTransparentAppBar(
                context: context,
                isBack: true,
                onPressedBackBtn: () => Navigator.pop(context),
                onPressedFavBtn: _handleFav,
                isFav: _isFav,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopData(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${widget.shop.shopName}',
                style: textStyleWithLocale(
                  context: context,
                  color: Color(0xff707070),
                  fontSize: 20,
                ),
              ),
              Text(
                '${widget.distance} km',
                style: textStyleWithLocale(
                  context: context,
                  color: Color(0xff707070),
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/ic_marker_2.png'),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${widget.shop.address}',
                  style: textStyleWithLocale(
                    context: context,
                    color: Color(0xff707070),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            tr('client_app_counting'),
            style: textStyleWithLocale(
              context: context,
              color: Color(0xff707070),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Text(
                tr('client_app_review_counting'),
                style: textStyleWithLocale(
                  context: context,
                  color: Color(0xff707070),
                ),
              ),
              SizedBox(width: 10),
              RatingBar(
                initialRating: widget.shop.rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0),
                itemSize: 18.0,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // print(rating);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      color: Colors.white,
      height: 250,
      child: widget.shop.avatarUrl != null
          ? Image.asset(
              'assets/clientapp/mockup/shops/${widget.shop.avatarUrl}',
              fit: BoxFit.cover,
            )
          : Container(color: Colors.red),
    );
  }

  Widget _buildServiceListSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            tr('client_app_service_list'),
            style: textStyleWithLocale(
              context: context,
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          _buildAllServiceList(),
          SizedBox(height: 20),
          _buildBookingButton(),
          SizedBox(height: 20),
          HorizontalLine(),
          SizedBox(height: 20),
          _shopLocation(),
        ],
      ),
    );
  }

  Widget _buildAllServiceList() {
    final services = clientAppServices
        .where((item) => item.shopId == widget.shop.shopId)
        .toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ClientAppServiceRowItem(
          service: services[index],
          callback: () => _onAddService(service: services[index]),
        );
      },
      itemCount: services.length,
      separatorBuilder: (BuildContext context, int index) {
        return HorizontalLine();
      },
    );
  }

  Widget _buildBookingButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: CustomRoundButton(
        color: Color(0xff009900),
        elevation: 3,
        child: Text(
          tr('btn_continue'),
          style: textStyleWithLocale(
            context: context,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        callback: () => _showDialog(context: context),
      ),
    );
  }

  Widget _shopLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          tr('shop_location'),
          style: textStyleWithLocale(
            context: context,
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Color(0xffdddddd)),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              shape: BoxShape.rectangle,
            ),
            width: double.infinity,
            height: 300,
            child: GoogleMap(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              ].toSet(),
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.shop.latitude, widget.shop.longitude),
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyModalSheet(
      {@required Function state, @required ClientAppService service}) {
    double chargePrice = 0;

    if (service.discount > 0) {
      chargePrice = service.price - service.discount;
    } else {
      chargePrice = service.price;
    }

    return Stack(
      children: <Widget>[
        Container(
          decoration: _buildRoundBoxDecoration(color: Colors.white),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: _buildRoundBoxDecoration(),
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${service.serviceName}',
                        style: _buyTextStyle(),
                      ),
                    ),
                    Text(
                      '฿ $chargePrice',
                      style: _buyTextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              HorizontalLine(),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: <Widget>[
                    Text(
                      '',
                      style: _buyTextStyle(textSize: 14),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '',
                      style: _buyTextStyle(
                        textSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  // style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                    contentPadding: const EdgeInsets.only(
                      left: 14.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 130),
                child: Row(
                  children: <Widget>[
                    ClientAppIconBtn(
                      callback: () {},
                      // callback: () => _addQuantity(service: service),
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: textStyleWithLocale(
                            context: context,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ClientAppIconBtn(
                      callback: () {},
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: CustomRoundButton(
                  color: Theme.of(context).primaryColor,
                  elevation: 2,
                  child: Text(
                    '',
                    style: textStyleWithLocale(
                      context: context,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  callback: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildRoundBoxDecoration({
    double radius = 15,
    Color color = Colors.white,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

  TextStyle _buyTextStyle(
      {double textSize = 16, FontWeight fontWeight = FontWeight.w400}) {
    return textStyleWithLocale(
      context: context,
      fontSize: textSize,
      color: Color(0xff707070),
      fontWeight: fontWeight,
    );
  }

  Widget _buildDate() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Sun'),
              Text('9'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Mon'),
              Text('10'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Tue'),
              Text('11'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Wed'),
              Text('12'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Thu'),
              Text('13'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Fri'),
              Text('14'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Sat'),
              Text('15'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTile() {
    List<String> times = ['10:00', '11:00', '12:00', '13:00', '14:00', '15:00'];

    return Container(
      height: 250,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(times[index]),
            trailing: _buildReserveButton(context: context),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return HorizontalLine();
        },
        itemCount: times.length,
      ),
    );
  }

  Widget _buildReserveButton({@required BuildContext context}) {
    return Container(
      height: 25,
      width: 60,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0),
        color: Color(0xff1DAD1D),
        onPressed: () {
          Navigator.pop(context);

          Navigator.push(
            context,
            SlideUpTransition(
              child: ClientAppConfirmPage(
                shop: widget.shop,
                distance: widget.distance,
                serviceType: widget.serviceType,
              ),
            ),
          );
        },
        child: Text(
          tr('client_app_reserve'),
          style: textStyleWithLocale(
            context: context,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
