import 'package:flutter/material.dart';

class TextEditLine extends StatelessWidget {
  final Function callback;
  final String title;

  const TextEditLine({
    Key key,
    @required this.callback,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              InkWell(
                onTap: callback,
                child: Image.asset('assets/images/ic_edit.png'),
              )
            ],
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
