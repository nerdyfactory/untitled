import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  Error({this.message = ""});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$message'),
          ],
        ),
      ),
    );
  }
}
