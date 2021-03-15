import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class PhotoContainer extends StatelessWidget {
  PhotoContainer({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.green[400]);
    return Container(
      height: 262,
      width: 393,
      child: Card(
        color: Colors.grey[400],
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Icon(Icons.photo),
        ),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      ),
    );
  }
}
