import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  PhotoContainer({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(0.0),
      // margin: EdgeInsets.all(0.0),
      height: MediaQuery.of(context).size.width * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        color: Colors.grey[400],
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Icon(Icons.photo),
        ),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      ),
    );
  }
}
