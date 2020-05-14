import 'package:flutter/material.dart';
import 'package:haircut_delivery/model/client_app_service.dart';
import 'package:haircut_delivery/page/screens/profile/widgets/client_app_icon_btn.dart';
import 'package:haircut_delivery/styles/text_style_with_locale.dart';

class ClientAppServiceRowItem extends StatelessWidget {
  final ClientAppService service;
  final Function callback;

  const ClientAppServiceRowItem(
      {Key key, @required this.service, @required this.callback})
      : assert(service != null),
        assert(callback != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClientAppIconBtn(
                  callback: callback,
                ),
                SizedBox(width: 10),
                Expanded(child: _serviceNameText(context: context)),
              ],
            ),
          ),
          _buildServicePrice(context: context),
        ],
      ),
    );
  }

  Widget _serviceNameText({BuildContext context}) {
    return Text(
      '${service.serviceName}',
      style: textStyleWithLocale(
        context: context,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildServicePrice({@required BuildContext context}) {
    return Row(
      children: <Widget>[
        _buildShowDiscount(context: context),
        SizedBox(width: 10),
        Text(
          '฿${service.price}',
          style: textStyleWithLocale(
              context: context,
              color: Theme.of(context).primaryColor,
              fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildShowDiscount({@required BuildContext context}) {
    String discount = '';

    discount = service.discount > 0 ? '฿' + service.discount.toString() : '';

    return Text(
      '$discount',
      style: textStyleWithLocale(
          context: context, decoration: TextDecoration.lineThrough),
    );
  }
}
