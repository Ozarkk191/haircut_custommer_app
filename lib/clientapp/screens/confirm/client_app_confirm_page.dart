import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_services.dart';
import 'package:haircut_delivery/clientapp/models/client_app_shop.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/widgets/client_app_home_card.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/widgets/client_app_shop_card.dart';
import 'package:haircut_delivery/clientapp/screens/confirm/widgets/client_selected_service_item.dart';
import 'package:haircut_delivery/clientapp/screens/payment/client_app_preview_payment_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppConfirmPage extends StatefulWidget {
  final ClientAppShop shop;
  final ServiceType serviceType;
  final int distance;

  ClientAppConfirmPage({
    Key key,
    @required this.shop,
    this.serviceType = ServiceType.BOOKING,
    this.distance = 1,
  })  : assert(shop != null),
        super(key: key);

  @override
  _ClientAppConfirmPageState createState() => _ClientAppConfirmPageState();
}

class _ClientAppConfirmPageState extends State<ClientAppConfirmPage> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 330,
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/clientapp/images/ic_clock.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'Wait for the Hair Cut to confirm',
                  style: textStyleWithLocale(
                    context: context,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'within 30 sec.',
                  style: textStyleWithLocale(
                    context: context,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'If waiting too long You can change the Hair Cut.',
                  style: textStyleWithLocale(
                    context: context,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                CustomRoundButton(
                  child: Text(
                    'Hide',
                    style: textStyleWithLocale(
                      context: context,
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  callback: () {
                    Navigator.pop(context);
                    _showDoneDialog(context: context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDoneDialog({@required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 270,
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/clientapp/images/ic_haircut_man.png',
                  width: 100,
                  height: 100,
                ),
                Text(
                  'Haircut Confirm Your Booking',
                  style: textStyleWithLocale(
                    context: context,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CustomRoundButton(
                  child: Text(
                    'Done',
                    style: textStyleWithLocale(
                      context: context,
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  callback: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      SlideUpTransition(
                        child: ClientAppPreviewPaymentPage(
                          serviceType: ServiceType.BOOKING,
                          shop: widget.shop,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
                    widget.serviceType == ServiceType.BOOKING
                        ? _buildBookingShop()
                        : _buildDeliveryShop(),
                    SizedBox(height: 15),
                    _buildSummary(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: CustomRoundButton(
                        color: Color(0xff009900),
                        child: Text(
                          'Confirm',
                          style: textStyleWithLocale(
                            context: context,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        callback: () => _showDialog(context: context),
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
              '',
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
              '',
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

  Widget _buildDeliveryShop() {
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
              '',
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
              '',
              style: textStyleWithLocale(
                context: context,
                color: Colors.white,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15),
            ClientAppHomeCart(),
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
            '',
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
          '',
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
                    'Date',
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
                    'Time',
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
          'Total Price',
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
                'Total',
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
