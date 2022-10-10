import 'dart:async';

import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/model/model.dart';
import '../../../../domain/usecase/search_usecase.dart';
import '../../../common/freezed/freezed_data_class.dart';

class SearchViewModel extends BaseViewModel
    with SearchViewModelInputs, SearchViewModelOutputs {
  StreamController searchStreamController =
      BehaviorSubject<List<ArticleData>>();

  var searchObject = SearchObject('');

  SearchUseCase _searchUseCase;
  SearchViewModel(this._searchUseCase);

  @override
  void dispose() {
    searchStreamController.close();
  }

  @override
  void start() {
    _search();
  }

  _search() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _searchUseCase.execute(SearchUseCaseInput(searchObject.search)))
        .fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.ERROR_STATE,
          message: failure.message));
    }, (result) {
      inputSearch.add(result.article);
      inputState.add(ContentState());
    });
  }

  @override
  // TODO: implement inputSearch
  Sink get inputSearch => searchStreamController.sink;

  @override
  // TODO: implement outputSearch
  Stream<List<ArticleData>> get outputSearch =>
      searchStreamController.stream.map((event) => event);

  @override
  setSearch(String search) {
    if (search.length >= 3 && search.isNotEmpty) {
      searchObject = searchObject.copyWith(search: search);
    }
  }
}

abstract class SearchViewModelInputs {
  Sink get inputSearch;
  setSearch(String search);
}

abstract class SearchViewModelOutputs {
  Stream<List<ArticleData>> get outputSearch;
}
