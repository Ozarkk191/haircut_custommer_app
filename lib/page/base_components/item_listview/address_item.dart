import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/address_model.dart';
import 'package:haircut_delivery/page/base_components/transitions/slide_up_transition.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';
import '../../screens/address/client_app_add_address_page.dart';

class AddressItem extends StatelessWidget {
  final String addressTitle;
  final String address;

  const AddressItem({
    Key key,
    @required this.addressTitle,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            Image.asset('assets/images/ic_home_2.png'),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$addressTitle',
                      style: textStyleWithLocale(
                        context: context,
                      ),
                    ),
                    Text(
                      '$address',
                      style: textStyleWithLocale(
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                SlideUpTransition(
                  child: ClientAppAddAddressPage(
                    typeAddress: AddressType.HOME.toString(),
                  ),
                ),
              ),
              child: Image.asset('assets/images/ic_edit.png'),
            ),
          ],
        ),
      ),
    );
  }
}
