import 'package:flutter/material.dart';
import 'package:haircut_delivery/clientapp/styles/text_style_with_locale.dart';

/// Confirmation dialog.
class ClientAppCalendarDialog extends StatelessWidget {
  final Widget content;
  final Widget image;
  final List<Widget> actions;
  final Widget title;

  ClientAppCalendarDialog({
    this.content,
    this.actions,
    Key key,
    this.image,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        title: title,
        titlePadding: EdgeInsets.all(0),
        titleTextStyle: textStyleWithLocale(
          context: context,
          color: Colors.black,
          fontSize: 18,
        ),
        content: content,
        actions: actions,
      ),
    );
  }
}
