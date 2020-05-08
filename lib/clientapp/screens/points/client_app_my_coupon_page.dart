import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/models/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/screens/content/client_app_content_page.dart';
import 'package:haircut_delivery/clientapp/screens/home/widgets/client_app_coupon_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppMyCouponPage extends StatelessWidget {
  ClientAppMyCouponPage({
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
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: TOOL_BAR_HEIGHT, left: 10, right: 10, bottom: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                  '${AppLocalizations.of(context).tr('account_my_coupon')}',
                  style: textStyleWithLocale(
                    context: context,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                context: context,
                isBack: true,
                isShowCart: false,
                isShowMenu: false,
                onPressedBackBtn: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
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
        childAspectRatio: 1.6,
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
