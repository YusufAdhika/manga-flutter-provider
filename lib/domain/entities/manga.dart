import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  const Manga({
    required this.title,
    required this.type,
    required this.thumb,
    required this.endpoint,
    required this.uploadOn,
  });

  final String title;
  final String type;
  final String thumb;
  final String endpoint;
  final String? uploadOn;

  const Manga.watchlist({
    required this.title,
    required this.type,
    required this.thumb,
    required this.endpoint,
    this.uploadOn,
  });

  @override
  List<Object?> get props => [
        title,
        type,
        thumb,
        endpoint,
        uploadOn,
      ];
}
