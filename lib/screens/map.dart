import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/widgets.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 10,
            ),
          ),
          AddLocationIcon()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/feed');
        },
        icon: Icon(Icons.view_stream),
        label: Text("Feed"),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    ));
  }
}
