import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:haircut_delivery/config/dimensions.dart';
import 'package:haircut_delivery/model/service.dart';
import 'package:haircut_delivery/ui/title.dart';
import 'package:haircut_delivery/ui/tool_bar.dart';

class ServiceListScreen extends StatelessWidget {
  final Service service;

  ServiceListScreen({this.service, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PrimaryToolBar(),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(left: Dimensions.PAGE_MARGIN_HORIZONTAL, right: Dimensions.PAGE_MARGIN_HORIZONTAL),
                  itemCount: (service.children != null ? service.children.length : 0) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SectionTitle(title: AppLocalizations.of(context).tr('service_list_categories'));
                    }
                    var item = service.children[index - 1];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(item.name),
                            ),
                            Image.asset('assets/images/ic_arrowhead_right.png'),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
