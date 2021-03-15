import 'package:flutter/material.dart';
import 'package:untitled/widgets/map_container.dart';
import 'package:untitled/widgets/photo_container.dart';

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
          children: <Widget>[PhotoContainer(path: "imagePath"), MapContainer()],
        ),
      ),
    );
  }
}
