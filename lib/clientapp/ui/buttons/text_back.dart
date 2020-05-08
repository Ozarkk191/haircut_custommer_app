import 'package:flutter/material.dart';

class TextBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 40, left: 20, bottom: 20),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          '< Back',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
