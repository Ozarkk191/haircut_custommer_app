import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:haircut_delivery/repository/user_repository.dart';
import 'package:haircut_delivery/screen/home/home_screen.dart';
import 'package:haircut_delivery/screen/login/login_screen.dart';

/// Splash screen showing the app's logo for a moment.
/// Also checks login status of the user to navigate to the next screen properly.
class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then check login status of the user.
    Timer(Duration(seconds: 2), () {
      _checkLogInStatus();
    });
  }

  /// Checks login status of the user. If the user has logged in, goes to the Home screen,
  /// otherwise the Login screen.
  _checkLogInStatus() async {
    final isGuest = await UserRepository.isGuest();
    if (isGuest) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    }
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
