import 'package:equatable/equatable.dart';
import 'package:read_manga/domain/entities/search.dart';

class SearchModel extends Equatable {
  final String title;
  final String type;
  final String thumb;
  final String endpoint;
  final String updateOn;

  const SearchModel({
    required this.title,
    required this.type,
    required this.thumb,
    required this.endpoint,
    required this.updateOn,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        title: json['title'],
        type: json['type'],
        thumb: json['thumb'],
        endpoint: json['endpoint'],
        updateOn: json['updated_on'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['thumb'] = thumb;
    data['endpoint'] = endpoint;
    data['updated_on'] = updateOn;
    return data;
  }

  Search toEntity() {
    return Search(
      title: title,
      type: type,
      thumb: thumb,
      endpoint: endpoint,
      updateOn: updateOn,
    );
  }

  @override
  List<Object?> get props => [
        title,
        type,
        thumb,
        endpoint,
        updateOn,
      ];
}
