import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga_detail.dart';
import 'package:read_manga/domain/usecases/get_manga_detail.dart';

class MangaDetailNotifier extends ChangeNotifier {
  late MangaDetail _mangaDetail;
  MangaDetail get listManga => _mangaDetail;

  RequestState _mangaDetailState = RequestState.empty;
  RequestState get mangaDetailState => _mangaDetailState;

  String _message = '';
  String get message => _message;

  MangaDetailNotifier({required this.getMangaDetail});

  final GetMangaDetail getMangaDetail;

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
}
