import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/models/Photo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;
import 'package:untitled/utils/PhotoQuery.dart';

class PhotoUploader {
  Photo photo;
  String? downloadUrl;
  PhotoUploader(this.photo);
  bool uploading = false;
  final databaseReference = Firestore.FirebaseFirestore.instance;
  Future<bool> create() async {
    await databaseReference.collection("photos").add({
      'location': {
        'latitude': photo.location.latitude,
        'longitude': photo.location.longitude
      },
      'uid': photo.uid,
      'downloadUrl': downloadUrl
    }).whenComplete(() {
      uploading = true;
    }).catchError((onError) {
      print("Error");
    });
    PhotoQuery query = PhotoQuery(
        LatLng(32.323232323, 77.00000000), LatLng(34.000000, 78.0000000));
    print(await query.getPhotos());
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
      print("Download Link is $downloadUrl");
      return await create();
    } catch (e) {
      print(e);
      return uploading;
    }
  }
}
