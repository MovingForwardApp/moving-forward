import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moving_forward/change_language.dart';
import 'package:moving_forward/layout.dart';
import 'package:moving_forward/localization.dart';
import 'package:moving_forward/location.dart';
import 'package:flutter_matomo/flutter_matomo.dart';

const URL = 'https://matomo.kaleidos.net/piwik.php';
const SITE_ID = 20;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await FlutterMatomo.initializeTracker(URL, SITE_ID);
    setState(() {});

    // Future.delayed(Duration(seconds: 10), () async {
    //   await FlutterMatomo.trackDownload();
    //   setState(() {});
    // });

    // Future.delayed(Duration(seconds: 12), () async {
    //   await FlutterMatomo.trackGoal(1);
    //   setState(() {});
    // });

    if (!mounted) return;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AR'), // Árabe
          Locale('en', 'US'), // Inglés
          Locale('es', 'ES'), // Español
          Locale('fr', 'FR'), // Francés
        ],
        title: 'Persons Moving Forward',
        // home: AppLayout(),
        theme: ThemeData(
          textTheme: GoogleFonts.madaTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/lang',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => AppLayout(),
          "/location": (BuildContext context) => LocationPage(),
          "/lang": (BuildContext context) => AppLang(),
        },
        debugShowCheckedModeBanner: false);
  }
}
