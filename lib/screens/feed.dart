import 'package:flutter/material.dart';
import 'package:untitled/widgets.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          ListView(
            children: <Widget>[
              PhotoContainer(path: "Image 1"),
              PhotoContainer(path: "Image 2"),
              PhotoContainer(path: "Image 3")
            ],
          ),
          AddLocationIcon()
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/map');
        },
        icon: Icon(Icons.location_on),
        label: Text("Map"),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    ));
  }
}
