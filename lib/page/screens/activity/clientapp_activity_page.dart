import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/datas/client_app_services.dart';
import 'package:haircut_delivery/datas/client_app_shops.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/page/base_components/drawer/client_app_drawer.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/page/screens/activity/widgets/activity_item.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppActivityPage extends StatefulWidget {
  final String title;
  final String activityType;

  // Global key

  ClientAppActivityPage(
      {Key key, @required this.title, @required this.activityType})
      : assert(title != null),
        assert(activityType != null),
        super(key: key);

  @override
  _ClientAppActivityPageState createState() => _ClientAppActivityPageState();
}

class _ClientAppActivityPageState extends State<ClientAppActivityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _activityState;
  final booking = [
    clientAppServices[1],
    clientAppServices[15],
    clientAppServices[25]
  ];
  final delivery = [
    clientAppServices[10],
    clientAppServices[45],
    clientAppServices[35]
  ];
  final history = [
    clientAppServices[20],
    clientAppServices[15],
    clientAppServices[25],
    clientAppServices[44],
  ];

  @override
  void initState() {
    super.initState();
    _activityState = widget.activityType;
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ClientAppDrawer(bgColor: Theme.of(context).primaryColor),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: TOOL_BAR_HEIGHT, left: 15, right: 15, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  _builBtns(),
                  SizedBox(height: 20),
                  _buildListView(),
                ],
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppDefaultAppBar(
                title: Text(
                  '${widget.title}',
                  style: textStyleWithLocale(
                    context: context,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                context: context,
                scaffoldKey: _scaffoldKey,
                isBack: true,
                isShowCart: false,
                isShowMenu: true,
                onPressedBackBtn: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
            ),
            child: Container(
              height: 45,
              color: _activityState == 'Booking'
                  ? Color(0xffDD133B)
                  : Color(0xffF9CCD0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _activityState = 'Booking';
                  });
                },
                child: Text(
                  'Booking',
                  style:
                      _activityState == 'Booking' ? _whiteText() : _redText(),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 45,
            color: _activityState == 'Delivery'
                ? Color(0xffDD133B)
                : Color(0xffF9CCD0),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _activityState = 'Delivery';
                });
              },
              child: Text(
                'Delivery',
                style: _activityState == 'Delivery' ? _whiteText() : _redText(),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
            ),
            child: Container(
              height: 45,
              color: _activityState == 'History'
                  ? Color(0xffDD133B)
                  : Color(0xffF9CCD0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _activityState = 'History';
                  });
                },
                child: Text(
                  'History',
                  style:
                      _activityState == 'History' ? _whiteText() : _redText(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _redText() {
    return textStyleWithLocale(
        context: context, color: Color(0xffE2002D), fontSize: 16);
  }

  TextStyle _whiteText() {
    return textStyleWithLocale(
        context: context, color: Colors.white, fontSize: 16);
  }

  Widget _buildListView() {
    List<ClientAppService> list;
    if (_activityState == 'Booking') {
      list = booking;
    } else if (_activityState == 'Delivery') {
      list = delivery;
    } else {
      list = history;
    }

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var shop = clientAppShops
              .firstWhere((item) => item.shopId == list[index].shopId);
          return ActivityItem(
            service: list[index],
            shop: shop,
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
