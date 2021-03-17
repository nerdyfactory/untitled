import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:geolocator/geolocator.dart';

class PhotoUpload extends StatefulWidget {
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? _image;
  final picker = ImagePicker();
  List<Marker> myMarker = [];
  late LatLng initialPosition = LatLng(33.33, 77.77);

  void initState() {
    super.initState();
    _onStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo upload"),
        backgroundColor: Colors.white70,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        foregroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 100.0,
                height: 8.0,
                child: ElevatedButton(
                  child: Text('SUBMIT'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Roboto')),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _image != null
                ? Stack(children: [
                    Container(
                      height: 262,
                      width: 393,
                      child: Image.file(
                        _image!,
                      ),
                    ),
                    Positioned(
                        top: 3,
                        right: 6,
                        child: IconButton(
                          icon: Icon(Icons.highlight_off),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () => {
                            setState(() => {_image = null})
                          },
                        ))
                  ])
                : Container(
                    height: 262,
                    width: 393,
                    child: Card(
                      color: Colors.grey[400],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Center(
                        child: IconButton(
                          iconSize: (MediaQuery.of(context).size.width * 1) / 2,
                          color: Colors.grey[600],
                          icon: Icon(Icons.add),
                          onPressed: () => {_onAlertButtonsPressed(context)},
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    ),
                  ),
            Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: 393,
                child: Card(
                    color: Colors.grey[400],
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition:
                          CameraPosition(target: initialPosition, zoom: 5),
                      markers: Set.from(myMarker),
                      onTap: _handleMapTap,
                    )))
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      title: "Image",
      desc: "Select Image from :",
      buttons: [
        DialogButton(
          child: Text(
            "Camera",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () =>
              {getImage(ImageSource.camera), Navigator.pop(context)},
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Gallery",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () =>
              {getImage(ImageSource.gallery), Navigator.pop(context)},
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }

  _handleMapTap(LatLng tappedPoint) async {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString()), position: tappedPoint));
    });
  }

  _onStart() async {
    Position pos = await _determinePosition();
    setState(() {
      initialPosition = LatLng(pos.latitude, pos.longitude);
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(initialPosition.toString()),
          position: initialPosition));
    });
    print(pos);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
