import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:moving_forward/models/category.dart';
import 'package:moving_forward/models/resource.dart';


class DBService {
  Future<Database> _db;

  DBService () {
    this._initialize();
  }

  void _initialize () async {
    _db = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
    );
  }

  Future<List<Category>> listCategories () async {
    Database db = await _db;

    final List<Map<String, dynamic>> maps = await db.query('categories');

    return maps.map((m) => Category.fromMap(m));
  }
}