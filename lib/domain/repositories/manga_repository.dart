import 'package:dartz/dartz.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/domain/entities/manga_recommend.dart';
import 'package:read_manga/domain/entities/read_manga.dart';

abstract class MangaRepository {
  Future<Either<Failure, List<Manga>>> getManga(int page);
  Future<Either<Failure, MangaDetail>> getMangaDetail(String id);
  Future<Either<Failure, List<MangaRecommend>>> getMangaRecommend();
  Future<Either<Failure, List<ReadManga>>> getReadManga(String id);
}
