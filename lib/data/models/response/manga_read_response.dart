import 'package:equatable/equatable.dart';
import 'package:read_manga/data/models/read_manga_model.dart';

class MangaReadResponse extends Equatable {
  final List<ReadMangaModel> readMangaModel;

  const MangaReadResponse({required this.readMangaModel});

  factory MangaReadResponse.fromJson(Map<String, dynamic> json) =>
      MangaReadResponse(
        readMangaModel: List<ReadMangaModel>.from(
          (json["chapter_image"] as List)
              .map((e) => ReadMangaModel.fromJson(e)),
        ),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_image'] = readMangaModel.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [readMangaModel];
}
