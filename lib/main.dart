import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'layout.dart';
import 'resource.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  void _initializeDatabaseFile() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "asset_database.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeDatabaseFile();

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
