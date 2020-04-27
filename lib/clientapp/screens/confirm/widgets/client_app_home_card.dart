import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/datas/client_app_addresses.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

class ClientAppHomeCart extends StatelessWidget {
  const ClientAppHomeCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(right: 10),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/clientapp/images/map.png',
                fit: BoxFit.cover,
              ),
              width: 150,
              height: 120,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipOval(
                              child: Container(
                                color: Colors.green,
                                width: 10,
                                height: 10,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                '${clientAppAddresses[0].addressTitle}',
                                style: textStyleWithLocale(
                                  context: context,
                                  color: Color(0xff707070),
                                  fontSize: 18,
                                  height: 1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset('assets/images/ic_marker_2.png'),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                '${clientAppAddresses[0].address}',
                                style: textStyleWithLocale(
                                  context: context,
                                  color: Color(0xff707070),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/ic_calendar.png',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
