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
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          height: 262,
          width: 393,
          child: Card(
            color: Colors.grey[400],
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: path != null
                ? Image.network(
                    path,
                    fit: BoxFit.fill,
                  )
                : Icon(Icons.photo),
            margin: EdgeInsets.fromLTRB(9, 9, 9, 0),
          ),
        ));
  }
}
