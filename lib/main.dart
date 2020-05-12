import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';

import 'clientapp/screens/splash/splash_screen_page.dart';
// import 'package:haircut_delivery/marketplace/screens/home/marketplace_home_screen.dart';
// import 'package:haircut_delivery/screen/home/home_screen.dart';

void main() => runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('th', 'TH'),
      ],
      path: 'assets/strings',
      fallbackLocale: Locale('en', 'US'),
    ));

/// Application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ValidateBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Haircut Delivery',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFFDD133B),
          accentColor: const Color(0xFFDD133B),
          fontFamily: 'Montserrat',
          // textTheme: TextTheme(
          //   headline6: TextStyle(
          //       fontSize: 72,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xFF444444)),
          //   subtitle1: TextStyle(
          //       fontSize: 36,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xFF444444)),
          //   bodyText1: TextStyle(
          //       fontSize: 15, fontFamily: 'Hind', color: Color(0xFF444444)),
          // ),
        ),
        // home: SplashScreen(),
        home: ClientAppSplashScreen(),
        // home: LoginScreen(),
        // home: ExpansionTileSample(),
        // home: MarketPlaceHomeScreen(),
      ),
    );
  }
}
