import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  PhotoContainer({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.fromLTRB(9, 9, 9, 0),
      ),
    );
  }
}
