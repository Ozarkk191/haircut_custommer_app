import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/datas/client_app_services.dart';
import 'package:haircut_delivery/datas/client_app_shops.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/model/client_app_service_category.dart';
import 'package:haircut_delivery/model/client_app_shop.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_navigator_appbar.dart';
import 'package:haircut_delivery/page/base_components/drawer/client_app_drawer.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/page/base_components/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/page/screens/home/widgets/client_app_shop_item.dart';
import 'package:haircut_delivery/page/screens/place/client_app_place_list_page.dart';
import 'package:haircut_delivery/page/screens/profile/client_app_shop_profile_page.dart';
import 'package:haircut_delivery/page/screens/service_list/widgets/client_app_shop_item.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppServiceListPage extends StatefulWidget {
  final ClientAppServiceCategory category;
  final ServiceType serviceType;

  ClientAppServiceListPage({
    Key key,
    @required this.category,
    this.serviceType = ServiceType.BOOKING,
  })  : assert(category != null),
        super(key: key);

  @override
  _ClientAppServiceListPageState createState() =>
      _ClientAppServiceListPageState();
}

class _ClientAppServiceListPageState extends State<ClientAppServiceListPage> {
  double _height;
  ScrollController _scrollController = ScrollController();
  List<ClientAppService> _newList = List<ClientAppService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.category.categoryId == 97 ||
        widget.category.categoryId == 102 ||
        widget.category.categoryId == 60 ||
        widget.category.categoryId == 5) {
      final List<ClientAppService> catServices = clientAppServices
          .where((item) => item.parentCatId == widget.category.categoryId)
          .toList();
      _newList.addAll(catServices.take(5).toList());
    } else {
      _newList.addAll(clientAppServices.take(5).toList());
    }
    _height = 130.0 * 5;
  }

  Future<void> _fetch() async {
    setState(() {
      if (_newList.length < 10) {
        if (widget.category.categoryId == 97 ||
            widget.category.categoryId == 102 ||
            widget.category.categoryId == 60 ||
            widget.category.categoryId == 5) {
          final List<ClientAppService> catServices = clientAppServices
              .where((item) => item.parentCatId == widget.category.categoryId)
              .toList();
          _newList.addAll(catServices.skip(_newList.length).take(5).toList());
        } else {
          _newList
              .addAll(clientAppServices.skip(_newList.length).take(5).toList());
        }
        _height = 130.0 * _newList.length;
      }
    });
  }

  void _goToProfile({@required ClientAppShop shop}) {
    Navigator.push(
      context,
      SlideUpTransition(
        child: ClientAppShopProfilePage(
          shop: shop,
        ),
      ),
    );
  }

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
                color: Color(0xffE4E4E4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildBestHaircut(),
                    SizedBox(height: 15),
                    _buildBookingList(),
                    _buildServiceItemList(),
                    _newList.length < 10
                        ? Container(
                            color: Colors.white,
                            child: FlatButton(
                              onPressed: _fetch,
                              child: Text(
                                tr('marketplace_see_more'),
                                style: textStyleWithLocale(
                                  context: context,
                                  fontSize: 16,
                                  color: Color(0xff707070),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        : Container(height: 0, width: 0),
                  ],
                ),
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppNavigatorAppBar(
                context: context,
                isBack: true,
                onPressedBackBtn: () => Navigator.pop(context),
                navigatorCallback: () => Navigator.push(
                  context,
                  SlideUpTransition(
                    child: ClientAppPlaceListPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestHaircut() {
    // String languageCode = Localizations.localeOf(context).languageCode;

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
              tr('client_app_the_best'),
              style: textStyleWithLocale(
                context: context,
                color: Colors.white,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 15),
            _buildBestHaircutListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildBestHaircutListView() {
    // if (widget.category.categoryId == 97 ||
    //     widget.category.categoryId == 102 ||
    //     widget.category.categoryId == 60 ||
    //     widget.category.categoryId == 5) {
    //   final List<ClientAppService> catServices = clientAppServices
    //       .where((item) => item.parentCatId == widget.category.categoryId)
    //       .toList();
    //   _newList.addAll(catServices.take(5).toList());
    // } else {
    //   _newList.addAll(clientAppServices.take(5).toList());
    // }

    return Container(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => _goToProfile(shop: clientAppShops[index]),
            child: ClientAppShopItem(shop: clientAppShops[index]),
          );
        },
        itemCount: clientAppShops.length,
      ),
    );
  }

  Widget _buildBookingList() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Hair Cut Booking',
                style: textStyleWithLocale(
                  context: context,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                tr('client_app_search_result'),
                style: textStyleWithLocale(
                  context: context,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItemList() {
    return Container(
      color: Colors.white,
      height: _height,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: false,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final profile = clientAppShops
              .firstWhere((shop) => shop.shopId == _newList[index].shopId);

          return ClientAppServiceItem(
            clientAppService: _newList[index],
            shop: profile,
            callback: () => _goToProfile(shop: profile),
          );
        },
        // itemCount: clientAppServices.length,
        itemCount: _newList.length,
      ),
    );
  }
}
