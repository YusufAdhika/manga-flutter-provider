import 'package:equatable/equatable.dart';

class MangaRecommend extends Equatable {
  final String title;
  final String thumb;
  final String endpoint;

  const MangaRecommend({
    required this.title,
    required this.thumb,
    required this.endpoint,
  });

  @override
  List<Object?> get props => [
        title,
        thumb,
        endpoint,
      ];
}
