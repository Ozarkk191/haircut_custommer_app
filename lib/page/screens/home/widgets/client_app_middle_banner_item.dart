import 'package:flutter/material.dart';

class ClientAppMiddleBannerItem extends StatelessWidget {
  final String banner;

  const ClientAppMiddleBannerItem({Key key, @required this.banner})
      : assert(banner != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          child: Image.asset(
            'assets/clientapp/mockup/banners/$banner',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
