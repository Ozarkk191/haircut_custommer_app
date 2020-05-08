import 'package:flutter/material.dart';

const BUTTON_BORDER_RADIUS = 30.0;
const BUTTON_FONT_SIZE = 16.0;
const DISABLE_COLOR = Color(0xFFCCCCCC);

/// Primary button.
class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final FocusNode focusNode;

  PrimaryButton({
    this.text = 'Button',
    this.onPressed,
    this.focusNode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text, style: TextStyle(fontSize: BUTTON_FONT_SIZE)),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(BUTTON_BORDER_RADIUS)),
      color: Theme.of(context).primaryColor,
      disabledColor: DISABLE_COLOR,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}

/// Blue button.
class BlueButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final FocusNode focusNode;

  BlueButton({
    this.text = 'Button',
    this.onPressed,
    this.focusNode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text, style: TextStyle(fontSize: BUTTON_FONT_SIZE)),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(BUTTON_BORDER_RADIUS)),
      color: const Color(0xFF4167B2),
      disabledColor: DISABLE_COLOR,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}

/// Dark button.
class DarkButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final FocusNode focusNode;

  DarkButton({
    this.text = 'Button',
    this.onPressed,
    this.focusNode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text, style: TextStyle(fontSize: BUTTON_FONT_SIZE)),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(BUTTON_BORDER_RADIUS)),
      color: const Color(0xFF444444),
      disabledColor: DISABLE_COLOR,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}

/// Gray button.
class GrayButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final FocusNode focusNode;

  GrayButton({
    this.text = 'Button',
    this.onPressed,
    this.focusNode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text, style: TextStyle(fontSize: BUTTON_FONT_SIZE)),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(BUTTON_BORDER_RADIUS)),
      color: const Color(0xFFEFEFEF),
      disabledColor: DISABLE_COLOR,
      textColor: Color(0xFF707070),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}
