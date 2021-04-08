import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/routes.dart';
import 'package:untitled/widgets.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late GeoFlutterFire geo = GeoFlutterFire();
  late Stream<List<DocumentSnapshot>> stream;
  LatLng userLocation = LatLng(33.604392, 73.1162735);

  @override
  initState() {
    super.initState();
    _getLocation();
  }

  _getFirestoreStream() {
    GeoFirePoint center = geo.point(
        latitude: userLocation.latitude, longitude: userLocation.longitude);
    var collectionReference =
        FirebaseFirestore.instance.collection('positions');
    stream = geo.collection(collectionRef: collectionReference).within(
        center: center, radius: 500, field: 'location', strictMode: true);
    return stream.asBroadcastStream();
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    userLocation = LatLng(position.latitude, position.longitude);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: _getFirestoreStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          print(snapshot);
          if (!snapshot.hasData)
            return new Stack(
              children: [
                Center(
                    child: Container(
                  width: 200,
                  height: 200,
                  child: Text(
                    "Loading Photos ....",
                    textAlign: TextAlign.center,
                  ),
                )),
                AddLocationIcon()
              ],
            );
          if (snapshot.data!.length == 0)
            return new Stack(
              children: [
                Center(
                    child: Container(
                  width: 200,
                  height: 200,
                  child: Text(
                    "No Photo yet please Add one",
                    textAlign: TextAlign.center,
                  ),
                )),
                AddLocationIcon()
              ],
            );
          return new Stack(children: [
            ListView(
              children: snapshot.data!.map((document) {
                return new GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.photo_detail,
                          arguments: {
                            'path': document.data()!["downloadUrl"],
                            'longitude': document
                                .data()!['location']['geopoint']
                                .longitude,
                            'latitude': document
                                .data()!['location']['geopoint']
                                .latitude
                          });
                    },
                    child: PhotoContainer(
                      path: document.data()!["downloadUrl"],
                      marginTop: 9,
                      marginRight: 9,
                      height: 262,
                    ));
              }).toList(),
            ),
            AddLocationIcon()
          ]);
        },
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
