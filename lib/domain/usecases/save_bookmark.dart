import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class SaveBookmark {
  final MangaRepository repository;

  SaveBookmark(this.repository);

  Future<Either<Failure, String>> execute(MangaDetail movie) {
    return repository.saveBookmark(movie);
  }
}
