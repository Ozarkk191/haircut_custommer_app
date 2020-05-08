import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/models/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/screens/content/client_app_content_page.dart';
import 'package:haircut_delivery/clientapp/screens/home/widgets/client_app_coupon_item.dart';
import 'package:haircut_delivery/clientapp/screens/points/client_app_my_coupon_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppMyPointPage extends StatelessWidget {
  // Global key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ClientAppMyPointPage({
    Key key,
  }) : super(key: key);

  void _goToCouponPage(
      {@required ClientAppCoupon coupon, @required BuildContext context}) {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppContentPage(
          appbarTitle: 'Coupon',
          image: Image.asset(
            'assets/clientapp/mockup/coupons/${coupon.couponImageUrl}',
            fit: BoxFit.cover,
          ),
          content: coupon.content,
          contentTitle: coupon.title,
        ),
      ),
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: TOOL_BAR_HEIGHT, left: 15, right: 15, bottom: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20),
                    _buildPoints(context: context),
                    SizedBox(height: 20),
                    Text(
                      '${AppLocalizations.of(context).tr('client_app_recommended_for_you')}',
                      style: textStyleWithLocale(
                        context: context,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildRecommendedCoupons(),
                    SizedBox(height: 20),
                    Text(
                      '${AppLocalizations.of(context).tr('client_app_redeem_point')}',
                      style: textStyleWithLocale(
                        context: context,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildCouponGridView(context: context),
                  ],
                ),
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppDefaultAppBar(
                title: Text(
                  'Point',
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

  Widget _buildPoints({@required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          '${AppLocalizations.of(context).tr('client_app_all_my_points')}',
          style: textStyleWithLocale(
            context: context,
            color: Color(0xff707070),
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/ic_point.png',
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              '99,999',
              style: textStyleWithLocale(
                context: context,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  SlideUpTransition(
                    child: ClientAppMyCouponPage(),
                  ),
                );
              },
              child: Text(
                '${AppLocalizations.of(context).tr('account_my_coupon')}',
                style: textStyleWithLocale(
                  context: context,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(width: 15),
            // RaisedButton(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   elevation: 0,
            //   color: Theme.of(context).primaryColor,
            //   onPressed: () {},
            //   child: Text(
            //     '${AppLocalizations.of(context).tr('menu_history')}',
            //     style: textStyleWithLocale(
            //       context: context,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 10),
        HorizontalLine(),
      ],
    );
  }

  Widget _buildRecommendedCoupons() {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => _goToCouponPage(
                  coupon: clientAppCoupons[index], context: context),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  child: Image.asset(
                    'assets/clientapp/mockup/coupons/${clientAppCoupons[index].couponImageUrl}',
                    width: 230,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: clientAppCoupons.length,
      ),
    );
  }

  Widget _buildCouponGridView({@required BuildContext context}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 1.45,
        children: List.generate(clientAppCoupons.length, (index) {
          return InkWell(
            onTap: () => _goToCouponPage(
                coupon: clientAppCoupons[index], context: context),
            child: ClientAppCouponItem(
              clientAppCoupon: clientAppCoupons[index],
            ),
          );
        }),
      ),
    );
  }
}
