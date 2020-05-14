import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppSelectedServiceItem extends StatelessWidget {
  final ClientAppService service;

  const ClientAppSelectedServiceItem({Key key, @required this.service})
      : assert(service != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '${service.serviceName}',
            style: textStyleWithLocale(context: context, fontSize: 16),
          ),
        ),
        Row(
          children: <Widget>[
            _showBtn(context: context),
            SizedBox(width: 10),
            _showPrice(context: context),
            SizedBox(width: 10),
            IconButton(
              icon: Image.asset(
                'assets/clientapp/images/ic_trash.png',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _showPrice({@required BuildContext context}) {
    double result = 0;
    if (service.discount > 0) {
      result = service.price - service.discount;
    } else {
      result = service.price;
    }

    return Text(
      '฿$result',
      style: textStyleWithLocale(
        context: context,
        fontSize: 16,
      ),
    );
  }

  Widget _showBtn({@required BuildContext context}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: Color(0xff009900),
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              height: 25,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Icon(Icons.remove, size: 18, color: Colors.white),
              ),
            ),
            SizedBox(width: 10),
            Text(
              '1',
              style: textStyleWithLocale(context: context, color: Colors.white),
            ),
            SizedBox(width: 10),
            Container(
              width: 25,
              height: 25,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Icon(Icons.add, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
