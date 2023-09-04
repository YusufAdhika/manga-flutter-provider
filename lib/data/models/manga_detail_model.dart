import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';

class MangaDetailModel extends Equatable {
  final String title;
  final String type;
  final String author;
  final String status;
  final String mangaEndpoint;
  final String thumb;
  final List<GenreList> genreList;
  final String synopsis;
  final List<ChapterList> chapter;

  const MangaDetailModel({
    required this.title,
    required this.type,
    required this.author,
    required this.status,
    required this.mangaEndpoint,
    required this.thumb,
    required this.genreList,
    required this.synopsis,
    required this.chapter,
  });

  factory MangaDetailModel.fromJson(Map<String, dynamic> json) =>
      MangaDetailModel(
        title: json['title'],
        type: json['type'],
        author: json['author'],
        status: json['status'],
        mangaEndpoint: json['manga_endpoint'],
        thumb: json['thumb'],
        genreList: List<GenreList>.from(
          json["genre_list"].map(
            (x) => GenreList.fromJson(x),
          ),
        ),
        synopsis: json['synopsis'],
        chapter: List<ChapterList>.from(
          json["chapter"].map(
            (x) => ChapterList.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['author'] = author;
    data['status'] = status;
    data['manga_endpoint'] = mangaEndpoint;
    data['thumb'] = thumb;

    data['genre_list'] = genreList.map((v) => v.toJson()).toList();
    data['synopsis'] = synopsis;
    data['chapter'] = chapter.map((v) => v.toJson()).toList();
    return data;
  }

  MangaDetail toEntity() {
    return MangaDetail(
      title: title,
      type: type,
      author: author,
      status: status,
      mangaEndpoint: mangaEndpoint,
      thumb: thumb,
      genreList: genreList.map((genre) => genre.toEntity()).toList(),
      synopsis: synopsis,
      chapter: chapter.map((data) => data.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        title,
        type,
        author,
        status,
        mangaEndpoint,
        thumb,
        genreList,
        synopsis,
        chapter
      ];
}

class GenreList extends Equatable {
  final String genreName;

  const GenreList({required this.genreName});

  factory GenreList.fromJson(Map<String, dynamic> json) =>
      GenreList(genreName: json["genre_name"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genre_name'] = genreName;
    return data;
  }

  Genre toEntity() {
    return Genre(genreName: genreName);
  }

  @override
  List<Object?> get props => [genreName];
}

class ChapterList {
  String chapterTitle;
  String chapterEndpoint;

  ChapterList({
    required this.chapterTitle,
    required this.chapterEndpoint,
  });

  factory ChapterList.fromJson(Map<String, dynamic> json) => ChapterList(
        chapterTitle: json['chapter_title'],
        chapterEndpoint: json['chapter_endpoint'],
      );

  Chapter toEntity() {
    return Chapter(
      chapterTitle: chapterTitle,
      chapterEndpoint: chapterEndpoint,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_title'] = chapterTitle;
    data['chapter_endpoint'] = chapterEndpoint;
    return data;
  }
}
