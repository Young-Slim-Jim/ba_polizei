import 'dart:io';

import 'package:ba_polizei/personHitsProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/ChipProvider.dart';
import 'package:ba_polizei/results_nach_anfrage/screens/MainScreenSelectedResult.dart';
import 'package:ba_polizei/screens/startScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChipProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonHitProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
      routes: <String, WidgetBuilder>{
        '/MainScreenDetails': (context) => MainScreenSelectedResult(),
      },
      theme: ThemeData(
        primaryColor: Platform.isIOS ? Color(0xff00416d) : Color(0xff1d2d50),
        accentColor: Platform.isIOS ? Colors.amber : Colors.white,
        secondaryHeaderColor:
            Platform.isIOS ? Color(0xff43658b) : Color(0xffe8e8e8),
        hoverColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Platform.isIOS ? Color(0xffe8e8e8) : Colors.white,
      ),
      home: StartScreen(),
    );
  }
}
