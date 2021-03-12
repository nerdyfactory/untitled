import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  PhotoDetail({this.title = ""});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Card $title'),
          ],
        ),
      ),
    );
  }
}
