import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/widgets/photo_container.dart';

class PhotoDetail extends StatelessWidget {
  PhotoDetail({this.title = ""});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(this.title),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PhotoContainer(path: "imagePath"),
            Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: 393,
                child: Card(
                    color: Colors.grey[400],
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                          bearing: 192.8334901395799,
                          target:
                              LatLng(37.43296265331129, -122.08832357078792),
                          zoom: 4),
                    )))
          ],
        ),
      ),
    );
  }
}
