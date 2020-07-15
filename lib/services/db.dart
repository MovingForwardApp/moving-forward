import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';


class DBService {
  Future<Database> _db;

  DBService () {
    this._initialize();
  }

  void _initialize() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'asset_database.db');
    _db = openDatabase(databasePath);
  }

  Future<List<Category>> listCategories() async {
    Database db = await _db;

    final List<Map<String, dynamic>> maps = await db.query('categories');

    return maps.map((m) => Category.fromMap(m));
  }

  Future<Category> getCategory(int id) async {
    Database db = await _db;

    final Map<String, dynamic> map = (await db.query('categories',
                                                     where: '"id" = ?',
                                                     whereArgs: [id]))[0];

    return Category.fromMap(map);
  }


  Future<List<Resource>> listResourcesByCategory(int categoryId) async {
    Database db = await _db;

    final List<Map<String, dynamic>> maps = await db.query('resources',
                                                           where: '"category_id" = ?',
                                                           whereArgs: [categoryId]);

    return maps.map((m) => Resource.fromMap(m));
  }

  Future<Resource> getResource(int id) async {
    Database db = await _db;

    final Map<String, dynamic> map = (await db.query('resources',
                                                     where: '"id" = ?',
                                                     whereArgs: [id]))[0];

    return Resource.fromMap(map);
  }

  void close() async {
    Database db = await _db;
    db.close();
  }
}