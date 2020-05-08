import 'package:flutter/material.dart';

/// Loading screen.
class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0x33000000)),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

/// Loading screen.
class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
