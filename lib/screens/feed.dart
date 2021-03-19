import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets.dart';

class Feed extends StatelessWidget {
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
                    "No data yet please create one",
                    textAlign: TextAlign.center,
                  ),
                )),
                AddLocationIcon()
              ],
            );
          return new Stack(children: [
            ListView(
              children: snapshot.data!.docs.map((document) {
                return new PhotoContainer(
                  path: document.data()!["downloadUrl"],
                );
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
