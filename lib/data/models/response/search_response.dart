import 'package:equatable/equatable.dart';
import 'package:read_manga/data/models/search_model.dart';

class SearchResponse extends Equatable {
  final List<SearchModel> searchList;

  const SearchResponse({required this.searchList});

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        searchList: List<SearchModel>.from(
          (json["manga_list"] as List).map((x) => SearchModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "manga_list": List<dynamic>.from(searchList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [searchList];
}
