import 'package:flutter/material.dart';
import 'package:untitled/widgets/photo_container.dart';
import 'package:untitled/widgets/upload_container.dart';

class PhotoUpload extends StatelessWidget {
  PhotoUpload({this.title = ""});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 100.0,
                height: 8.0,
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'roboto')),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[UploadContainer()],
        ),
      ),
    );
  }
}
