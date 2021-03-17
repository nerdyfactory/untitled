import 'package:untitled/models/Photo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart' as Firestore;

class PhotoUploader {
  Photo photo;
  String? downloadUrl;
  PhotoUploader(this.photo);
  final databaseReference = Firestore.FirebaseFirestore.instance;
  Future create() async {
    await databaseReference
        .collection("photos")
        .doc(photo.uid)
        .set({'location': downloadUrl, 'uid': photo.uid})
        .whenComplete(() => print("+++++++++++ completed +++++++++++"))
        .onError((error, stackTrace) => print("Errrrrrrrrrrrrrrrrrrrror"));
  }

  Future uploadImageToFirebase(Photo photo) async {
    String fileName = Path.basename(photo.location.path);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('photos')
        .child('$fileName');
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(photo.location);
    try {
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print("Download Link is $downloadUrl");

      await create();
    } catch (e) {
      print("Erro while uploading file please try again");
    }
  }
}
