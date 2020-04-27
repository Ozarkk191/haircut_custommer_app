import 'package:flutter/material.dart';

/// Container with padding.
class ContentContainer extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double horizontalPadding;
  final bool verticalPaddingEnabled;
  final bool horizontalPaddingEnabled;

  ContentContainer(
      {this.child,
      this.verticalPadding = 18,
      this.horizontalPadding = 22,
      this.verticalPaddingEnabled = false,
      this.horizontalPaddingEnabled = true,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPaddingEnabled ? horizontalPadding : 0, vertical: verticalPaddingEnabled ? verticalPadding : 0),
      child: child,
    );
  }
}
