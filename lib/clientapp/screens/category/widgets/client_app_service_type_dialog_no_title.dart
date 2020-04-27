import 'package:flutter/material.dart';

/// Confirmation dialog.
class ClientAppServiceTypeDialogNoTitle extends StatelessWidget {
  final Widget content;
  final Widget image;
  final List<Widget> actions;

  ClientAppServiceTypeDialogNoTitle({
    this.content,
    this.actions,
    Key key,
    this.image,
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
        content: content,
        actions: actions,
      ),
    );
  }
}
