import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContainer extends StatefulWidget {
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          height: MediaQuery.of(context).size.width * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Card(
            color: Colors.grey[400],
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(37.43296265331129, -122.08832357078792),
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414),
            ),
          ),
        ));
  }
}
