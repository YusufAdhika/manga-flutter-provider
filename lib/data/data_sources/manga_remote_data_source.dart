import 'dart:convert';
import 'dart:developer';

import 'package:read_manga/common/exception.dart';
import 'package:read_manga/data/models/manga_detail_model.dart';
import 'package:read_manga/data/models/manga_model.dart';
import 'package:http/http.dart' as http;
import 'package:read_manga/data/models/manga_recommend_model.dart';
import 'package:read_manga/data/models/read_manga_model.dart';
import 'package:read_manga/data/models/response/manga_read_response.dart';
import 'package:read_manga/data/models/response/manga_recommended_response.dart';
import 'package:read_manga/data/models/response/manga_response.dart';
import 'package:read_manga/data/models/response/search_response.dart';
import 'package:read_manga/data/models/search_model.dart';

abstract class MangaRemoteDataSource {
  Future<List<MangaModel>> getManga(int page);
  Future<MangaDetailModel> getMangaDetail(String id);
  Future<List<MangaRecommendModel>> getMangaRecommend();
  Future<List<ReadMangaModel>> getReadManga(String id);
  Future<List<SearchModel>> getSearch(String query);
}

class MangaRemoteDataSourceImpl implements MangaRemoteDataSource {
  static const url = 'http://10.0.2.2:3000/api';

  final http.Client client;

  MangaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MangaModel>> getManga(int page) async {
    final response = await client.get(
      Uri.parse('$url/manga/popular/$page'),
    );

    if (response.statusCode == 200) {
      return MangaResponse.fromJson(json.decode(response.body)).manngaList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MangaDetailModel> getMangaDetail(String id) async {
    final response = await client.get(
      Uri.parse('$url/manga/detail/$id'),
    );

    if (response.statusCode == 200) {
      return MangaDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MangaRecommendModel>> getMangaRecommend() async {
    final response = await client.get(
      Uri.parse('$url/recommended'),
    );

    if (response.statusCode == 200) {
      return MangaRecommendedResponse.fromJson(json.decode(response.body))
          .mangaRecommendModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ReadMangaModel>> getReadManga(String id) async {
    final response = await client.get(
      Uri.parse('$url/chapter/$id'),
    );

    if (response.statusCode == 200) {
      return MangaReadResponse.fromJson(json.decode(response.body))
          .readMangaModel;
    } else {
      log("error");
      throw ServerException();
    }
  }

  @override
  Future<List<SearchModel>> getSearch(String query) async {
    final response = await client.get(
      Uri.parse('$url/search/$query'),
    );

    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body)).searchList;
    } else {
      throw ServerException();
    }
  }
}
