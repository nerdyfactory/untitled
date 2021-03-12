import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/widgets/map_container.dart';
import 'package:untitled/widgets/marker_setter.dart';
import 'package:untitled/widgets/upload_container.dart';

class PhotoUpload extends StatelessWidget {
  PhotoUpload({this.title = ""});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        foregroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 100.0,
                height: 8.0,
                child: ElevatedButton(
                  child: Text('SUBMIT'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto')),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[UploadContainer(), MarkerSetter()],
        ),
      ),
    );
  }
}
