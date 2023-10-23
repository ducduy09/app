// ignore_for_file: file_names

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// import 'dart:io' as io;

class ViewTransactionHelper {
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'MkbTech.db');
    return openDatabase(path, version: 1);
  }

  static getData() async {
    final db = await _openDatabase();
    var query = await db.rawQuery("SELECT * FROM checkLists");
    return query;
  }

  static searchPartByName(String checker) async {
    var dbClient = await _openDatabase();
    var query = await dbClient.rawQuery(
        "SELECT * FROM checkLists "
        "WHERE checker like ?",
        ['%$checker%']);
    return query;
  }
}
