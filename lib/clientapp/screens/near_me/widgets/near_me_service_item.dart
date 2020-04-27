import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_shops.dart';
import 'package:haircut_delivery/clientapp/models/client_app_service.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class NearMeServiceItem extends StatelessWidget {
  final ClientAppService service;
  final int rnd;

  const NearMeServiceItem({Key key, @required this.service, this.rnd = 1})
      : assert(service != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final shop =
        clientAppShops.firstWhere((shop) => shop.shopId == service.shopId);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 85,
                child: Image.asset(
                  'assets/clientapp/mockup/shops/${shop.avatarUrl}',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Text(
                      '${service.serviceName}',
                      style: textStyleWithLocale(
                        context: context,
                        fontSize: 17,
                        height: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('$rnd km'),
                    Text(
                      '${AppLocalizations.of(context).tr('client_app_review_counting')} ${shop.counting}',
                      style: textStyleWithLocale(context: context),
                    ),
                    RatingBar(
                      initialRating: shop.rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0),
                      itemSize: 17.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
