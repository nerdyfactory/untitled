import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  PhotoContainer(
      {required this.path, required this.marginTop, required this.height});

  final String path;
  final double marginTop;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      height: this.height,
      width: 393,
      child: path != null
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(path, fit: BoxFit.cover))
          : Icon(Icons.photo),
      margin: EdgeInsets.fromLTRB(9, marginTop, 9, 0),
    );
  }
}
