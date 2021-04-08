import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/utils/PhotoQuery.dart';
import 'package:untitled/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late LatLng _initialPosition = LatLng(33.6043888, 73.11627440000002);
  Set<Marker> _markers = Set();
  List<PhotoData> _photos = [];
  List<GlobalKey> _markerIconKeys = [];
  Set<String> renderedMarkers = Set();
  LatLng cameraPositionForFetchingRecords =
      LatLng(33.6043888, 73.11627440000002);
  @override
  void initState() {
    _getPhotos();
    super.initState();
  }

  Future<void> _getPhotos() async {
    PhotoQuery query = PhotoQuery(
        LatLng(cameraPositionForFetchingRecords.latitude - 5,
            cameraPositionForFetchingRecords.longitude - 5),
        LatLng(cameraPositionForFetchingRecords.latitude + 5,
            cameraPositionForFetchingRecords.longitude + 5));
    _photos = await query.getPhotos();

    _photos.forEach((photo) {
      _markerIconKeys.add(GlobalKey());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (_photos.isNotEmpty) _buildMarkerIconsContainer(),
            GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 15),
              markers: _markers,
              onCameraMove: _onCameraMove,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.76),
            ),
            AddLocationIcon()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
          icon: Icon(Icons.view_stream),
          label: Text("Feed"),
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }

  Widget _buildMarkerIconsContainer() {
    return Column(
      children: _buildMarkerIcons(),
    );
  }

  List<Widget> _buildMarkerIcons() {
    List<Widget> icons = [];
    for (int i = 0; i < _photos.length; i++) {
      icons.add(_buildMarkerIcon(i));
    }
    return icons;
  }

  Widget _buildMarkerIcon(int index) {
    PhotoData photo = _photos[index];
    var image = NetworkImage(photo.url);

    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, call) {
        _addMarker(photo, index);
      }),
    );
    return RepaintBoundary(
      key: _markerIconKeys[index],
      child: Material(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: Image(
          image: image,
          fit: BoxFit.fill,
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  void _addMarker(PhotoData photo, int index) async {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      if (renderedMarkers.contains(photo.url)) return;

      var markerBytes = await _getMarkerIconBytes(_markerIconKeys[index]);
      if (markerBytes == null) return;

      _markers.add(Marker(
          markerId: MarkerId(photo.url),
          position: photo.location,
          onTap: () {
            this._printMasog(photo);
          },
          icon: BitmapDescriptor.fromBytes(markerBytes)));
      renderedMarkers.add(photo.url);
      setState(() {});
    });
  }

  _printMasog(PhotoData photo) {
    List<PhotoData> photosAtSameLocation = [..._photos];
    photosAtSameLocation = photosAtSameLocation
        .where((e) => (e.location.latitude.toStringAsPrecision(4).compareTo(
                    photo.location.latitude
                        .toStringAsPrecision(4)
                        .toString()) ==
                0 &&
            e.location.longitude.toStringAsPrecision(4).compareTo(photo
                    .location.longitude
                    .toStringAsPrecision(4)
                    .toString()) ==
                0 &&
            e.url != photo.url))
        .toList();
    List<dynamic> photoContainers = photosAtSameLocation
        .map((e) => GestureDetector(
            onTap: () {
              _navigateToDetail(e);
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.60,
                child: PhotoContainer(
                  path: e.url,
                  marginRight: 0,
                  marginTop: 5,
                  height: MediaQuery.of(context).size.height * 0.45,
                ))))
        .toList();

    showMaterialModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.only(top: 8),
        controller: ModalScrollController.of(context),
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.20,
            padding: EdgeInsets.only(bottom: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                    onTap: () {
                      _navigateToDetail(photo);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: PhotoContainer(
                          path: photo.url,
                          marginTop: 5,
                          marginRight: 0,
                          height: MediaQuery.of(context).size.width * 0.40,
                        ))),
                ...photoContainers
              ],
            )),
      ),
    );
  }

  _navigateToDetail(dynamic e) {
    Navigator.pushNamed(context, "/photo_detail", arguments: {
      'path': e.url,
      'longitude': e.location.longitude,
      'latitude': e.location.latitude
    });
  }

  Future<Uint8List?> _getMarkerIconBytes(GlobalKey markerKey) async {
    if (markerKey.currentContext == null) return null;

    RenderRepaintBoundary boundary =
        markerKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData byteData = (await image.toByteData(format: ImageByteFormat.png))!;
    return byteData.buffer.asUint8List();
  }

  _onCameraMove(CameraPosition position) {
    bool fetchNewRecords = cameraPositionForFetchingRecords.longitude -
                position.target.longitude <
            -10 ||
        cameraPositionForFetchingRecords.longitude + position.target.longitude >
                10 &&
            cameraPositionForFetchingRecords.latitude -
                    position.target.latitude <
                -10 ||
        cameraPositionForFetchingRecords.latitude + position.target.latitude >
            10;

    if (fetchNewRecords) {
      cameraPositionForFetchingRecords = position.target;
      _getPhotos();
    }
  }
}
