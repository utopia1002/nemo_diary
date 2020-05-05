import 'models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String Tablename = 'Diary';

class DBHelper{
  var _db;

  Future<Database> get database async{
    if(_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'diary.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE Diary("
              "id INTEGER PRIMARY KEY, content TEXT,"
              "boxnumber INTEGER, color INTEGER, date TEXT)"
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> createDiary(Diary diary) async{
    final db = await database;
    await db.insert(
      Tablename,
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Diary>> getDiary() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary');
    return List.generate(maps.length, (i){
      return Diary(
        id: maps[i]['id'],
        content: maps[i]['content'],
        boxnumber: maps[i]['boxnumber'],
        color: maps[i]['color'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> deleteDiary(int id) async{
    final db = await database;

    await db.delete(
      'diary',
      where: "id = ?",
      whereArgs: [id]
    );
  }
}