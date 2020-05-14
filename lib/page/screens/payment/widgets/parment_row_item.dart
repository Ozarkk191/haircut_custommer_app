import 'package:flutter/material.dart';
import 'package:haircut_delivery/page/base_components/seperate_lines/horizontal_line.dart';

class PaymentRowItem extends StatefulWidget {
  final Widget icon;
  final Widget title;
  final bool isSelected;

  const PaymentRowItem({
    Key key,
    @required this.icon,
    @required this.title,
    this.isSelected = false,
  })  : assert(icon != null),
        assert(title != null),
        super(key: key);

  @override
  _PaymentRowItemState createState() => _PaymentRowItemState();
}

class _PaymentRowItemState extends State<PaymentRowItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              widget.icon,
              SizedBox(width: 5),
              Expanded(
                child: widget.title,
              ),
              widget.isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Container(width: 0, height: 0),
            ],
          ),
          SizedBox(height: 10),
          HorizontalLine(),
        ],
      ),
    );
  }
}
