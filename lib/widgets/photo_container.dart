import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  PhotoContainer({
    required this.path,
  });

  final String path;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/photo_detail',
          );
        },
        child: Container(
          height: 262,
          width: 393,
          child: Card(
            color: Colors.grey[400],
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(
              // ignore: unnecessary_null_comparison
              child: path != null ? Image.network(path) : Icon(Icons.photo),
            ),
            margin: EdgeInsets.fromLTRB(9, 9, 9, 0),
          ),
        ));
  }
}
