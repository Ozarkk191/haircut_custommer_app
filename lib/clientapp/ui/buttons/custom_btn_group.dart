import 'package:flutter/material.dart';

class CustomBtnGroup extends StatelessWidget {
  final List<Widget> widgets;

  const CustomBtnGroup({Key key, @required this.widgets})
      : assert(widgets.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: 45,
        color: Color(0xffF9CCD0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widgets,
        ),
      ),
    );
  }
}
