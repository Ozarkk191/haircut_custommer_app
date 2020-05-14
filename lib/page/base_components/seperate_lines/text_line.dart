import 'package:flutter/material.dart';

class TextLine extends StatelessWidget {
  final String title;

  const TextLine({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(title),
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
