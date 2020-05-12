import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_services.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/widgets/client_app_shop_card.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/widgets/client_selected_service_item.dart';
import 'package:haircut_delivery/clientapp/screens/payment/client_app_make_payment_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppPreviewPaymentPage extends StatefulWidget {
  final ClientAppShop shop;
  final ServiceType serviceType;
  final int distance;

  ClientAppPreviewPaymentPage({
    Key key,
    @required this.shop,
    this.serviceType = ServiceType.BOOKING,
    this.distance = 1,
  })  : assert(shop != null),
        super(key: key);

  @override
  _ClientAppPreviewPaymentPageState createState() =>
      _ClientAppPreviewPaymentPageState();
}

class _ClientAppPreviewPaymentPageState
    extends State<ClientAppPreviewPaymentPage> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildBookingShop(),
                    SizedBox(height: 15),
                    _buildSummary(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: CustomRoundButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          tr('client_app_payment'),
                          style: textStyleWithLocale(
                            context: context,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        callback: () {
                          Navigator.push(
                            context,
                            SlideUpTransition(
                              child: ClientAppMakePaymentPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppDefaultAppBar(
                isShowCart: false,
                isShowMenu: false,
                context: context,
                isBack: true,
                onPressedBackBtn: () => Navigator.pop(context),
                title: Text(''),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingShop() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: TOOL_BAR_HEIGHT + 20, left: 15, right: 15, bottom: 20),
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              tr('client_app_your_cart'),
              style: textStyleWithLocale(
                context: context,
                color: Colors.white,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Text(
              tr('client_app_your_selected'),
              style: textStyleWithLocale(
                context: context,
                color: Colors.white,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15),
            ClientAppShopCart(
              shop: widget.shop,
              distance: widget.distance,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            tr('client_app_your_services'),
            style: textStyleWithLocale(
              context: context,
              color: Color(0xff707070),
              fontSize: 16,
            ),
          ),
          _buildList(),
          HorizontalLine(),
          SizedBox(height: 10),
          _buildBookingTime(),
          SizedBox(height: 10),
          HorizontalLine(),
          SizedBox(height: 10),
          _buildTotalPrice(),
          SizedBox(height: 10),
          HorizontalLine(),
        ],
      ),
    );
  }

  Widget _buildList() {
    final _list = clientAppServices
        .where((item) => item.shopId == widget.shop.shopId)
        .toList();

    return ListView.separated(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ClientAppSelectedServiceItem(service: _list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return HorizontalLine();
      },
      itemCount: _list.length,
    );
  }

  Widget _buildBookingTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          tr('client_app_booking_time'),
          style: textStyleWithLocale(
              context: context, color: Color(0xffDD133B), fontSize: 20),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    tr('client_app_date'),
                    style: textStyleWithLocale(context: context, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '12 February 2020',
                    style: textStyleWithLocale(
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    tr('client_app_time'),
                    style: textStyleWithLocale(context: context, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '10:00',
                    style: textStyleWithLocale(
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          tr('client_app_total_price'),
          style: textStyleWithLocale(
              context: context, color: Color(0xffDD133B), fontSize: 20),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Service',
                style: textStyleWithLocale(context: context, fontSize: 16),
              ),
            ),
            Text(
              '฿ 450',
              style: textStyleWithLocale(
                context: context,
                fontSize: 16,
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                tr('client_app_total'),
                style: textStyleWithLocale(
                  context: context,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              '฿ 450',
              style: textStyleWithLocale(
                context: context,
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}
