import 'package:equatable/equatable.dart';
import 'package:read_manga/data/models/manga_model.dart';

class MangaResponse extends Equatable {
  final List<MangaModel> manngaList;

  const MangaResponse({required this.manngaList});

  factory MangaResponse.fromJson(Map<String, dynamic> json) => MangaResponse(
        manngaList: List<MangaModel>.from(
          (json["manga_list"] as List).map((x) => MangaModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "manga_list": List<dynamic>.from(manngaList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [manngaList];
}
