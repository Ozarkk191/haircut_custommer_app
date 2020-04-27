import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service_category.dart';
import 'package:haircut_delivery/clientapp/screens/category/client_app_category_page.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';
import 'package:haircut_delivery/clientapp/ui/transitions/slide_up_transition.dart';

class ClientAppCategoryColumn extends StatelessWidget {
  final ClientAppServiceCategory category;

  const ClientAppCategoryColumn({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      return Expanded(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            SlideUpTransition(
              child: ClientAppCategoryPage(
                category: category,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    'assets/clientapp/mockup/categories/${category.imageUrl}',
                    fit: BoxFit.cover,
                  ),
                ),
                _buildCategoryName(context: context),
              ],
            ),
          ),
        ),
      );
    } else {
      return Expanded(child: Container());
    }
  }

  Widget _buildCategoryName({@required BuildContext context}) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Text(
      languageCode == 'en' ? category.categoryNameEN : category.categoryNameTH,
      style: textStyleWithLocale(
        context: context,
        fontSize: 14,
        color: Color(0xff333333),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
