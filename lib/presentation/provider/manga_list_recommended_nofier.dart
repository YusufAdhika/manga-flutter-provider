import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/manga_recommend.dart';
import 'package:read_manga/domain/usecases/get_manga_recommended.dart';

class MangaRecommendedNotifier extends ChangeNotifier {
  var _listRecommended = <MangaRecommend>[];
  List<MangaRecommend> get listRecommended => _listRecommended;

  RequestState _recommendedState = RequestState.empty;
  RequestState get recommendedState => _recommendedState;

  String _message = '';
  String get message => _message;

  MangaRecommendedNotifier({required this.getMangaRecommend});

  final GetMangaRecommend getMangaRecommend;

  Future<void> fetchListRecommended() async {
    _recommendedState = RequestState.loading;
    notifyListeners();

    final result = await getMangaRecommend.execute();
    result.fold(
      (failure) {
        _recommendedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (mangaData) {
        _recommendedState = RequestState.loaded;
        _listRecommended = mangaData;
        notifyListeners();
      },
    );
  }
}
