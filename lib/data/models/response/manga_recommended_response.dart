import 'package:equatable/equatable.dart';
import 'package:read_manga/data/models/manga_recommend_model.dart';

class MangaRecommendedResponse extends Equatable {
  final List<MangaRecommendModel> mangaRecommendModel;

  const MangaRecommendedResponse({required this.mangaRecommendModel});

  factory MangaRecommendedResponse.fromJson(Map<String, dynamic> json) =>
      MangaRecommendedResponse(
        mangaRecommendModel: List<MangaRecommendModel>.from(
          (json["manga_list"] as List).map(
            (e) => MangaRecommendModel.fromJson(e),
          ),
        ),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manga_list'] = mangaRecommendModel.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [mangaRecommendModel];
}
