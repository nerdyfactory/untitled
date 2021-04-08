import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/routes.dart';
import 'package:untitled/widgets.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late LatLng userLocation = LatLng(0.0, 0.0);

  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('photos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          if (snapshot.data!.size == 0)
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
          List photoList = snapshot.data!.docs.map((document) {
            var distance = Geolocator.distanceBetween(
                document.data()!['location'].latitude,
                document.data()!['location'].longitude,
                userLocation.latitude,
                userLocation.longitude);
            var photo = {
              'path': document.data()!["downloadUrl"],
              'longitude': document.data()!['location'].longitude,
              'latitude': document.data()!['location'].latitude,
              'distance': distance
            };
            return photo;
          }).toList();
          photoList.sort((a, b) => a['distance'].compareTo(b['distance']));
          return new Stack(children: [
            ListView(
              children: photoList.map((document) {
                return new GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.photo_detail,
                          arguments: {
                            'path': document['path'],
                            'longitude': document['longitude'],
                            'latitude': document['latitude']
                          });
                    },
                    child: PhotoContainer(
                      path: document['path'],
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

  Future<void> _determinePosition() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      userLocation = LatLng(position.accuracy, position.latitude);
    });
  }
}
