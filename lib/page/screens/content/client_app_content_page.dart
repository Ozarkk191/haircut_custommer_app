import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/page/base_components/drawer/client_app_drawer.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/util/ui_util.dart';

class ClientAppContentPage extends StatelessWidget {
  final String appbarTitle;
  final Image image;
  final contentTitle;
  final String content;

  // Global key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ClientAppContentPage({
    Key key,
    @required this.appbarTitle,
    this.image,
    this.content,
    this.contentTitle,
  })  : assert(appbarTitle != null),
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
                  image != null ? image : _blankContainer(),
                  SizedBox(height: 10),
                  contentTitle != null
                      ? Text(
                          '$contentTitle',
                          style: textStyleWithLocale(
                            context: context,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        )
                      : _blankContainer(),
                  SizedBox(height: 15),
                  content != null
                      ? Text(
                          '$content',
                          style: textStyleWithLocale(
                            context: context,
                            color: Color(0xff707070),
                            fontSize: 16,
                          ),
                        )
                      : _blankContainer(),
                ],
              ),
            ),
            Container(
              height: marketPlaceToolbarHeight,
              child: ClientAppDefaultAppBar(
                  title: Text(
                    '$appbarTitle',
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
                  onPressedBackBtn: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blankContainer() {
    return Container(height: 0, width: 0);
  }
}
