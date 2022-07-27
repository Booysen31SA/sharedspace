import 'package:sharedspace/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating a new Database");

          return db.execute("CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title STRING, note TEXT, date STRING, "
              "startTime STRING, endTime STRING, "
              "remind INTERGER, repeat STRING, "
              "color INTEGER, "
              "isCompleted INTEGER, userid STRING)");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insertTask(Task? task) async {
    print("Inserting Task");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }
}
