import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/manga.dart';

class MangaModel extends Equatable {
  final String title;
  final String type;
  final String thumb;
  final String endpoint;
  final String uploadOn;

  const MangaModel({
    required this.title,
    required this.type,
    required this.thumb,
    required this.endpoint,
    required this.uploadOn,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
        title: json['title'],
        type: json['type'],
        thumb: json['thumb'],
        endpoint: json['endpoint'],
        uploadOn: json['upload_on'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['thumb'] = thumb;
    data['endpoint'] = endpoint;
    data['upload_on'] = uploadOn;
    return data;
  }

  Manga toEntity() {
    return Manga(
      title: title,
      type: type,
      thumb: thumb,
      endpoint: endpoint,
      uploadOn: uploadOn,
    );
  }

  @override
  List<Object?> get props => [
        title,
        type,
        thumb,
        endpoint,
        uploadOn,
      ];
}
