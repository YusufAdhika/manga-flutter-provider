import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga.dart';
import 'package:read_manga/domain/usecases/get_manga.dart';

class MangaNotifier extends ChangeNotifier {
  final _listManga = List<Manga>.empty(growable: true);
  List<Manga> get listManga => _listManga;

  RequestState _mangaState = RequestState.empty;
  RequestState get listMangaState => _mangaState;

  String _message = '';
  String get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MangaNotifier({required this.getListManga});

  final GetListManga getListManga;

  var currentPageNumber = 1;

  Future<void> fetchNextManga() async {
    currentPageNumber++;
    _isLoading = true;
    notifyListeners();

    final result = await getListManga.execute(currentPageNumber);
    result.fold(
      (failure) {
        _mangaState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (mangaData) {
        if (mangaData.isEmpty) {
          _mangaState = RequestState.loaded;
          log("message");
        } else {
          _mangaState = RequestState.loaded;
          _listManga.addAll(mangaData);
          _isLoading = false;
          log("${_listManga.length} list manga all");
          notifyListeners();
        }
      },
    );
  }

  Future<void> fetchListManga() async {
    _mangaState = RequestState.loading;
    notifyListeners();

    final result = await getListManga.execute(currentPageNumber);
    result.fold(
      (failure) {
        _mangaState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (mangaData) {
        _mangaState = RequestState.loaded;
        _listManga.addAll(mangaData);
        currentPageNumber++;
        notifyListeners();
      },
    );
  }
}
