import 'package:flutter/material.dart';
import 'package:read_manga/common/state_enum.dart';
import 'package:read_manga/domain/entities/search.dart';
import 'package:read_manga/domain/usecases/get_search.dart';

class SearchNotifier extends ChangeNotifier {
  List<Search> _listSearch = [];
  List<Search> get listSearch => _listSearch;

  RequestState _searchState = RequestState.empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  SearchNotifier({required this.getSearch});

  final GetSearch getSearch;

  Future<void> goSearch(String query) async {
    _searchState = RequestState.loading;
    notifyListeners();

    final result = await getSearch.execute(query);
    result.fold(
      (failure) {
        _searchState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (searchData) {
        _searchState = RequestState.loaded;
        _listSearch = searchData;
        notifyListeners();
      },
    );
  }
}
