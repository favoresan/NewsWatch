import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/domain/usecase/popular_usecase.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

class PopularViewModel extends BaseViewModel
    with PopularViewModelInputs, PopularViewModelOutputs {
  StreamController popularStreamController =
      BehaviorSubject<List<ArticleData>>();

  PopularUseCase _popularUseCase;
  PopularViewModel(this._popularUseCase);

  @override
  void dispose() {
    popularStreamController.close();
  }

  @override
  void start() {
    _getPopularDetails();
  }

  _getPopularDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _popularUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
        stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
        message: failure.message,
      ));
    }, (details) {
      inputPopularDetails.add(details.article);
      inputState.add(ContentState());
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputPopularDetails => popularStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputPopularDetails =>
      popularStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await _popularUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputPopularDetails.add(details.article);
    });
  }
}

abstract class PopularViewModelInputs {
  void refresh();
  Sink get inputPopularDetails;
}

abstract class PopularViewModelOutputs {
  Stream<List<ArticleData>> get outputPopularDetails;
}
