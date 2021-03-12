import 'package:flutter/material.dart';

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
          color: Colors.green,
          child: Card(
            color: Colors.grey[400],
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.all(10),
          ),
        ));
  }
}
