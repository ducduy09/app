// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class LoginHelper {
  static const String _tableName = "userLogin";
  static int check = 0;
  static int status = 1;

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS userLogin(userId INTEGER PRIMARY KEY AUTOINCREMENT,userName TEXT,email TEXT,password TEXT, type Text, level integer, status integer)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, avatar TEXT, name TEXT, age INTEGER, address TEXT)');
  }

  static Future<int> insertUser(
      String userName, String email, String password, String type,
      {int? level}) async {
    final db = await _openDatabase();
    final data = {
      'userName': userName,
      'email': email,
      'password': password,
      'type': type,
      'status': 1,
      'level': level ?? 0
    };
    return await db.insert('userLogin', data);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await _openDatabase();
    return await db.query('userLogin');
  }

  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'MkbTech.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static checkLogin(String email, String password, String type) async {
    var dbClient = await _openDatabase();
    var res = await dbClient.rawQuery(
        "SELECT * FROM $_tableName WHERE email = ? and password = ? and type = ? and status = 1",
        [email, password, type]);
    check = res.length;
    if (check == 0) {
      var sql = await dbClient.rawQuery(
          "SELECT * FROM $_tableName WHERE email = ? and password = ? and type = ?",
          [email, password, type]);
      if (sql.length == 1) {
        status = 0;
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getDataByEmail(String email) async {
    var dbClient = await _openDatabase();
    var query = await dbClient
        .rawQuery("SELECT * FROM $_tableName WHERE email = ?", [email]);
    return query;
  }

  static Future<List<Map<String, dynamic>>> getDataByType(String type) async {
    var dbClient = await _openDatabase();
    var query = await dbClient
        .rawQuery("SELECT * FROM $_tableName WHERE type = ?", [type]);
    return query;
  }

  static Future<void> deleteUser(var a, int b) async {
    Database db = await _openDatabase();
    if (b == 1) {
      int userId = a;
      await db.rawDelete("DELETE FROM $_tableName WHERE userId = ?", [userId]);
    }
    if (b == 2) {
      String email = a;
      await db.rawDelete("DELETE FROM $_tableName WHERE email = ?", [email]);
    } else {
      db.query('userLogin');
    }
  }

  static Future<void> updateAllById(
      int userId, String name, String password, String email) async {
    Database db = await _openDatabase();
    db.rawUpdate(
        "UPDATE $_tableName SET userName = ?, password = ?, email = ? WHERE userId = ?",
        [name, password, email, '$userId']);
  }

  static getId() async {
    var dbClient = await _openDatabase();
    var query = await dbClient.rawQuery(
        "SELECT * FROM $_tableName ORDER BY userId LIMIT 1 ");
    return query;
  }

  static Future<void> changePass(String email, String password) async {
    Database db = await _openDatabase();
    db.rawUpdate("UPDATE $_tableName SET password = ? WHERE email = ?",
        [password, email]);
  }

  static Future<void> upLevel(int id, int levelOld) async {
    Database db = await _openDatabase();
    db.rawUpdate("UPDATE $_tableName SET level = ? WHERE userId = ?", [
      {levelOld + 1},
      '$id'
    ]);
  }

  static Future<void> downLevel(int id, int levelOld) async {
    Database db = await _openDatabase();
    db.rawUpdate("UPDATE $_tableName SET level = ? WHERE userId = ?", [
      {levelOld - 1},
      '$id'
    ]);
  }

  static Future<void> changeName(String userId, String name) async {
    Database db = await _openDatabase();
    db.rawUpdate(
        "UPDATE $_tableName SET userName = ? WHERE userId = ?", [name, userId]);
  }

  static Future<void> bannedAccount(int userId) async {
    Database db = await _openDatabase();
    db.rawUpdate(
        "UPDATE $_tableName SET status = 0 WHERE userId = ?", ['$userId']);
  }

  static Future<void> unBlockAccount(int userId) async {
    Database db = await _openDatabase();
    db.rawUpdate(
        "UPDATE $_tableName SET status = 1 WHERE userId = ?", ['$userId']);
  }
}
