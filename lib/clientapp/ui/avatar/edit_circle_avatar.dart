import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/models/client_app_user.dart';

class EditCircleAvatar extends StatelessWidget {
  final ClientAppUser user;
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;
  final double radius;

  const EditCircleAvatar({
    Key key,
    @required this.user,
    this.width = 100,
    this.height = 100,
    this.borderColor = Colors.white,
    this.borderWidth = 3,
    this.radius = 100,
  })  : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/clientapp/images/${user.avatarUrl}'),
              ),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
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
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: height / 2,
              ),
              Container(
                width: width,
                height: height / 2,
                color: new Color.fromRGBO(0, 0, 0, 0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_edit.png',
                      color: Colors.white,
                    ),
                    Text(
                      'Edit image',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
