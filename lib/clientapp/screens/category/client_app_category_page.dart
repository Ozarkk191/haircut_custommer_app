import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/all_constants.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/clientapp/ui/client_app_drawer.dart';
import 'package:haircut_delivery/clientapp/ui/tool_bar.dart';
import 'package:haircut_delivery/util/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientAppCategoryPage extends StatelessWidget {
  final ClientAppServiceCategory category;

  // Global key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ClientAppCategoryPage({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

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
                  Text(
                    tr('client_app_the_best'),
                    style: textStyleWithLocale(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildServiceListview(),
                ],
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppDefaultAppBar(
                context: context,
                scaffoldKey: _scaffoldKey,
                isBack: true,
                isShowCart: false,
                isShowMenu: true,
                onPressedBackBtn: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceListview() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ClientAppCategoryListItem(category: category.children[index]);
        },
        itemCount: category.children.length,
      ),
    );
  }
}
