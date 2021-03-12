import 'package:flutter/material.dart';
import 'package:untitled/widgets/map_container.dart';

class Map extends StatelessWidget {
  Map({this.title = ""});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MapContainer(),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.green;
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/photo_upload');
                },
                child: Text("Upload"),
              ),
            ),
          ],
        ),
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
    );
  }
}
