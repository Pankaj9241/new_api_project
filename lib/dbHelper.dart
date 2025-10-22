import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;
  Future<Database?> dataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "My DAtabase.db");
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
  database create table(int id primary key),
  name text;
  age integer
  ''');
      },
    );
    return database;
  }

  insertData() async {
    Database? db = await database;
    db!.insert("Database create Table", {
      'id': 1,
      'name': 'pankaj',
      "age": 20,
    });
  }
  redData()async{
    Database? db = await database;
    final list=db!.query("database create table");

  }
}
