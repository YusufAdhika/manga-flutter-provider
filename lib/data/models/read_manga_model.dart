import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/read_manga.dart';

class ReadMangaModel extends Equatable {
  final String chapterImageLink;
  final int imageNumber;

  const ReadMangaModel(
      {required this.chapterImageLink, required this.imageNumber});

  factory ReadMangaModel.fromJson(Map<String, dynamic> json) => ReadMangaModel(
        chapterImageLink: json['chapter_image_link'],
        imageNumber: json['image_number'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_image_link'] = chapterImageLink;
    data['image_number'] = imageNumber;
    return data;
  }

  ReadManga toEntity() {
    return ReadManga(
      chapterImageLink: chapterImageLink,
      imageNumber: imageNumber,
    );
  }

  @override
  List<Object?> get props => [
        chapterImageLink,
        imageNumber,
      ];
}
