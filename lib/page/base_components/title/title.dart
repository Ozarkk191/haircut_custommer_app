import 'package:flutter/material.dart';

/// Screen title text.
class ScreenTitle extends StatelessWidget {
  final title;

  ScreenTitle({
    this.title = '',
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Section title text.
class SectionTitle extends StatelessWidget {
  final title;

  SectionTitle({
    this.title = '',
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
