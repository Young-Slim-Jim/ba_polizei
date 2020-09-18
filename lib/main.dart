import 'dart:io';

import 'package:ba_polizei/startScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('de', 'DE'),
        ],
        theme: ThemeData(
          primaryColor: Platform.isIOS ? Color(0xff00416d) : Color(0xff1d2d50),
          accentColor: Platform.isIOS ? Colors.amber : Colors.white,
          secondaryHeaderColor:
              Platform.isIOS ? Color(0xff43658b) : Color(0xffe8e8e8),
          textSelectionColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Platform.isIOS ? Color(0xffe8e8e8) : Colors.white,
        ),
        home: StartScreen());
  }
}
