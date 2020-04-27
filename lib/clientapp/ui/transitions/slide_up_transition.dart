import 'package:flutter/material.dart';

class SlideUpTransition extends PageRouteBuilder {
  Widget child;
  Duration duration;

  SlideUpTransition(
      {@required this.child, this.duration = const Duration(milliseconds: 250)})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: Semantics(
                scopesRoute: true,
                explicitChildNodes: true,
                child: child,
              ),
            );
          },
          transitionDuration: duration,
        );
}
