import 'package:ba_polizei/startScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff00416d),
          accentColor: Colors.amber,
          secondaryHeaderColor: Color(0xff43658b),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartScreen());
  }
}
