import 'package:read_manga/data/models/manga_table_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _bookmark = 'bookmark';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/manga.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_bookmark (
        endpoint TEXT PRIMARY KEY,
        title TEXT,
        type TEXT,
        thumb TEXT
      );
    ''');
  }

  Future<int> insert(MangaTable movie) async {
    final db = await database;
    return await db!.insert(_bookmark, movie.toJson());
  }

  Future<int> remove(MangaTable movie) async {
    final db = await database;
    return await db!.delete(
      _bookmark,
      where: 'endpoint = ?',
      whereArgs: [movie.endpoint],
    );
  }

  Future<Map<String, dynamic>?> getById(String endpoint) async {
    final db = await database;
    final results = await db!.query(
      _bookmark,
      where: 'endpoint = ?',
      whereArgs: [endpoint],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_bookmark);

    return results;
  }
}
