import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_user.dart';
import 'package:haircut_delivery/clientapp/models/client_app_coupons.dart';
import 'package:haircut_delivery/clientapp/screens/account/view_profile/view_profile_screen.dart';
import 'package:haircut_delivery/clientapp/screens/activity/clientapp_activity_page.dart';
import 'package:haircut_delivery/clientapp/screens/content/client_app_content_page.dart';
import 'package:haircut_delivery/clientapp/screens/home/widgets/client_app_coupon_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/avatar/custom_circle_avatar.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_btn_group.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';

class ClientAppAccountPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClientAppAccountPage({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _ClientAppAccountPageState createState() => _ClientAppAccountPageState();
}

class _ClientAppAccountPageState extends State<ClientAppAccountPage>
    with AutomaticKeepAliveClientMixin<ClientAppAccountPage> {
  @override
  bool get wantKeepAlive => true;

  void _goToCouponPage({@required ClientAppCoupon coupon}) {
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
    super.build(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: TOOL_BAR_HEIGHT + 20,
                  bottom: 10,
                ),
                color: Colors.white,
                child: _buildBtnGroup(),
              ),
              _buildProfile(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  'My Coupon',
                  style: textStyleWithLocale(
                    context: context,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildCouponGridView(),
            ],
          ),
        ),
        Container(
          height: marketPlaceToolbarHeight,
          child: ClientAppDefaultAppBar(
            isBack: false,
            isShowCart: false,
            isShowMenu: true,
            context: context,
            scaffoldKey: widget.scaffoldKey,
            title: Text(
              'Account',
              style: textStyleWithLocale(
                  context: context, color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildBtnGroup() {
    return CustomBtnGroup(
      widgets: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppActivityPage(
                  title: 'Activity',
                  activityType: 'Booking',
                ),
              ),
            );
          },
          child: Text(
            'Booking',
            style: _redText(),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppActivityPage(
                  title: 'Activity',
                  activityType: 'Delivery',
                ),
              ),
            );
          },
          child: Text(
            'Delivery',
            style: _redText(),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              SlideUpTransition(
                child: ClientAppActivityPage(
                  title: 'Activity',
                  activityType: 'History',
                ),
              ),
            );
          },
          child: Text(
            'History',
            style: _redText(),
          ),
        ),
      ],
    );
  }

  TextStyle _redText() {
    return textStyleWithLocale(
        context: context, color: Color(0xffE2002D), fontSize: 16);
  }

  Widget _buildCouponGridView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        primary: true,
        crossAxisCount: 2,
        childAspectRatio: 1.45,
        children: List.generate(clientAppCoupons.length, (index) {
          return InkWell(
            onTap: () => _goToCouponPage(coupon: clientAppCoupons[index]),
            child: ClientAppCouponItem(
              clientAppCoupon: clientAppCoupons[index],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfile() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 80,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 0.5), //(x,y)
                blurRadius: 0.5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(70)),
            child: Container(
              padding: EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  CustomCircleAvatar(user: clientAppUser),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${clientAppUser.fullName}',
                          style: textStyleWithLocale(
                            context: context,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Phone: ${clientAppUser.phone}',
                          style: textStyleWithLocale(
                            context: context,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          'Email: ${clientAppUser.email}',
                          style: textStyleWithLocale(
                            context: context,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewProfileScreen()));
                    },
                    child: Container(
                      height: 25,
                      width: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
