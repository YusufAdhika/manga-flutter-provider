import 'package:equatable/equatable.dart';

class ReadManga extends Equatable {
  final String chapterImageLink;
  final int imageNumber;

  const ReadManga({
    required this.chapterImageLink,
    required this.imageNumber,
  });

  @override
  List<Object?> get props => [chapterImageLink, imageNumber];
}
