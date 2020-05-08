import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Confirmation dialog.
class ConfirmDialog extends StatelessWidget {
  final String message;
  final Function onConfirmed;

  ConfirmDialog({
    this.message,
    this.onConfirmed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(AppLocalizations.of(context).tr('dialog_confirm')),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
          child: new Text(AppLocalizations.of(context).tr('btn_cancel')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(AppLocalizations.of(context).tr('btn_confirm')),
          onPressed: onConfirmed,
        ),
      ],
    );
  }
}

/// Error dialog.
class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog({
    this.message,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(AppLocalizations.of(context).tr('dialog_error')),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
          child: new Text(AppLocalizations.of(context).tr('btn_close')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

/// Success dialog.
class SuccessDialog extends StatelessWidget {
  final String message;

  SuccessDialog({
    this.message,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(AppLocalizations.of(context).tr('dialog_success')),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
          child: new Text(AppLocalizations.of(context).tr('btn_close')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
