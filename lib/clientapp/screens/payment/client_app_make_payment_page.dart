import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/screens/home/clientapp_home_screen.dart';
import 'package:haircut_delivery/clientapp/screens/payment/widgets/parment_row_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppMakePaymentPage extends StatefulWidget {
  ClientAppMakePaymentPage({
    Key key,
  }) : super(key: key);

  @override
  _ClientAppMakePaymentPageState createState() =>
      _ClientAppMakePaymentPageState();
}

class _ClientAppMakePaymentPageState extends State<ClientAppMakePaymentPage> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PaymentOptions paymentOption;

  @override
  void initState() {
    super.initState();
    paymentOption = PaymentOptions.WALLET;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _handleCheck({@required PaymentOptions option}) {
    setState(() {
      paymentOption = option;
    });
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
            height: 150,
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_delivery.png',
                      color: Theme.of(context).primaryColor,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tr('client_app_payment_success'),
                        style: textStyleWithLocale(
                          context: context,
                          fontSize: 16,
                          color: Color(0xff707070),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomRoundButton(
                  child: Text(
                    'OK',
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
                        child: ClientAppHomeScreen(),
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
                    SizedBox(height: 100),
                    _buildPaymentOptionList(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: CustomRoundButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          tr('client_app_submit'),
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

  Widget _buildPaymentOptionList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            tr('client_app_choose_payment_options'),
            style: textStyleWithLocale(
              context: context,
              color: Color(0xff707070),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () => _handleCheck(option: PaymentOptions.WALLET),
            child: PaymentRowItem(
              icon: Image.asset('assets/images/ic_coin.png'),
              title: Text('Wallet ฿99,999'),
              isSelected: paymentOption == PaymentOptions.WALLET ? true : false,
            ),
          ),
          InkWell(
            onTap: () => _handleCheck(option: PaymentOptions.CARD),
            child: PaymentRowItem(
              icon: Image.asset('assets/clientapp/images/ic_card.png'),
              title: Text('Wallet ฿99,999'),
              isSelected: paymentOption == PaymentOptions.CARD ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}

enum PaymentOptions { WALLET, CARD }
