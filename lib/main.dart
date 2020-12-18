import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moving_forward/change_language.dart';
import 'package:moving_forward/layout.dart';
import 'package:moving_forward/services/localization.dart';
import 'package:moving_forward/location.dart';
import 'package:flutter_matomo/flutter_matomo.dart';
import 'package:moving_forward/state/settings.dart';
import 'package:moving_forward/theme.dart';
import 'package:provider/provider.dart';
import 'state/favorites.dart';

const URL = 'https://matomo.kaleidos.net/piwik.php';
const SITE_ID = 20;

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FavoritesState()),
      ChangeNotifierProvider(create: (context) => SettingsState()),
    ],
    child: MyApp(),
  ));
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
          Locale('en', 'US'), // Inglés
          Locale('es', 'ES'), // Español
          Locale('ar', 'AR'), // Árabe
          Locale('fr', 'FR'), // Francés
        ],
        title: 'Persons Moving Forward',
        theme: ThemeData(
          primaryColor: MfColors.primary,
          textTheme: GoogleFonts.madaTextTheme(
            Theme.of(context).textTheme,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: MfColors.primary)
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
