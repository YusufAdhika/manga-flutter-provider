import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:read_manga/common/exception.dart';
import 'package:read_manga/common/failure.dart';
import 'package:read_manga/data/data_sources/manga_local_data_source.dart';
import 'package:read_manga/data/data_sources/manga_remote_data_source.dart';
import 'package:read_manga/data/models/manga_table_model.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/domain/entities/manga_recommend.dart';
import 'package:read_manga/domain/entities/read_manga.dart';
import 'package:read_manga/domain/entities/search.dart';
import 'package:read_manga/domain/repositories/manga_repository.dart';

class MangaRepositoryImpl implements MangaRepository {
  final MangaRemoteDataSource remoteDataSource;
  final MangaLocalDataSource localDataSource;

  MangaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Manga>>> getManga(int page) async {
    try {
      final result = await remoteDataSource.getManga(page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MangaDetail>> getMangaDetail(String id) async {
    try {
      final result = await remoteDataSource.getMangaDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MangaRecommend>>> getMangaRecommend() async {
    try {
      final result = await remoteDataSource.getMangaRecommend();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<ReadManga>>> getReadManga(String id) async {
    try {
      final result = await remoteDataSource.getReadManga(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Search>>> getSearch(String query) async {
    try {
      final result = await remoteDataSource.getSearch(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmark(MangaDetail manga) async {
    try {
      final result = await localDataSource.insert(MangaTable.fromEntity(manga));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeBookmark(MangaDetail manga) async {
    try {
      final result = await localDataSource.remove(MangaTable.fromEntity(manga));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToBookmark(String endpoint) async {
    final result = await localDataSource.getById(endpoint);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Manga>>> getListBookmark() async {
    final result = await localDataSource.getBookmark();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
