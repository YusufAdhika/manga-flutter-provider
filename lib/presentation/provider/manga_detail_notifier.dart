import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/domain/usecases/get_bookmark_status.dart';
import 'package:read_manga/domain/usecases/get_manga_detail.dart';
import 'package:read_manga/domain/usecases/remove_bookmark.dart';
import 'package:read_manga/domain/usecases/save_bookmark.dart';

class MangaDetailNotifier extends ChangeNotifier {
  static const bookmarkAddSuccessMessage = 'Added to Bookmark';
  static const bookmarkRemoveSuccessMessage = 'Removed from Bookmark';

  late MangaDetail _mangaDetail;
  MangaDetail get listManga => _mangaDetail;

  RequestState _mangaDetailState = RequestState.empty;
  RequestState get mangaDetailState => _mangaDetailState;

  String _message = '';
  String get message => _message;

  MangaDetailNotifier({
    required this.getMangaDetail,
    required this.saveBookmark,
    required this.getBookmarkListStatus,
    required this.removefromBookmark,
  });

  final GetMangaDetail getMangaDetail;
  final SaveBookmark saveBookmark;
  final GetBookmarkListStatus getBookmarkListStatus;
  final RemoveBookmark removefromBookmark;

  Future<void> fetchMovieDetail(String id) async {
    _mangaDetailState = RequestState.loading;
    notifyListeners();
    final detailResult = await getMangaDetail.execute(id);
    detailResult.fold(
      (failure) {
        _mangaDetailState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _mangaDetailState = RequestState.loaded;
        _mangaDetail = movie;
        notifyListeners();
      },
    );
  }

  String _bookmarkMessage = '';
  String get bookmarkMessage => _bookmarkMessage;
  bool _isAddedtoBookmark = false;
  bool get isAddedToBookmark => _isAddedtoBookmark;

  Future<void> addBookmark(MangaDetail movie) async {
    final result = await saveBookmark.execute(movie);

    await result.fold(
      (failure) async {
        _bookmarkMessage = failure.message;
      },
      (successMessage) async {
        _bookmarkMessage = successMessage;
      },
    );

    await loadBookmarkStatus(movie.mangaEndpoint);
  }

  Future<void> removedBookmark(MangaDetail movie) async {
    final result = await removefromBookmark.execute(movie);

    await result.fold(
      (failure) async {
        _bookmarkMessage = failure.message;
      },
      (successMessage) async {
        _bookmarkMessage = successMessage;
      },
    );

    await loadBookmarkStatus(movie.mangaEndpoint);
  }

  Future<void> loadBookmarkStatus(String endpoint) async {
    final result = await getBookmarkListStatus.execute(endpoint);
    _isAddedtoBookmark = result;
    notifyListeners();
  }
}
