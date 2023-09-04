import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/search.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetSearch {
  final MangaRepository repository;

  GetSearch(this.repository);

  Future<Either<Failure, List<Search>>> execute(String query) {
    return repository.getSearch(query);
  }
}
