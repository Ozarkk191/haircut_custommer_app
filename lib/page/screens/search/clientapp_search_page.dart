import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/all_constants.dart';
import 'package:haircut_delivery/datas/service_categories.dart';
import 'package:haircut_delivery/model/client_app_service_category.dart';
import 'package:haircut_delivery/page/base_components/appbar/client_app_default_appbar.dart';
import 'package:haircut_delivery/page/base_components/buttons/custom_round_button.dart';
import 'package:haircut_delivery/page/base_components/seperate_lines/horizontal_line.dart';
import 'package:haircut_delivery/page/base_components/toolbars/tool_bar.dart';
import 'package:haircut_delivery/page/base_components/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_category_item.dart';
import 'package:haircut_delivery/page/screens/category/widgets/client_app_service_type_dialog_no_title.dart';
import 'package:haircut_delivery/page/screens/service_list/client_app_service_list_page.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppSearchPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ClientAppSearchPage({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _ClientAppSearchPageState createState() => _ClientAppSearchPageState();
}

class _ClientAppSearchPageState extends State<ClientAppSearchPage>
    with AutomaticKeepAliveClientMixin<ClientAppSearchPage> {
  @override
  bool get wantKeepAlive => true;

  void _showDialog({
    @required BuildContext context,
    @required ClientAppServiceCategory category,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClientAppServiceTypeDialogNoTitle(
          content: _buildDialogContent(context: context),
          actions: _buildActions(
            context: context,
            category: category,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    EasyLocalization.of(context).delegates;

    super.build(context);
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              left: 15, right: 15, top: TOOL_BAR_HEIGHT + 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tr('client_app_categories'),
                style: textStyleWithLocale(
                  context: context,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              Wrap(
                children: _buildCategoryChips(),
              ),
              SizedBox(height: 15),
              Text(
                tr('client_app_poppularty'),
                style: textStyleWithLocale(
                  context: context,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                ),
              ),
              Container(
                child: ListView.separated(
                  primary: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => _showDialog(
                          context: context, category: serviceCategories[index]),
                      child: ListTile(
                        title: Text(
                          '${languageCode == 'en' ? serviceCategories[index].categoryNameEN : serviceCategories[index].categoryNameTH}',
                          style: textStyleWithLocale(
                            context: context,
                            color: Color(0xff707070),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return HorizontalLine();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        height: marketPlaceToolbarHeight,
        child: ClientAppDefaultAppBar(
          context: context,
          scaffoldKey: widget.scaffoldKey,
        ),
      ),
    ]);
  }

  List<Widget> _buildCategoryChips() {
    String languageCode = Localizations.localeOf(context).languageCode;

    // clientAppShops
    return serviceCategories.map((item) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            SlideUpTransition(
              child: ClientAppServiceListPage(
                category: item,
                serviceType: ServiceType.BOOKING,
              ),
            ),
          ),
          child: Chip(
            label: Text(
              '${languageCode == 'en' ? item.categoryNameEN : item.categoryNameTH}',
              style: textStyleWithLocale(
                context: context,
                // fontWeight: FontWeight.w300,
                color: Color(0xff707070),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDialogContent({@required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/clientapp/images/ic_haircut_man.png'),
        SizedBox(height: 15),
        Text(
          tr('client_app_select_service_type'),
          style: textStyleWithLocale(
            context: context,
            color: Color(0xff6F6F6F),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions({
    @required BuildContext context,
    @required ClientAppServiceCategory category,
  }) {
    List<Widget> _actions = [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _actionBtn(
              context: context,
              callback: () => Navigator.push(
                context,
                SlideUpTransition(
                  child: ClientAppServiceListPage(
                    category: category,
                    serviceType: ServiceType.BOOKING,
                  ),
                ),
              ),
              text: tr('client_app_booking'),
            ),
            _actionBtn(
              context: context,
              callback: () => Navigator.push(
                context,
                SlideUpTransition(
                  child: ClientAppServiceListPage(
                    category: category,
                    serviceType: ServiceType.DELIVERY,
                  ),
                ),
              ),
              text: tr('client_app_delivery'),
            ),
          ],
        ),
      ),
    ];

    return _actions;
  }

  Widget _actionBtn(
      {@required BuildContext context, Function callback, String text}) {
    return CustomRoundButton(
      callback: callback,
      child: Text(
        text,
        style: textStyleWithLocale(
          context: context,
          fontSize: 16,
        ),
      ),
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
