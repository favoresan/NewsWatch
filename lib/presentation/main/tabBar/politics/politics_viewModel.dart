import 'dart:async';
import 'dart:ffi';

import 'package:news_watch/domain/usecase/politics_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

class PoliticsViewModel extends BaseViewModel
    with PoliticsViewModelInputs, PoliticsViewModelOutputs {
  StreamController politicsStreamController =
      BehaviorSubject<List<ArticleData>>();

  PoliticsUseCase politicsUseCase;
  PoliticsViewModel(this.politicsUseCase);

  @override
  void dispose() {
    politicsStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await politicsUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputPoliticsDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputPoliticsDetails => politicsStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputPoliticsDetails =>
      politicsStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await politicsUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputPoliticsDetails.add(details.article);
    });
  }
}

abstract class PoliticsViewModelInputs {
  void refresh();
  Sink get inputPoliticsDetails;
}

abstract class PoliticsViewModelOutputs {
  Stream<List<ArticleData>> get outputPoliticsDetails;
}
