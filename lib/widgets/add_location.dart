import 'package:flutter/material.dart';

class AddLocationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      right: 12,
      child: IconButton(
        iconSize: 30,
        icon: const Icon(Icons.add_location_alt),
        onPressed: () {
          Navigator.pushNamed(context, '/photo_upload');
        },
      ),
    );
  }
}
