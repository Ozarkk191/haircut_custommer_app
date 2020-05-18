import 'package:flutter/material.dart';

class SmallRoundButton extends StatelessWidget {
  final String textButton;
  final Function callback;

  const SmallRoundButton({
    Key key,
    @required this.textButton,
    @required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Text(
            '$textButton',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        // ),
      ),
    );
  }
}
