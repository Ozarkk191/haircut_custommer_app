import 'package:flutter/material.dart';

class BigRoundButton extends StatelessWidget {
  final Function callback;
  final String textButton;
  final Color color;

  const BigRoundButton({
    Key key,
    @required this.callback,
    this.textButton,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 50,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Center(
          child: Text(
            textButton,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
