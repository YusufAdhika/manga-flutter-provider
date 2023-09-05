import 'package:read_manga/common/exception.dart';
import 'package:read_manga/data/data_sources/db/database_helper.dart';
import 'package:read_manga/data/models/manga_table_model.dart';

abstract class MangaLocalDataSource {
  Future<String> insert(MangaTable manga);
  Future<String> remove(MangaTable manga);
  Future<MangaTable?> getById(String endpoint);
  Future<List<MangaTable>> getBookmark();
}

class MangaLocalDataSourceImpl implements MangaLocalDataSource {
  final DatabaseHelper databaseHelper;

  MangaLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<MangaTable>> getBookmark() async {
    final result = await databaseHelper.getBookmark();
    return result.map((data) => MangaTable.fromMap(data)).toList();
  }

  @override
  Future<MangaTable?> getById(String endpoint) async {
    final result = await databaseHelper.getById(endpoint);
    if (result != null) {
      return MangaTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> insert(MangaTable manga) async {
    try {
      await databaseHelper.insert(manga);
      return 'Added to Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> remove(MangaTable manga) async {
    try {
      await databaseHelper.remove(manga);
      return 'Removed from Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
