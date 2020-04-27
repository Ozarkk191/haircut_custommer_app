import 'package:flutter/material.dart';

class MarketPlaceHomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  MarketPlaceHomePage({this.scaffoldKey, Key key}) : super(key: key);

  @override
  _MarketPlaceHomePageState createState() => _MarketPlaceHomePageState();
}

class _MarketPlaceHomePageState extends State<MarketPlaceHomePage>
    with AutomaticKeepAliveClientMixin<MarketPlaceHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
          ],
        ),
      ),
    ]);
  }
}
