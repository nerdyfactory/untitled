import 'package:flutter/material.dart';
import 'package:untitled/screens.dart';
import 'package:untitled/routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Untitled',
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        home: Map());
  }
}
