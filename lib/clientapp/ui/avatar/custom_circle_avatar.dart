import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_user.dart';

class CustomCircleAvatar extends StatelessWidget {
  final ClientAppUser user;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final double radius;

  const CustomCircleAvatar({
    Key key,
    @required this.user,
    this.width = 90,
    this.height = 90,
    this.borderColor = Colors.white,
    this.borderWidth = 3,
    this.radius = 100,
  })  : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/clientapp/images/${user.avatarUrl}'),
        ),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(
              0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          ),
        ],
      ),
    );
  }
}
