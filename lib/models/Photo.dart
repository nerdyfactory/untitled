import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Photo {
  LatLng location;
  String uid;
  File image;
  Photo(this.location, this.uid, this.image);
}
