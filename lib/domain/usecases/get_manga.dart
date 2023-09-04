import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetListManga {
  final MangaRepository repository;

  GetListManga(this.repository);

  Future<Either<Failure, List<Manga>>> execute(int page) {
    return repository.getManga(page);
  }
}