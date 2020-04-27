import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class ClientAppShopCategoryItem extends StatelessWidget {
  final ClientAppServiceCategory category;

  const ClientAppShopCategoryItem({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/clientapp/mockup/topshops/${category.topShopImageUrl}',
            width: 300,
            fit: BoxFit.cover,
          ),
          Align(
            child: _buildCategoryText(context: context),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryText({BuildContext context}) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      width: 300,
      padding: EdgeInsets.all(5),
      color: Colors.black38,
      child: Text(
          '${languageCode == 'en' ? category.categoryNameEN : category.categoryNameTH}',
          style: textStyleWithLocale(
            context: context,
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }
}
