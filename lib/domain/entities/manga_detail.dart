import 'package:equatable/equatable.dart';

class MangaDetail extends Equatable {
  final String title;
  final String type;
  final String author;
  final String status;
  final String mangaEndpoint;
  final String thumb;
  final List<Genre> genreList;
  final String synopsis;
  final List<Chapter> chapter;

  const MangaDetail({
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
        chapter,
      ];
}

class Chapter extends Equatable {
  final String chapterTitle;
  final String chapterEndpoint;

  const Chapter({
    required this.chapterTitle,
    required this.chapterEndpoint,
  });

  @override
  List<Object?> get props => [
        chapterTitle,
        chapterEndpoint,
      ];
}

class Genre extends Equatable {
  final String genreName;

  const Genre({
    required this.genreName,
  });

  @override
  List<Object?> get props => [genreName];
}
