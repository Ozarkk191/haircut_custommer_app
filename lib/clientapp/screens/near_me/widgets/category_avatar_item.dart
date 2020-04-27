import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class CategoryAvatarItem extends StatelessWidget {
  final ClientAppServiceCategory category;

  const CategoryAvatarItem({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      margin: EdgeInsets.only(right: 7, left: 7),
      width: 90,
      child: Column(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/clientapp/mockup/categories/${category.imageUrl}'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(45.0)),
              border: Border.all(color: Color(0xff929292), width: 3),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2.0,
                  offset: Offset(
                    0, // horizontal, move right 10
                    2.0, // vertical, move down 10
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${languageCode == 'en' ? category.categoryNameEN : category.categoryNameTH}',
            style: textStyleWithLocale(
              context: context,
              height: 1,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
