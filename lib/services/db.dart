import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';


class DBService {
  // make this a singleton class
  DBService._privateConstructor();
  static final DBService instance = DBService._privateConstructor();

  // create database instance
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "asset_database.db");

    // Delete if file exist (to update content allways)
    if (FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound) {
      await new File(path).delete();
    }

    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'database.db'));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);

    // Open database
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'asset_database.db');
    return await openDatabase(databasePath);
  }

  // queries
  Future<List<Category>> listCategories() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('categories');

    return maps.map((m) => Category.fromMap(m))
               .toList();
  }

  Future<Category> getCategory(int id) async {
    Database db = await instance.database;

    final Map<String, dynamic> map = (await db.query('categories',
                                                     where: '"id" = ?',
                                                     whereArgs: [id]))[0];

    return Category.fromMap(map);
  }


  Future<List<Resource>> listResourcesByCategory(int categoryId) async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('resources',
                                                           where: '"category_id" = ?',
                                                           whereArgs: [categoryId]);

    return maps.map((m) => Resource.fromMap(m))
               .toList();
  }

  Future<Resource> getResource(int id) async {
    Database db = await instance.database;

    final Map<String, dynamic> map = (await db.query('resources',
                                                     where: '"id" = ?',
                                                     whereArgs: [id]))[0];

    return Resource.fromMap(map);
  }

  void close() async {
    Database db = await instance.database;
    db.close();
  }
}