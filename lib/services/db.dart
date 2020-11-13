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
  Future<Category> getCategory(int id, {String lang: 'es'}) async {
    Database db = await instance.database;

    final Map<String, dynamic> map =
        (await db.query('categories', where: '"id" = ?', whereArgs: [id]))[0];

    return Category.fromMap(map).applyLang(lang);
  }

  Future<Resource> getResource(int id, {String lang: 'es'}) async {
    Database db = await instance.database;

    final Map<String, dynamic> map =
        (await db.query('resources', where: '"id" = ?', whereArgs: [id]))[0];

    return Resource.fromMap(map).applyLang(lang);
  }

  Future<List<Category>> listCategories({String lang: 'es'}) async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('categories');

    return maps.map((m) => Category.fromMap(m).applyLang(lang)).toList();
  }

  Future<List<Resource>> listResourcesByCategory(
      int categoryId, double locationLat, double locationLong,
      {String lang: 'es'}) async {
    Database db = await instance.database;
    String query = '';
    List<num> params = [];

    if ((locationLat != null) & (locationLong != null)) {
      query = '''
         SELECT *, 
                (
                  (?2 - resources.lat) * (?2 - resources.lat)) + 
                  ((?3 - resources.long) * (?3 - resources.long)
                ) AS distance
           FROM resources JOIN resource_category ON resources.id = resource_category.resource_id
          WHERE category_id = ?1 
       ORDER BY distance ASC
      ''';
      params = [categoryId, locationLat, locationLong];
    } else {
      query = '''
         SELECT * 
           FROM resources JOIN resource_category ON resources.id = resource_category.resource_id
          WHERE category_id = ?1
      ''';
      params = [categoryId];
    }

    final List<Map<String, dynamic>> maps = await db.rawQuery(query, params);

    return maps.map((m) => Resource.fromMap(m).applyLang(lang)).toList();
  }

  Future<List<Category>> listCategoriesByResource(int resourceId,
      {String lang: 'es'}) async {
    Database db = await instance.database;
    final String query = """
       SELECT *
         FROM categories 
         JOIN resource_category ON categories.id = resource_category.category_id
        WHERE resource_id = ?1
    """;
    final List<int> params = [resourceId];

    final List<Map<String, dynamic>> maps = await db.rawQuery(query, params);

    return maps.map((m) => Category.fromMap(m).applyLang(lang)).toList();
  }

  void close() async {
    Database db = await instance.database;
    db.close();
  }
}
