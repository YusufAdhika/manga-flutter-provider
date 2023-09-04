import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/read_manga.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetReadManga {
  final MangaRepository repository;

  GetReadManga(this.repository);

  Future<Either<Failure, List<ReadManga>>> execute(String id) {
    return repository.getReadManga(id);
  }
}
