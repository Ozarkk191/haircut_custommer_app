import 'package:flutter/material.dart';

class ClientAppIconBtn extends StatelessWidget {
  final Function callback;
  final double width;
  final double height;
  final double radius;
  final Icon icon;

  const ClientAppIconBtn({
    Key key,
    @required this.callback,
    this.width = 28,
    this.height = 28,
    this.radius = 5,
    this.icon = const Icon(
      Icons.add,
      size: 20,
      color: Colors.green,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0),
        color: Colors.white,
        onPressed: callback,
        child: icon,
      ),
    );
  }
}
