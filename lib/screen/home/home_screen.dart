import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/ui/curved_navigation_bar/curved_navigation_bar.dart';
import 'package:haircut_delivery/clientapp/ui/drawer.dart';
import 'package:haircut_delivery/screen/home/account_page.dart';
import 'package:haircut_delivery/screen/home/home_page.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenPage page;

  HomeScreen({this.page = HomeScreenPage.HOME, Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Global key
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    // Set the status bar's color.
    UiUtil.changeStatusColor(const Color.fromARGB(255, 67, 66, 73));

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: PrimaryDrawer(),
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: <Widget>[
              Container(color: Colors.cyan),
              HomePage(scaffoldKey: _scaffoldKey),
              Container(color: Colors.grey),
              AccountPage(),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: const Color(0xFF707070),
          items: <Widget>[
            ImageIcon(AssetImage('assets/images/ic_marker.png')),
            ImageIcon(AssetImage('assets/images/ic_history.png')),
            ImageIcon(AssetImage('assets/images/ic_home.png')),
            ImageIcon(AssetImage('assets/images/ic_notification.png')),
            ImageIcon(AssetImage('assets/images/ic_account.png')),
          ],
          labels: [
            AppLocalizations.of(context).tr('menu_near_me'),
            AppLocalizations.of(context).tr('menu_history'),
            AppLocalizations.of(context).tr('menu_home'),
            AppLocalizations.of(context).tr('menu_notification'),
            AppLocalizations.of(context).tr('menu_account'),
          ],
          index: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
        ),
      ),
    );
  }

  /// Returns page index of [page].
  int _getPageIndex(HomeScreenPage page) {
    switch (page) {
      case HomeScreenPage.NEAR_ME:
        return 0;
      case HomeScreenPage.HISTORY:
        return 1;
      case HomeScreenPage.HOME:
        return 2;
      case HomeScreenPage.NOTIFICATION:
        return 3;
      case HomeScreenPage.ACCOUNT:
        return 4;
      default:
        return 2;
    }
  }
}

/// Enumeration for pages of the Home screen.
enum HomeScreenPage { NEAR_ME, HISTORY, HOME, NOTIFICATION, ACCOUNT }
