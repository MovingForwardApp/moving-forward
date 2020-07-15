import 'package:flutter/material.dart';

import 'layout.dart';

import 'resource.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Persons Moving Forward',
        // home: LayoutPage(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => AppLayout(),
          "/resource": (BuildContext context) => Resource(),
        },
        debugShowCheckedModeBanner: false);
  }
}
