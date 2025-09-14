import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'lecture_model.dart';

class LectureRepo {
  static final LectureRepo _singleton = LectureRepo._internal();
  factory LectureRepo() => _singleton;
  LectureRepo._internal();
  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'demo.db');
    return openDatabase(path, version: 1, onCreate: (db, _) async {
      await db.execute('''
        CREATE TABLE lectures(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT, type TEXT, doctor TEXT,
          startTime TEXT, place TEXT, day TEXT)
      ''');
    });
  }

  Future<int> insert(Lecture lec) async =>
      await (await database).insert('lectures', lec.toMap());

  Future<List<Lecture>> fetchAll() async {
    final maps = await (await database).query('lectures', orderBy: 'startTime');
    return maps.map((m) => Lecture.fromMap(m)).toList();
  }

  Future<int> delete(int id) async =>
      await (await database).delete('lectures', where: 'id=?', whereArgs: [id]);
}
