import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/config/marketplace_colors.dart';

class CustomRoundButton extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double radius;
  final Color color;
  final Alignment alignment;
  final EdgeInsets padding;
  final VoidCallback callback;

  const CustomRoundButton({
    Key key,
    @required this.child,
    this.radius = 25,
    this.color = MarketplaceColors.PRIMARY_COLOR,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(8),
    this.elevation = 0,
    this.callback,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: padding,
      elevation: elevation,
      child: child,
      onPressed: callback,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
