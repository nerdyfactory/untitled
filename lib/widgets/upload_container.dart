import 'package:flutter/material.dart';

class UploadContainer extends StatefulWidget {
  @override
  _UploadContainerState createState() => _UploadContainerState();
}

class _UploadContainerState extends State<UploadContainer> {
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
          child: Icon(
            Icons.add,
            size: (MediaQuery.of(context).size.width * 1) / 2,
            color: Colors.grey[600],
          ),
        ),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      ),
    );
  }
}
