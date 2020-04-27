import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/screens/home/clientapp_home_screen.dart';

/// Splash screen showing the app's logo for a moment.
/// Also checks login status of the user to navigate to the next screen properly.
class ClientAppSplashScreen extends StatefulWidget {
  ClientAppSplashScreen({Key key}) : super(key: key);

  @override
  _ClientAppSplashScreenState createState() => _ClientAppSplashScreenState();
}

class _ClientAppSplashScreenState extends State<ClientAppSplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then check login status of the user.
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => ClientAppHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Image(
          image: AssetImage("assets/images/logo_white.png"),
        ),
      ),
    );
  }
}
