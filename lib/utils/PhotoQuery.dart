import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PhotoData {
  LatLng location;
  String uid;
  String url;
  PhotoData(this.location, this.uid, this.url);
}

class PhotoQuery {
  LatLng southWest;
  LatLng northEast;

  PhotoQuery(this.southWest, this.northEast);

  updateLocation(LatLng sw, LatLng ne) {
    this.southWest = sw;
    this.northEast = ne;
  }

  Future<List<PhotoData>> getPhotos() async {
    List<PhotoData> photos = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('photos')
        .where("location",
            isGreaterThanOrEqualTo:
                GeoPoint(southWest.latitude, southWest.longitude),
            isLessThan: GeoPoint(northEast.latitude, northEast.longitude))
        .get();
    snapshot.docs.forEach((document) {
      GeoPoint geoPoint = document.data()!["location"];
      photos.add(PhotoData(LatLng(geoPoint.latitude, geoPoint.longitude),
          document.data()!["uid"], document.data()!["downloadUrl"]));
    });
    print(photos);
    return photos;
  }
}
