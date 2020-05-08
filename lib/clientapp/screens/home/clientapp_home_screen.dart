import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/screens/account/client_app_account_page.dart';
import 'package:haircut_delivery/clientapp/screens/home/clientapp_home_page.dart';
import 'package:haircut_delivery/clientapp/screens/near_me/client_app_near_me_page.dart';
import 'package:haircut_delivery/clientapp/screens/search/clientapp_search_page.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/curved_navigation_bar/curved_navigation_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';

import 'marketplace_home_page.dart';

class ClientAppHomeScreen extends StatefulWidget {
  final ClientAppHomeScreenPage page;

  ClientAppHomeScreen({this.page = ClientAppHomeScreenPage.HOME, Key key})
      : super(key: key);

  @override
  _ClientAppHomeScreenState createState() => _ClientAppHomeScreenState();
}

class _ClientAppHomeScreenState extends State<ClientAppHomeScreen> {
  // Global key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Const
  final List<Widget> menuIcons = [
    ImageIcon(AssetImage('assets/images/ic_marker.png')),
    ImageIcon(AssetImage('assets/clientapp/images/ic_zoom.png')),
    ImageIcon(AssetImage('assets/marketplace/images/ic_home.png')),
    ImageIcon(AssetImage('assets/clientapp/images/ic_marketplace.png')),
    ImageIcon(AssetImage('assets/marketplace/images/ic_account.png')),
  ];
  final List<String> menuItems = [];

  // Controller
  PageController _pageController;

  // Data
  var _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = _getPageIndex(widget.page);
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleOnTapBottomNav(int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: ClientAppDrawer(bgColor: Theme.of(context).primaryColor),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: <Widget>[
              ClientAppNearMePage(scaffoldKey: _scaffoldKey),
              ClientAppSearchPage(scaffoldKey: _scaffoldKey),
              ClientAppHomePage(scaffoldKey: _scaffoldKey),
              MarketPlaceHomePage(scaffoldKey: _scaffoldKey),
              ClientAppAccountPage(scaffoldKey: _scaffoldKey),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: const Color(0xFF707070),
          items: menuIcons,
          labels: _buildMenuLabels(context),
          index: _currentPage,
          onTap: _handleOnTapBottomNav,
        ),
      ),
    );
  }

  List<String> _buildMenuLabels(BuildContext context) {
    return [
      AppLocalizations.of(context).tr('menu_near_me'),
      AppLocalizations.of(context).tr('client_app_search_menu'),
      AppLocalizations.of(context).tr('marketplace_menu_home'),
      AppLocalizations.of(context).tr('client_app_menu_marketplace'),
      AppLocalizations.of(context).tr('marketplace_menu_account'),
    ];
  }

  /// Returns page index of [page].
  int _getPageIndex(ClientAppHomeScreenPage page) {
    switch (page) {
      case ClientAppHomeScreenPage.NEARME:
        return 0;
      case ClientAppHomeScreenPage.SEARCH:
        return 1;
      case ClientAppHomeScreenPage.HOME:
        return 2;
      case ClientAppHomeScreenPage.MARKETPLACE:
        return 3;
      case ClientAppHomeScreenPage.ACCOUNT:
        return 4;
      default:
        return 2;
    }
  }
}

/// Enumeration for pages of the Home screen.
enum ClientAppHomeScreenPage { NEARME, SEARCH, HOME, MARKETPLACE, ACCOUNT }
