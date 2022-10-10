import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:news_watch/domain/model/model.dart';
import 'package:news_watch/presentation/base/base_viewModel.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer.dart';
import 'package:news_watch/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../domain/usecase/science_usecase.dart';

class ScienceViewModel extends BaseViewModel
    with ScienceViewModelInputs, ScienceViewModelOutputs {
  StreamController scienceStreamController =
      BehaviorSubject<List<ArticleData>>();

  ScienceUseCase scienceUseCase;
  ScienceViewModel(this.scienceUseCase);

  @override
  void dispose() {
    scienceStreamController.close();
  }

  @override
  void start() {
    _getBusinessDetails();
  }

  _getBusinessDetails() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await scienceUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.message));
    }, (details) {
      inputState.add(ContentState());
      inputScienceDetails.add(details.article);
    });
  }

  @override
  // TODO: implement inputPopularDetails
  Sink get inputScienceDetails => scienceStreamController.sink;

  @override
  // TODO: implement outputPopularDetails
  Stream<List<ArticleData>> get outputScienceDetails =>
      scienceStreamController.stream.map((event) => event);

  @override
  void refresh() async {
    inputState
        .add(LoadingState(stateRendererType: StateRendererType.LOADING_STATE));
    (await scienceUseCase.executeIn(Void)).fold((failure) {
      inputState.add(ContentState());
    }, (details) {
      inputState.add(ContentState());
      inputScienceDetails.add(details.article);
    });
  }
}

abstract class ScienceViewModelInputs {
  void refresh();
  Sink get inputScienceDetails;
}

abstract class ScienceViewModelOutputs {
  Stream<List<ArticleData>> get outputScienceDetails;
}
