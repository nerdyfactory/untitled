import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:untitled/models/Photo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;

class PhotoUploader {
  Photo photo;
  String? downloadUrl;
  late GeoFlutterFire geo = GeoFlutterFire();
  late Stream<List<DocumentSnapshot>> stream;
  PhotoUploader(this.photo);
  bool uploading = false;
  final databaseReference = Firestore.FirebaseFirestore.instance;
  Future<bool> create() async {
    Firestore.GeoPoint myLocation =
        Firestore.GeoPoint(photo.location.latitude, photo.location.longitude);
    await databaseReference.collection("photos").add({
      'location': myLocation,
      'uid': photo.uid,
      'downloadUrl': downloadUrl
    }).whenComplete(() {
      uploading = true;
    }).catchError((onError) {
      print("Error");
    });
    ////
    // For testing
    GeoFirePoint geoFirePoint = geo.point(
        latitude: photo.location.latitude, longitude: photo.location.longitude);
    await databaseReference.collection("positions").add({
      'location': geoFirePoint.data,
      'uid': photo.uid,
      'downloadUrl': downloadUrl
    }).whenComplete(() {
      uploading = true;
    }).catchError((onError) {
      print("Error");
    });
    /////
    return uploading;
  }

  Future<bool> uploadImageToFirebase(Photo photo) async {
    String fileName = Path.basename(photo.image.path);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('photos')
        .child(fileName);
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(photo.image);
    try {
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return await create();
    } catch (e) {
      print(e);
      return uploading;
    }
  }
}
