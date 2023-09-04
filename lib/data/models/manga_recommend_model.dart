import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/manga_recommend.dart';

class MangaRecommendModel extends Equatable {
  final String title;
  final String thumb;
  final String endpoint;

  const MangaRecommendModel({
    required this.title,
    required this.thumb,
    required this.endpoint,
  });

  factory MangaRecommendModel.fromJson(Map<String, dynamic> json) =>
      MangaRecommendModel(
        title: json['title'],
        thumb: json['thumb'],
        endpoint: json['endpoint'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumb'] = thumb;
    data['endpoint'] = endpoint;
    return data;
  }

  MangaRecommend toEntity() {
    return MangaRecommend(
      title: title,
      thumb: thumb,
      endpoint: endpoint,
    );
  }

  @override
  List<Object?> get props => [
        title,
        thumb,
        endpoint,
      ];
}
