import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/widgets.dart';

class PhotoDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments;
    var photoDetails = _getArguments(routeArgs);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42,
        backgroundColor: Colors.white24,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PhotoContainer(
              path: photoDetails[0],
              marginRight: 9,
              marginTop: 0.0,
              height: MediaQuery.of(context).size.height / 2.2,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                height: MediaQuery.of(context).size.height / 2.2 - 16,
                width: 393,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  markers: {
                    Marker(
                        markerId: MarkerId(photoDetails[0]),
                        position: LatLng(photoDetails[1], photoDetails[2]))
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(photoDetails[1], photoDetails[2]),
                      zoom: 15),
                ))
          ],
        ),
      ),
    );
  }

  List _getArguments(dynamic details) {
    var uploadedPhotoDetails = details.toString().split(",");
    var path =
        uploadedPhotoDetails[0].replaceFirst("{", "").split("path: ")[1].trim();
    var longitude =
        double.parse(uploadedPhotoDetails[1].split("longitude: ")[1].trim());
    var latitude = double.parse(uploadedPhotoDetails[2]
        .replaceAll("}", "")
        .split("latitude: ")[1]
        .trim());
    return [path, latitude, longitude];
  }
}
