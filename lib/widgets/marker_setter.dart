import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerSetter extends StatefulWidget {
  @override
  _MarkerSetterState createState() => _MarkerSetterState();
}

class _MarkerSetterState extends State<MarkerSetter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 320,
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
                  target: LatLng(37.43296265331129, -122.08832357078792),
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414),
            )));
  }
}
