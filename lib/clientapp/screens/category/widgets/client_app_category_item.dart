import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/screens/category/widgets/client_app_service_type_dialog_no_title.dart';
import 'package:haircut_delivery/clientapp/screens/service_list/client_app_service_list_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/buttons/custom_round_button.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';

class ClientAppCategoryListItem extends StatelessWidget {
  final ClientAppServiceCategory category;

  const ClientAppCategoryListItem({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

  void _showDialog({@required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClientAppServiceTypeDialogNoTitle(
          content: _buildDialogContent(context: context),
          actions: _buildActions(context: context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return GestureDetector(
      onTap: () => _showDialog(context: context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: Offset(
                0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${languageCode == 'en' ? category.categoryNameEN : category.categoryNameTH}',
              style: textStyleWithLocale(
                context: context,
                fontSize: 18,
                color: Color(0xff707070),
              ),
            ),
            Image.asset('assets/clientapp/images/ic_right.png')
          ],
        ),
      ),
    );
  }

  Widget _buildDialogContent({@required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('assets/clientapp/images/ic_haircut_man.png'),
        SizedBox(height: 15),
        Text(
          AppLocalizations.of(context).tr('client_app_select_service_type'),
          style: textStyleWithLocale(
            context: context,
            color: Color(0xff6F6F6F),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions({@required BuildContext context}) {
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
              text: '${AppLocalizations.of(context).tr('client_app_booking')}',
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
              text: '${AppLocalizations.of(context).tr('client_app_delivery')}',
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

enum ServiceType { BOOKING, DELIVERY }
