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
    print(southWest);
    print(northEast);

    /* This didn't work in even after creating composite indexed it seems like it is issue in the package
    https://github1s.com/FirebaseExtended/flutterfire/blob/HEAD/packages/cloud_firestore/cloud_firestore/lib/src/query.dart?q=is:issue+is:open+inequality
     */
    // QuerySnapshot snapshot = await FirebaseFirestore.instance
    //     .collection('photos')
    //     .where("location.latitude",
    //         isGreaterThanOrEqualTo: southWest.latitude,
    //         isLessThan: northEast.latitude)
    //     .where("location.longitude",
    //         isGreaterThanOrEqualTo: southWest.longitude,
    //         isLessThan: northEast.longitude)
    //     .orderBy("location.latitude", descending: false)
    //     .orderBy("location.longitude", descending: false)
    //     .get();

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('photos')
        .where("location.latitude",
            isGreaterThanOrEqualTo: southWest.latitude,
            isLessThan: northEast.latitude)
        .get();
    snapshot.docs.forEach((document) {
      photos.add(PhotoData(
          LatLng(document.data()!["location"]["longitude"],
              document.data()!["location"]["latitude"]),
          document.data()!["uid"],
          document.data()!["downloadUrl"]));
    });
    print(photos);
    return photos;
  }
}
