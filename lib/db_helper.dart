import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await createDatabase();
      return _db!;
    }
  }

  static Future<Database?> createDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, "EduGaon.pvt");
      print("successfully database");
      return await openDatabase(path, version: 1, onCreate: _createTable);
    } catch (e) {
      print("database error:$e");
      return null;
    }
  }

  static Future<void> _createTable(Database db, int version) async {
    try {
      await db.execute(
        "CREATE TABLE Student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,contact TEXT,description TEXT)",
      );
      print("create table successfully");
    } catch (e) {
      print("create table error:$e");
    }
  }

  static Future<void> insertData(
    String name,
    String contact,
    String description,
  ) async {
    final db = await database;
    try {
      await db.insert("Student", {
        "name": name,
        "contact": contact,
        "description": description,
      });
    } catch (e) {
      print("data Inserts error:$e");
    }
  }

  static Future<List<Map<String, dynamic>>> viewData() async {
    final db = await database;
    return await db.query('Student');
  }
  static Future<void> deleteData(int id)async{
    final db= await database;
     await db.delete("Student",where: "id=?",whereArgs: [id]);
  }
  static Future<void> editData(int id , String name,String contact,String description)async{
    final db=await database;
    await db.update("Student",{
      "name":name,
      "contact":contact,
      "description":description,
    },conflictAlgorithm: ConflictAlgorithm.replace,where: 'id=?',whereArgs: [id] );
  }
}
