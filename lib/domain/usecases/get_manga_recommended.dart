import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/manga_recommend.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetMangaRecommend {
  final MangaRepository repository;

  GetMangaRecommend(this.repository);

  Future<Either<Failure, List<MangaRecommend>>> execute() {
    return repository.getMangaRecommend();
  }
}
