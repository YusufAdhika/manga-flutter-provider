import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';

class MangaTable extends Equatable {
  final String endpoint;
  final String? title;
  final String? thumb;
  final String? type;

  const MangaTable({
    required this.endpoint,
    required this.title,
    required this.thumb,
    required this.type,
  });

  factory MangaTable.fromEntity(MangaDetail movie) => MangaTable(
        endpoint: movie.mangaEndpoint,
        title: movie.title,
        thumb: movie.thumb,
        type: movie.type,
      );

  factory MangaTable.fromMap(Map<String, dynamic> map) => MangaTable(
        endpoint: map['endpoint'],
        title: map['title'],
        thumb: map['thumb'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'endpoint': endpoint,
        'title': title,
        'thumb': thumb,
        'type': type,
      };

  Manga toEntity() => Manga.watchlist(
        endpoint: endpoint,
        type: type.toString(),
        thumb: thumb.toString(),
        title: title.toString(),
      );

  @override
  List<Object?> get props => [endpoint, title, thumb, type];
}
