import 'dart:async';
import 'dart:ffi';
import 'package:news_watch/domain/usecase/sport_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

class SportViewModel extends BaseViewModel
    with SportViewModelInputs, SportViewModelOutputs {
  StreamController sportStreamController = BehaviorSubject<List<ArticleData>>();

  SportUseCase sportUseCase;
  SportViewModel(this.sportUseCase);

  @override
  void dispose() {
    sportStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await sportUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputSportDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputSportDetails => sportStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputSportDetails =>
      sportStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await sportUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputSportDetails.add(details.article);
    });
  }
}

abstract class SportViewModelInputs {
  void refresh();
  Sink get inputSportDetails;
}

abstract class SportViewModelOutputs {
  Stream<List<ArticleData>> get outputSportDetails;
}
