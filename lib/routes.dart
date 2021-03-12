import 'package:flutter/material.dart';
import 'package:untitled/screens.dart';

class Routes {
  Routes._();

  //static variables
  static const String feed = '/feed';
  static const String map = '/map';
  static const String photo_detail = '/photo_detail';
  static const String photo_upload = '/photo_upload';

  static final routes = <String, WidgetBuilder>{
    feed: (BuildContext context) => Feed(),
    map: (BuildContext context) => Map(),
    photo_detail: (BuildContext context) => PhotoDetail(),
    photo_upload: (BuildContext context) => PhotoUpload(),
  };
}
