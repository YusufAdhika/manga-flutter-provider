import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/usecases/get_bookmark_manga.dart';

class BookmarkMangaNotifier extends ChangeNotifier {
  var _bookmarkManga = <Manga>[];
  List<Manga> get bookmarkManga => _bookmarkManga;

  var _bookmarkState = RequestState.empty;
  RequestState get bookmarkState => _bookmarkState;

  String _message = '';
  String get message => _message;

  BookmarkMangaNotifier({required this.getBookmarkManga});

  final GetBookmarklistManga getBookmarkManga;

  Future<void> fetchBookmarkManga() async {
    _bookmarkState = RequestState.loading;
    notifyListeners();

    final result = await getBookmarkManga.execute();
    result.fold(
      (failure) {
        _bookmarkState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (manga) {
        log("length ${manga.length}");
        _bookmarkState = RequestState.loaded;
        _bookmarkManga = manga;
        notifyListeners();
      },
    );
  }
}
