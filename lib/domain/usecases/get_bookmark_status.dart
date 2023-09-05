import 'package:read_manga/domain/repositories/manga_repository.dart';

class GetBookmarkListStatus {
  final MangaRepository repository;

  GetBookmarkListStatus(this.repository);

  Future<bool> execute(String endpoint) async {
    return repository.isAddedToBookmark(endpoint);
  }
}
