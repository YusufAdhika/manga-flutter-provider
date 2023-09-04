import 'package:equatable/equatable.dart';

class Search extends Equatable {
  const Search({
    required this.title,
    required this.type,
    required this.thumb,
    required this.endpoint,
    required this.updateOn,
  });

  final String? title;
  final String? type;
  final String? thumb;
  final String? endpoint;
  final String? updateOn;

  @override
  List<Object?> get props => [
        title,
        type,
        thumb,
        endpoint,
        updateOn,
      ];
}
