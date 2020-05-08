import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:haircut_delivery/bloc/validate/validate_bloc.dart';

import 'clientapp/screens/splash/splash_screen_page.dart';
// import 'package:haircut_delivery/marketplace/screens/home/marketplace_home_screen.dart';
// import 'package:haircut_delivery/screen/home/home_screen.dart';

void main() => runApp(EasyLocalization(child: MyApp()));

/// Application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizationData = EasyLocalizationProvider.of(context).data;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ValidateBloc(),
        )
      ],
      child: EasyLocalizationProvider(
        data: localizationData,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Haircut Delivery',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            EasylocaLizationDelegate(
              locale: localizationData.locale,
              path: 'assets/strings',
            ),
          ],
          supportedLocales: [
            Locale('th', 'TH'),
            Locale('en', 'US'),
          ],
          locale: localizationData.savedLocale,
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one from the list
            return supportedLocales.first;
          },
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
          // home: ExpansionTileSample(),
          // home: MarketPlaceHomeScreen(),
        ),
      ),
    );

    // return EasyLocalizationProvider(
    //   data: localizationData,
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Haircut Delivery',
    //     localizationsDelegates: [
    //       GlobalMaterialLocalizations.delegate,
    //       GlobalWidgetsLocalizations.delegate,
    //       EasylocaLizationDelegate(
    //         locale: localizationData.locale,
    //         path: 'assets/strings',
    //       ),
    //     ],
    //     supportedLocales: [
    //       Locale('th', 'TH'),
    //       // Locale('en', 'US'),
    //     ],
    //     locale: localizationData.savedLocale,
    //     // Returns a locale which will be used by the app
    //     localeResolutionCallback: (locale, supportedLocales) {
    //       // Check if the current device locale is supported
    //       for (var supportedLocale in supportedLocales) {
    //         if (supportedLocale.languageCode == locale.languageCode &&
    //             supportedLocale.countryCode == locale.countryCode) {
    //           return supportedLocale;
    //         }
    //       }
    //       // If the locale of the device is not supported, use the first one from the list
    //       return supportedLocales.first;
    //     },
    //     theme: ThemeData(
    //       brightness: Brightness.light,
    //       primaryColor: const Color(0xFFDD133B),
    //       accentColor: const Color(0xFFDD133B),
    //       fontFamily: 'Montserrat',
    //       textTheme: TextTheme(
    //         headline: TextStyle(
    //             fontSize: 72,
    //             fontWeight: FontWeight.bold,
    //             color: Color(0xFF444444)),
    //         title: TextStyle(
    //             fontSize: 36,
    //             fontWeight: FontWeight.bold,
    //             color: Color(0xFF444444)),
    //         body1: TextStyle(
    //             fontSize: 15, fontFamily: 'Hind', color: Color(0xFF444444)),
    //       ),
    //     ),
    //     // home: SplashScreen(),
    //     home: LoginScreen(),
    //     // home: ExpansionTileSample(),
    //     // home: MarketPlaceHomeScreen(),
    //   ),
    // );
  }
}
