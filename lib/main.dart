import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/screens.dart';
import 'package:untitled/routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.purple, // navigation bar color
      statusBarColor: Colors.purple, // status bar color
    ));
    return MaterialApp(
        title: 'Untitled',
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        home: Map());
  }
}
