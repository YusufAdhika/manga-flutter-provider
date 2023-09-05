import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetBookmarklistManga {
  final MangaRepository _repository;

  GetBookmarklistManga(this._repository);

  Future<Either<Failure, List<Manga>>> execute() {
    return _repository.getListBookmark();
  }
}
