import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/read_manga.dart';
import 'package:read_manga/domain/usecases/get_read_manga.dart';

class ReadMangaNotifier extends ChangeNotifier {
  var _readListManga = <ReadManga>[];
  List<ReadManga> get readListManga => _readListManga;

  RequestState _readMangaState = RequestState.empty;
  RequestState get readMangaState => _readMangaState;

  String _message = '';
  String get message => _message;

  ReadMangaNotifier({required this.getReadManga});

  final GetReadManga getReadManga;

  Future<void> fetchListReadManga(String id) async {
    _readMangaState = RequestState.loading;
    notifyListeners();

    final result = await getReadManga.execute(id);
    result.fold(
      (failure) {
        log(failure.toString());
        _readMangaState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (mangaData) {
        log(mangaData.length.toString());
        _readMangaState = RequestState.loaded;
        _readListManga = mangaData;
        notifyListeners();
      },
    );
  }
}
